package com.arrowenergy.qcharge


import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant


class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(engine: FlutterEngine) {
        // register plugins
        GeneratedPluginRegistrant.registerWith(engine)
    }
}

