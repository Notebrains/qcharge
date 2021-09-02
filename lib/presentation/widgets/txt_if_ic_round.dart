import 'package:flutter/material.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';

class IfIconRound extends StatelessWidget {
  final String hint;
  final IconData icon;

  const IfIconRound({
    Key? key,
    required this.hint,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(34.0, 0, 34.0, 12),
        child: TextField(
          enabled: true,
          autocorrect: true,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Container(
              margin: EdgeInsets.only(right: 12),
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                color: AppColor.grey,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Icon(icon, color: Colors.white,), // Change this icon as per your requirement
            ),
            hintStyle: TextStyle(color: Colors.grey),
            filled: true,
            fillColor: AppColor.grey.withOpacity(0.8),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              //borderSide: BorderSide(color: AppColor.border, width: 1),
            ),
          ),
        ));
  }
}
