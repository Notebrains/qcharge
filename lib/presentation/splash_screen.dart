import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.app_bg,
      body: Center(
        child: Lottie.asset(
          'assets/animations/lottiefiles/splash_screen_video_lottie.json',
          width: 300,
          height: 300,
          repeat: true,
          animate: true,
        ),
      ),
    );
  }
}

class Init {
  Init._();

  static final instance = Init._();

  Future initialize() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    await Future.delayed(const Duration(seconds: 6));
  }
}
