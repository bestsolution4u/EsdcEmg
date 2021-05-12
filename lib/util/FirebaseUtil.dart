
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:esdc_emg/config/pref_params.dart';
import 'package:esdc_emg/util/preference_helper.dart';

class FirebaseUtil {

  static Future<void> setupDeviceID() async {
    var deviceInfo = DeviceInfoPlugin();
    String id = "";
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      id = iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      id = androidDeviceInfo.androidId; // unique ID on Android
    }
    await PreferenceHelper.setString(PrefParams.DEVICE_ID, id);
  }
}