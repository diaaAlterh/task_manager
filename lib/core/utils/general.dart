import 'dart:io';

import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast(
    {required String message,
    bool vibrate = true,
    bool isErrorMessage = false}) {
  if (!Platform.environment.containsKey('FLUTTER_TEST')) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: isErrorMessage ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT);
  }
  if (isErrorMessage) {
    HapticFeedback.vibrate();
  } else {
    HapticFeedback.lightImpact();
  }
}
