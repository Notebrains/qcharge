import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:qcharge_flutter/common/constants/translation_constants.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';

class TxtTxtTxtRow extends StatelessWidget {
  final String text1;
  final String text2;
  final String text3;
  final String text4;
  final double size;
  final FontWeight fontWeight;
  final bool isTopUpTabSelected;

  const TxtTxtTxtRow({
    Key? key,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.text4,
    required this.size,
    required this.fontWeight,
    required this.isTopUpTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              text1,
              style:
              TextStyle( fontWeight: fontWeight, fontSize: size, color: AppColor.app_txt_white),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
            ),
          ),
        ),

        Expanded(
          flex: 1,
          child: Text(
            text2,
            style:
            TextStyle(fontWeight: fontWeight, fontSize: size, color: AppColor.app_txt_white),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
          ),
        ),

        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(right: 6),
            child: Text(
              text3,
              style:
              TextStyle(fontWeight: fontWeight, fontSize: size, color: AppColor.app_txt_white),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
            ),
          ),
        ),

        Visibility(
          visible: !isTopUpTabSelected,
          child: Expanded(
            flex: 1,
            child: Text(
              text4,
              style:
              TextStyle(fontWeight: fontWeight, fontSize: size, color: AppColor.app_txt_white),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
            ),
          ),
        ),
      ],
    );
  }
}