import 'package:feedback_app/features/auth/login_screen.dart';
import 'package:feedback_app/utils/service_locator.dart';
import 'package:feedback_app/utils/utils.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // initState() is a lifecycle method which will be the first method which will execute when a particular widget is being created.
  // NOTE: initState() is option. In order to make it execute, we have to use this method on the widget.
  @override
  void initState() {
    setup();
    Future.delayed(
      const Duration(
        seconds: 3,
      ),
      () async {
        sendToScreenTwo(context, LoginScreen());
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      body: Center(
        //AssetImageView is a custom widget which is created to show the logo and center is the widget which will show the image in the
        // center of the screen
        child: assetImageView('assets/images/logo.png', null, null),
      ),
    );
  }
}
