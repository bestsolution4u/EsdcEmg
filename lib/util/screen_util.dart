import 'dart:math';

import 'package:esdc_emg/config/global.dart';
import 'package:flutter/material.dart';

class ScreenUtil {
  static double calcTextScaleFactor(BuildContext context) {
    return min(MediaQuery.textScaleFactorOf(context), Globals.MAX_TEXT_SCALE_FACTOR);
  }
}