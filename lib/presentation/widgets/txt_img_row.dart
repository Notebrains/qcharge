import 'package:flutter/material.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';

class TxtImgRow extends StatelessWidget {
  final String txt;
  final Color txtColor;
  final double txtSize;
  final String img;
  const TxtImgRow({
    Key? key,
    required this.txt,
    required this.txtColor,
    required this.txtSize,
    required this.img,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.grey,
        borderRadius: BorderRadius.circular(6),
      ),
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            txt,
            style: TextStyle(fontSize: txtSize, color: txtColor),
            maxLines: 4,
            softWrap: false,
            overflow: TextOverflow.ellipsis,
          ),

          Image.asset(img, width: 100, height: 50,),
        ],
      ),
    );
  }
}