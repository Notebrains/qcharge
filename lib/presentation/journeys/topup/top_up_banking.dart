import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:qcharge_flutter/presentation/journeys/drawer/navigation_drawer.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/app_bar_home.dart';
import 'package:qcharge_flutter/presentation/widgets/button.dart';
import 'package:qcharge_flutter/presentation/widgets/txt.dart';
import 'package:qcharge_flutter/presentation/widgets/txt_ic_row.dart';
import 'package:qcharge_flutter/presentation/widgets/txt_img_row.dart';
import 'package:qcharge_flutter/presentation/widgets/txt_txt_txt_row.dart';

class TopUpBanking extends StatefulWidget {
  @override
  _TopUpBankingState createState() => _TopUpBankingState();
}

class _TopUpBankingState extends State<TopUpBanking> {
  bool isTopUpBankingTabSelected = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlideInUp(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 36, left: 20, bottom: 6),
              child: Txt(txt: 'Select Top Up Method', txtColor: Colors.white, txtSize: 14,
                fontWeight: FontWeight.normal, padding: 0, onTap: (){},
              ),
            ),

            TxtImgRow(txt: 'THAI QR', txtColor: AppColor.app_txt_white, txtSize: 16,
              img: 'assets/icons/pngs/create_account_logo.png',
            ),

            TxtImgRow(txt: 'CREDIT/DEBIT CARD', txtColor: AppColor.app_txt_white, txtSize: 16,
              img: 'assets/icons/pngs/crete_account_layer_mob_bank.png',
            ),

            TxtImgRow(txt: 'MOBILE BANKING', txtColor: AppColor.app_txt_white, txtSize: 16,
              img: 'assets/icons/pngs/crete_account_layer_mob_bank.png',
            ),
          ],
        ),
      ),
    );
  }
}
