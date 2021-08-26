import 'package:flutter/material.dart';
import 'package:qcharge_flutter/common/constants/size_constants.dart';
import 'package:qcharge_flutter/common/extensions/size_extensions.dart';

import 'switcher_btn.dart';
import 'txt.dart';

class IcTxtSwitch extends StatelessWidget{
  final String txt;
  final String img;
  final bool isSwitchOn;
  final bool isVisible;

  const IcTxtSwitch({Key? key, required this.txt, required this.img, required this.isSwitchOn, required this.isVisible}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 22, right: 22, top: 0),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(img, width: 30, height: 30,),

              Container(
                width: Sizes.dimen_250.w,
                child: Txt(txt: txt,
                  txtColor: Colors.white,
                  txtSize: 14,
                  fontWeight: FontWeight.normal,
                  padding: 8,
                  onTap: (){},
                ),
              ),

              CustomSwitch(
                value: isSwitchOn,
                onChanged: (bool val){

                },
              ),
            ],
          ),

          Visibility(
            visible: isVisible,
            child: Divider(
              color: Colors.white,
              thickness: 1,
              height: 22,
            ),
          ),
        ],
      ),


    );
  }

}