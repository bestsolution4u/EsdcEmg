import 'package:esdc_emg/api/http_manager.dart';

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
}