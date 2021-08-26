import 'package:flutter/material.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';

class ContainerTxt extends StatelessWidget {
  final String txt;
  final Color txtColor;
  final double txtSize;

  const ContainerTxt({
    Key? key,
    required this.txt,
    required this.txtColor,
    required this.txtSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColor.grey,
      ),
      child: Text(
        txt,
        style: TextStyle(fontWeight: FontWeight.normal, fontSize: txtSize, color: txtColor),
        maxLines: 2,
        softWrap: false,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
