import 'package:flutter/material.dart';
import 'package:qcharge_flutter/common/constants/size_constants.dart';
import 'package:qcharge_flutter/common/extensions/size_extensions.dart';

class IcIfRow extends StatelessWidget {
  final String txt;
  final Color txtColor;
  final double txtSize;
  final FontWeight fontWeight;
  final String icon;
  final Color icColor;
  final String hint;
  final TextInputType textInputType;
  final TextEditingController? controller;
  final bool obscureText;

  const IcIfRow({
    Key? key,
    required this.txt,
    required this.txtColor,
    required this.txtSize,
    required this.fontWeight,
    required this.icon,
    required this.icColor,
    required this.hint,
    required this.textInputType,
    required this.controller,
    required this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Image.asset(icon,
            width: 24,
            height: 24,
            color: icColor,
          ),
        ),

        Container(
          height: 50,
          width: Sizes.dimen_230.w,
          margin: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
          child: TextFormField(
            autocorrect: true,
            obscureText: obscureText,
            keyboardType: textInputType,
            controller: controller,
            //validator: validator,
            //onSaved: onSaved,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }
}
