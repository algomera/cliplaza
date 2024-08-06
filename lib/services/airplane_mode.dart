import 'package:flutter/services.dart';

class AirplaneMode {
  static const platform = MethodChannel('com.example/airplane_mode');

  static Future<bool> isAirplaneModeOn() async {
    try {
      final bool isAirplaneMode =
          await platform.invokeMethod('isAirplaneModeOn');
      return isAirplaneMode;
    } on PlatformException catch (e) {
      print("Failed to get airplane mode status: '${e.message}'.");
      return false;
    }
  }

  static void setupAirplaneModeListener(Function(bool) onAirplaneModeChanged) {
    platform.setMethodCallHandler((call) async {
      if (call.method == "airplaneModeChanged") {
        final bool isAirplaneModeOn = call.arguments as bool;
        onAirplaneModeChanged(isAirplaneModeOn);
      }
    });
  }
}
