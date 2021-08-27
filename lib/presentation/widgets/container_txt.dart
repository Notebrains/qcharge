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
      margin: EdgeInsets.only(top: 8, bottom: 8),
      padding: EdgeInsets.fromLTRB(12, 8, 12, 12),
      decoration: BoxDecoration(
        color: AppColor.grey,
        borderRadius: BorderRadius.all(Radius.circular(25)),
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
