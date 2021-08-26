import 'package:flutter/material.dart';

Widget TextFieldMapAddress({
  TextEditingController? controller,
  FocusNode? focusNode,
  String? label,
  String? hint,
  double? width,
  Icon? prefixIcon,
  Widget? suffixIcon,
  Function(String)? locationCallback,
}) {
  return Container(
    width: 250,
    child: TextField(
      onChanged: (value) {
        locationCallback!(value);
      },
      controller: controller,
      focusNode: focusNode,
      decoration: new InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          borderSide: BorderSide(
            color: Colors.grey.shade400,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          borderSide: BorderSide(
            color: Colors.greenAccent.shade700,
            width: 2,
          ),
        ),
        contentPadding: EdgeInsets.all(15),
        hintText: hint,
      ),
    ),
  );
}