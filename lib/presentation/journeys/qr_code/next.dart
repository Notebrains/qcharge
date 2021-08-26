import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in.dart';
import 'package:qcharge_flutter/common/constants/size_constants.dart';
import 'package:qcharge_flutter/common/extensions/size_extensions.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/button.dart';
import 'package:qcharge_flutter/presentation/widgets/container_txt.dart';


class Next extends StatelessWidget{
  final Function onTap;

  const Next({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ContainerTxt(txt: 'Left Socket', txtColor: AppColor.app_txt_white, txtSize: 12),
                  ContainerTxt(txt: 'AC Type: 2 , 22km', txtColor: AppColor.app_txt_white, txtSize: 12),
                ],
              ),

              Image.asset('assets/images/scan_qr_for_filter_9_next.png', height: Sizes.dimen_150.h, width: Sizes.dimen_120.w,),

              Column(
                children: [
                  ContainerTxt(txt: 'Right Socket', txtColor: AppColor.app_txt_white, txtSize: 12),

                  ContainerTxt(txt: 'DC Type: 2 , 22km', txtColor: AppColor.app_txt_white, txtSize: 12),
                ],
              ),
            ],
          ),


          Padding(
            padding: const EdgeInsets.all(36.0),
            child: Button(text: 'NEXT', bgColor: Colors.white, onPressed: (){
              onTap();
            },),
          ),
        ],
      ),
    );
  }

}