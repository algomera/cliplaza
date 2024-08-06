package com.example.cliplaza

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example/airplane_mode"
    private lateinit var methodChannel: MethodChannel

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)

        methodChannel.setMethodCallHandler { call, result ->
            if (call.method == "isAirplaneModeOn") {
                val isAirplaneModeOn = Settings.Global.getInt(
                    contentResolver, Settings.Global.AIRPLANE_MODE_ON, 0
                ) != 0
                result.success(isAirplaneModeOn)
            } else {
                result.notImplemented()
            }
        }

        // Register receiver to listen for airplane mode changes
        val filter = IntentFilter(Intent.ACTION_AIRPLANE_MODE_CHANGED)
        registerReceiver(airplaneModeReceiver, filter)
    }

    private val airplaneModeReceiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context?, intent: Intent?) {
            if (intent != null) {
                val isAirplaneModeOn = Settings.Global.getInt(
                    contentResolver, Settings.Global.AIRPLANE_MODE_ON, 0
                ) != 0
                methodChannel.invokeMethod("airplaneModeChanged", isAirplaneModeOn)
            }
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        unregisterReceiver(airplaneModeReceiver) // Unregister receiver to avoid memory leaks
    }
}
