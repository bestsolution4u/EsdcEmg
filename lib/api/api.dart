import 'package:esdc_emg/api/http_manager.dart';

class Api {
  static Future<dynamic> getMessageList() async {
    return await httpManager.get(url: "message");
  }
}