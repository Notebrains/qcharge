import 'package:flutter/material.dart';

import '../../common/constants/size_constants.dart';
import '../../common/extensions/size_extensions.dart';

class Button extends StatelessWidget {
  final String text;
  final Color bgColor;
  final Function() onPressed;

  const Button({
    Key? key,
    required this.text,
    required this.bgColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
        gradient: LinearGradient(begin: Alignment.centerRight, end: Alignment.centerLeft, colors: [
          Color(0xFFEFE07D),
          Color(0xFFB49839),
        ]),
      ),
      padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_8.w),
      margin: EdgeInsets.symmetric(vertical: Sizes.dimen_8.h),
      width: double.infinity,
      height: 45,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
