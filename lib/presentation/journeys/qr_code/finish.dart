import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:qcharge_flutter/common/constants/size_constants.dart';
import 'package:qcharge_flutter/common/constants/translation_constants.dart';
import 'package:qcharge_flutter/common/extensions/size_extensions.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/button.dart';
import 'package:qcharge_flutter/presentation/widgets/txt.dart';
import 'package:qcharge_flutter/presentation/widgets/txt_ic_row.dart';

class Finish extends StatelessWidget {
  final Function onTap;

  const Finish({Key? key, required this.onTap}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: SlideInRight(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 36, top: 100),
              child: Txt(txt: TranslationConstants.thanksForUsingServc.t(context), txtColor: Colors.white, txtSize: 18,
                  fontWeight: FontWeight.normal, padding: 0, onTap: (){}),
            ),

            Container(
              width: Sizes.dimen_280.w,
              padding: const EdgeInsets.all(24),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: AppColor.grey,
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImgTxtRow(
                    txt: '${TranslationConstants.date.t(context)} 14/12/21',
                    txtColor: AppColor.app_txt_white,
                    txtSize: 12,
                    fontWeight: FontWeight.normal,
                    icon: 'assets/icons/pngs/scan_qr_for_filter_17.png',
                    icColor: AppColor.app_txt_white,
                  ),
                  ImgTxtRow(
                    txt: TranslationConstants.unit.t(context),
                    txtColor: AppColor.app_txt_white,
                    txtSize: 12,
                    fontWeight: FontWeight.normal,
                    icon: 'assets/icons/pngs/scan_qr_for_filter_5.png',
                    icColor: AppColor.app_txt_white,
                  ),

                  ImgTxtRow(
                    txt: '${TranslationConstants.time.t(context)} 00:00:44',
                    txtColor: AppColor.app_txt_white,
                    txtSize: 12,
                    fontWeight: FontWeight.normal,
                    icon: 'assets/icons/pngs/scan_qr_for_filter_5.png',
                    icColor: AppColor.app_txt_white,
                  ),

                  ImgTxtRow(
                    txt: TranslationConstants.unit.t(context),
                    txtColor: AppColor.app_txt_white,
                    txtSize: 12,
                    fontWeight: FontWeight.normal,
                    icon: 'assets/icons/pngs/scan_qr_for_filter_4.png',
                    icColor: AppColor.app_txt_white,
                  ),

                  ImgTxtRow(
                    txt: TranslationConstants.price.t(context),
                    txtColor: AppColor.app_txt_white,
                    txtSize: 12,
                    fontWeight: FontWeight.normal,
                    icon: 'assets/icons/pngs/scan_qr_for_filter_3.png',
                    icColor: AppColor.app_txt_white,
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(36, Sizes.dimen_30.h, 36, 20),
              child: Button(
                text: TranslationConstants.finish.t(context),
                bgColor: Colors.white,
                onPressed: () {
                  onTap();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
