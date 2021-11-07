import 'package:flutter/material.dart';
import 'package:qcharge_flutter/common/constants/translation_constants.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';

class BoxTxt extends StatelessWidget {
  final String txt1;
  final String txt2;
  final String txt3;
  final double rightPadding;
  final double topPadding;
  final Function onTap;

  const BoxTxt({
    Key? key,
    required this.txt1,
    required this.txt2,
    required this.txt3,
    required this.rightPadding,
    required this.topPadding,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 100,
        margin: EdgeInsets.only(top: 34, right: rightPadding, bottom: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColor.grey,
          border: Border.all(color: AppColor.border, width: 0.3),
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        child: InkWell(
          onTap: (){
            onTap();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.maxFinite,
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade600,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
                ),
                child: Text(
                  txt1,
                  style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),

              Container(
                padding: EdgeInsets.only(left: 8, top: topPadding),
                child: Text(
                  txt2,
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 11, color: Colors.white),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 6),
                child: RichText(
                  text: TextSpan(
                    text: '',
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(text: txt3,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white)),
                      TextSpan(text: txt3 != TranslationConstants.view.t(context) ? TranslationConstants.thbMonth.t(context) : '',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Colors.white)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
