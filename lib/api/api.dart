import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esdc_emg/api/http_manager.dart';
import 'package:esdc_emg/config/global.dart';
import 'package:esdc_emg/model/vpn_status_model.dart';
import 'package:esdc_emg/model/youtube_video_model.dart';
import 'package:http/http.dart' as http;

class Api {
  static Future<dynamic> getMessageList() async {
    return await httpManager.get(url: "message");
  }

  static Future<List<VPNStatusModel>> getVPNStatus() async {
    try {
      List<dynamic> result = await httpManager.get(url: "vpn");
      List<VPNStatusModel> vpns = result.map((e) => VPNStatusModel.fromJson(e)).toList();
      return vpns;
    } catch (e) {
      return [];
    }
  }

  static Future<dynamic> submitFeedback({String name, String category, String feedback, String source}) async {
    return await httpManager.post(url: "feedback/", data: {
      "name": "zhong chen",
      "category": category,
      "feedback": feedback,
      "source": source
    });
  }

  static Future<List<YoutubeVideoModel>> fetchYoutubeVideos(String channelID) async {
    List<YoutubeVideoModel> videos = [];
    DateTime timestamp = DateTime.now();
    String dateTime = "${timestamp.year}-${timestamp.month}-${timestamp.day}";
    var firestore = FirebaseFirestore.instance;
    Map<String, dynamic> playlistJson = (await firestore.collection("playlist").doc("$channelID").get()).data() ?? {};
    if (playlistJson.isNotEmpty && playlistJson['updatedAt'] != null && playlistJson['updatedAt'] == dateTime) {
      List<dynamic> playlist = playlistJson['videos'];
      videos = playlist.map((e) => YoutubeVideoModel.fromFirebase(e)).toList();
      return videos;
    } else {
      List<YoutubeVideoModel> videos = await getYoutubePlaylist(channelID);
      List<Map<String, dynamic>> playlist = videos.map((e) => e.toJson()).toList();
      Map<String, dynamic> json = {
        'videos': playlist,
        'updatedAt': dateTime
      };
      await firestore.collection("playlist").doc("$channelID").set(json);
      return videos;
    }
  }

  static Future<List<YoutubeVideoModel>> getYoutubePlaylist(String channelID) async {
    List<YoutubeVideoModel> videos = [];
    final responseIDs = await http.get(Uri.parse('https://www.googleapis.com/youtube/v3/search?part=id&channelId=$channelID&maxResults=${Globals.YOUTUBE_VIDEO_COUNT}&order=date&type=video&key=${Globals.YOUTUBE_API_KEY}'));
    if (responseIDs.statusCode == 200) {
      Map<String, dynamic> resultJson = jsonDecode(responseIDs.body);
      List<String> itemIDs = [];
      List<dynamic> items = resultJson['items'];
      items.forEach((element) {itemIDs.add(element['id']['videoId']);});
      if (itemIDs.isNotEmpty) {
        final responseVideos = await http.get(Uri.parse('https://www.googleapis.com/youtube/v3/videos?id=${itemIDs.join(",")}&key=${Globals.YOUTUBE_API_KEY}&part=snippet,contentDetails,statistics,status'));
        List<dynamic> videoItems = jsonDecode(responseVideos.body)['items'];
        if (videoItems != null && videoItems.isNotEmpty) {
          videoItems.forEach((element) {videos.add(YoutubeVideoModel.fromJson(element));});
        }
      }
    }
    return videos;
  }
}