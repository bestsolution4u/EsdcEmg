import 'dart:convert';

import 'package:esdc_emg/api/http_manager.dart';
import 'package:esdc_emg/config/global.dart';
import 'package:esdc_emg/model/youtube_video_model.dart';
import 'package:http/http.dart' as http;

class Api {
  static Future<dynamic> getMessageList() async {
    return await httpManager.get(url: "message");
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
    print('----------- Channel ID ---------');
    print(channelID);
    List<YoutubeVideoModel> videos = [];
    final responseIDs = await http.get(Uri.parse('https://www.googleapis.com/youtube/v3/search?part=id&channelId=$channelID&maxResults=4&order=date&type=video&key=${Globals.YOUTUBE_API_KEY}'));
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