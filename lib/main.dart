import 'package:feedback_app/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

// By Pranav Kumar K on 8th Feb

/*
Info about Flutter:
Flutter is a cross platform SDK(software development kit) which helps developers to build native mobile apps, websites, desktop applications 
for mac, linux using single code base.

Requirements: 
1. Flutter SDK (version: 1.22.6)
2. Dart SDK
3. Android Studio 
*/

// main function is the main entry point for the app to start. The Widget declared inside the runApp method will be the first to render
// on the screen.

void main() {
  runApp(
    MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
    ),
  );
}
