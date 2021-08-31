import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qcharge_flutter/common/constants/translation_constants.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';
import 'package:qcharge_flutter/presentation/journeys/account/register.dart';
import 'package:qcharge_flutter/presentation/journeys/account/terms_condition.dart';
import 'package:qcharge_flutter/presentation/libraries/stepper.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/app_bar_home.dart';

import 'success.dart';
import 'verify.dart';


class AccountStepper extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarHome(context),
      //drawer: NavigationDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 34, bottom: 24),
            child: Text(
              TranslationConstants.createAc.t(context),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  //color: Colors.white,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColor.border,
                  decorationThickness: 2,
                  color: Colors.transparent,
                  shadows: [
                    Shadow(
                        color: Colors.white,
                        offset: Offset(0, -8))
                  ],
              ),
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: HorizontalStepper(
                selectedColor: AppColor.border,
                unSelectedColor: Colors.grey.shade400,
                leftBtnColor: const Color(0xffEA7F8B),
                rightBtnColor: const Color(0xFF4FE2C0),
                selectedOuterCircleColor: AppColor.border,
                type: Type.TOP,
                circleRadius: 24,
                onComplete: () {
                  print("completed");
                },
                textStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                btnTextColor: AppColor.app_txt_white,
                steps: [
                  HorizontalStep(
                    title: TranslationConstants.continueCaps.t(context),
                    widget: TermsAndCondition(),
                    state: HorizontalStepState.SELECTED,
                    isValid: true,
                  ),
                  HorizontalStep(
                    title: TranslationConstants.verify.t(context),
                    widget:  Verify(),
                    isValid: true,
                  ),
                  HorizontalStep(
                    title: TranslationConstants.register.t(context),
                    widget: Register(),
                    isValid: true,
                  ),
                  HorizontalStep(
                    title: TranslationConstants.success.t(context),
                    widget:  AccountSuccess(),
                    isValid: true,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}