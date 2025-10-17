import 'package:flutter/services.dart';
import 'package:nutri/widget/toasts.dart';

class BackPressHandler {
  static DateTime? _lastPressed;

  static Future<bool> handleBackPress() async {
    final now = DateTime.now();

    if (_lastPressed == null || now.difference(_lastPressed!) > const Duration(seconds: 2)) {
      _lastPressed = now;
      AppToast.info("Press back again to exit");
      return false;
    }

    SystemNavigator.pop();
    return false;
  }
}
