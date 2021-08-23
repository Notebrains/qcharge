import 'package:flutter/material.dart';

class Txt extends StatelessWidget {
  final String txt;
  final Color txtColor;
  final double txtSize;
  final FontWeight fontWeight;
  final double padding;
  final Function onTap;

  const Txt({
    Key? key,
    required this.txt,
    required this.txtColor,
    required this.txtSize,
    required this.fontWeight,
    required this.padding,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: InkWell(
        child: Text(
          txt,
          style: TextStyle(fontFamily: 'Roboto', fontWeight: fontWeight, fontSize: txtSize, color: txtColor),
          maxLines: 8,
          softWrap: false,
          overflow: TextOverflow.ellipsis,
        ),

        onTap: (){
          onTap();
        },
      ),
    );
  }
}
