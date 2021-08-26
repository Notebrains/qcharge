import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:qcharge_flutter/common/constants/size_constants.dart';
import 'package:qcharge_flutter/common/extensions/size_extensions.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/button.dart';
import 'package:qcharge_flutter/presentation/widgets/txt_ic_row.dart';

class Start extends StatelessWidget {
  final Function onTap;

  const Start({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlideInRight(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
                    txt: 'Charging time 00:00:00',
                    txtColor: AppColor.app_txt_white,
                    txtSize: 12,
                    fontWeight: FontWeight.normal,
                    icon: 'assets/icons/pngs/scan_qr_for_filter_5.png',
                    icColor: AppColor.app_txt_white,
                ),
                ImgTxtRow(
                    txt: 'Unit: 0 kWh',
                    txtColor: AppColor.app_txt_white,
                    txtSize: 12,
                    fontWeight: FontWeight.normal,
                    icon: 'assets/icons/pngs/scan_qr_for_filter_4.png',
                    icColor: AppColor.app_txt_white,
                ),

                ImgTxtRow(
                    txt: 'AC Type: 2 22km',
                    txtColor: AppColor.app_txt_white,
                    txtSize: 12,
                    fontWeight: FontWeight.normal,
                    icon: 'assets/icons/pngs/scan_qr_for_filter_10_charge_ac.png',
                    icColor: AppColor.app_txt_white,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/scan_qr_for_filter_9_next.png',
                height: Sizes.dimen_130.h,
                width: Sizes.dimen_110.w,
              ),
              Image.asset(
                'assets/icons/pngs/scan_qr_for_filter_6.png',
                height: Sizes.dimen_150.h,
                width: Sizes.dimen_250.w,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 36, right: 36, bottom: 36),
            child: Button(
              text: 'START',
              bgColor: Colors.white,
              onPressed: () {
                onTap();
              },
            ),
          ),
        ],
      ),
    );
  }
}
