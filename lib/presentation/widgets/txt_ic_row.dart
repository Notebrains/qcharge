import 'package:flutter/material.dart';

class TxtIcRow extends StatelessWidget {
  final String txt;
  final Color txtColor;
  final double txtSize;
  final FontWeight fontWeight;
  final IconData icon;
  final Color icColor;
  final bool isCenter;

  const TxtIcRow({
    Key? key,
    required this.txt,
    required this.txtColor,
    required this.txtSize,
    required this.fontWeight,
    required this.icon,
    required this.icColor,
    required this.isCenter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isCenter? MainAxisAlignment.center: MainAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 18,
          color: icColor,
        ),

        Padding(
          padding: const EdgeInsets.only(left: 5, top: 5, bottom: 5),
          child: Text(
            txt,
            style: TextStyle(fontFamily: 'Roboto', fontWeight: fontWeight, fontSize: txtSize, color: txtColor),
            maxLines: 4,
            softWrap: false,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
