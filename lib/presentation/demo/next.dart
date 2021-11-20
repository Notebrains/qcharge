import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in.dart';
import 'package:lottie/lottie.dart';
import 'package:qcharge_flutter/common/constants/size_constants.dart';
import 'package:qcharge_flutter/common/extensions/size_extensions.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/button.dart';
import 'package:qcharge_flutter/presentation/widgets/container_txt.dart';
import 'package:qcharge_flutter/common/constants/translation_constants.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';


class Next extends StatelessWidget{
  final Function onTap;

  const Next({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 56),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        ContainerTxt(txt: TranslationConstants.leftSocket.t(context), txtColor: AppColor.app_txt_white, txtSize: 12),

                        ContainerTxt(txt: TranslationConstants.acType.t(context), txtColor: AppColor.app_txt_white, txtSize: 12),
                      ],
                    ),
                  ),

                  Image.asset('assets/images/scan_qr_for_filter_9_next.png', height: Sizes.dimen_150.h,
                    width: Sizes.dimen_110.w,),

                  Expanded(
                    child: Column(
                      children: [
                        ContainerTxt(txt: TranslationConstants.rightSocket.t(context), txtColor: AppColor.app_txt_white, txtSize: 12),

                        ContainerTxt(txt: TranslationConstants.dcType.t(context), txtColor: AppColor.app_txt_white, txtSize: 12),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Center(
              child: Lottie.asset(
                'assets/animations/lottiefiles/charging_animation_lottie.json',
                height: Sizes.dimen_450.w,
                width: Sizes.dimen_450.w,
                repeat: true,
                animate: true,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(36.0),
              child: Button(text: TranslationConstants.next.t(context), bgColor: [Color(0xFFEFE07D), Color(0xFFB49839)], onPressed: (){
                onTap();
              },),
            ),
          ],
        ),
      ),
    );
  }

}