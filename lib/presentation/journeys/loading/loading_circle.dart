
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
        'assets/animations/lottiefiles/charge.json',
        repeat: true,
        animate: true,
      ),
    );
  }
}
