import 'package:flutter/material.dart';

class TxtWithWidth extends StatelessWidget {
  final String txt;
  final Color txtColor;
  final double txtSize;
  final double width;
  final FontWeight fontWeight;

  const TxtWithWidth({
    Key? key,
    required this.txt,
    required this.txtColor,
    required this.txtSize,
    required this.width,
    required this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        width: width,
        padding: const EdgeInsets.only(left: 3, top: 2, bottom: 2),
        child: Text(
          txt,
          style: TextStyle(fontFamily: 'Roboto', fontWeight: fontWeight, fontSize: txtSize, color: txtColor),
          maxLines: 4,
          softWrap: false,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
