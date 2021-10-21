import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:qcharge_flutter/data/models/top_up_api_res_model.dart';
import 'package:qcharge_flutter/di/get_it.dart';
import 'package:qcharge_flutter/presentation/blocs/home/wallet_recharge_cubit.dart';
import 'package:qcharge_flutter/presentation/journeys/drawer/navigation_drawer.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/app_bar_home.dart';
import 'package:qcharge_flutter/presentation/widgets/button.dart';
import 'package:qcharge_flutter/presentation/widgets/txt.dart';
import 'package:qcharge_flutter/presentation/widgets/txt_ic_row.dart';
import 'package:qcharge_flutter/presentation/widgets/txt_img_row.dart';
import 'package:qcharge_flutter/presentation/widgets/txt_txt_txt_row.dart';
import 'package:qcharge_flutter/common/constants/translation_constants.dart';
import 'package:qcharge_flutter/common/extensions/size_extensions.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';

class TopUpBanking extends StatefulWidget {

  const TopUpBanking({Key? key}) : super(key: key);

  @override
  _TopUpBankingState createState() => _TopUpBankingState();
}

class _TopUpBankingState extends State<TopUpBanking> {
  late WalletRechargeCubit walletRechargeCubit;

  bool isTopUpBankingTabSelected = false;


  @override
  void initState() {
    super.initState();

    walletRechargeCubit = getItInstance<WalletRechargeCubit>();
  }

  @override
  void dispose() {
    super.dispose();

    walletRechargeCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return SlideInUp(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 24, left: 20, bottom: 6),
            child: Txt(txt: TranslationConstants.selectTopUpMethod.t(context), txtColor: Colors.white, txtSize: 14,
              fontWeight: FontWeight.normal, padding: 0, onTap: (){},
            ),
          ),

          TxtImgRow(txt: TranslationConstants.thaiQr.t(context), txtColor: AppColor.app_txt_white, txtSize: 16,
            img: 'assets/icons/pngs/create_account_logo.png',
          ),

          TxtImgRow(txt: TranslationConstants.creditDebitCard.t(context), txtColor: AppColor.app_txt_white, txtSize: 16,
            img: 'assets/icons/pngs/crete_account_layer_mob_bank.png',
          ),

          TxtImgRow(txt: TranslationConstants.selectTopUpMethod.t(context), txtColor: AppColor.app_txt_white, txtSize: 16,
            img: 'assets/icons/pngs/crete_account_layer_mob_bank.png',
          ),
        ],
      ),
    );
  }
}
