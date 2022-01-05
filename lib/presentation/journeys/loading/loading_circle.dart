
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class LoadingCircle extends StatelessWidget {
  final double size;

  const LoadingCircle({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Lottie.asset(
        'assets/animations/lottiefiles/3_line_loading.json',
        width: size,
        height: size,
        repeat: true,
        animate: true,
      ),
    );
  }
}
