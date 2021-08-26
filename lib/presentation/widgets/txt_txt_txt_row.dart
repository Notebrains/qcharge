import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';

class TxtTxtTxtRow extends StatelessWidget {
  final String text1;
  final String text2;
  final String text3;
  final double size;
  final FontWeight fontWeight;

  const TxtTxtTxtRow({
    Key? key,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.size,
    required this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          text1,
          textAlign: TextAlign.start,
          style:
          TextStyle( fontWeight: fontWeight, fontSize: size, color: AppColor.app_txt_white),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
        ),

        Text(
          text2,
          textAlign: TextAlign.start,
          style:
          TextStyle(fontWeight: fontWeight, fontSize: size, color: AppColor.app_txt_white),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
        ),

        Text(
          text3,
          textAlign: TextAlign.start,
          style:
          TextStyle(fontWeight: fontWeight, fontSize: size, color: AppColor.app_txt_white),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
        ),
      ],
    );
  }
}