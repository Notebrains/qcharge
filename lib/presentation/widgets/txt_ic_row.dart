import 'package:flutter/material.dart';

class ImgTxtRow extends StatelessWidget {
  final String txt;
  final Color txtColor;
  final double txtSize;
  final FontWeight fontWeight;
  final String icon;
  final Color icColor;

  const ImgTxtRow({
    Key? key,
    required this.txt,
    required this.txtColor,
    required this.txtSize,
    required this.fontWeight,
    required this.icon,
    required this.icColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          icon,
          width: 18,
          height: 18,
          color: icColor,
        ),

        Padding(
          padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
          child: Text(
            txt,
            style: TextStyle(fontWeight: fontWeight, fontSize: txtSize, color: txtColor),
            maxLines: 4,
            softWrap: false,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
