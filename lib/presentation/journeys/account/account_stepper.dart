import 'package:flutter/material.dart';
import 'package:qcharge_flutter/common/constants/route_constants.dart';
import 'package:qcharge_flutter/common/constants/translation_constants.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';
import 'package:qcharge_flutter/presentation/journeys/account/register_screen.dart';
import 'package:qcharge_flutter/presentation/journeys/account/terms_condition.dart';
import 'package:qcharge_flutter/presentation/libraries/edge_alerts/edge_alerts.dart';
import 'package:qcharge_flutter/presentation/libraries/stepper.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/app_bar_home.dart';

import 'success.dart';
import 'verify.dart';

class AccountStepper extends StatefulWidget{
  @override
  _AccountStepperState createState() => _AccountStepperState();
}

class _AccountStepperState extends State<AccountStepper> {
  bool isTermConditionStepComplete = false;
  bool isVerifyStepComplete = false;
  bool isRegisterStepComplete = false;

  @override
  Widget build(BuildContext context) {

    ValueNotifier<int> _counter = ValueNotifier<int> (0);

    return Scaffold(
      appBar: appBarHome(context),
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
                  shadows: [Shadow(color: Colors.white, offset: Offset(0, -8))],
              ),
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          ValueListenableBuilder(
              valueListenable: _counter,
              builder: (context, value, child){
                return Text('');
              },
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: HorizontalStepper(
                selectedColor: AppColor.border,
                unSelectedColor: Colors.grey.shade400,
                leftBtnColor: const Color(0x4b4b4b),
                rightBtnColor: const Color(0x4b4b4b),
                selectedOuterCircleColor: AppColor.border,
                circleRadius: 24,
                onComplete: () {
                  if (isTermConditionStepComplete && isVerifyStepComplete && isRegisterStepComplete) {
                    Navigator.of(context).pushNamed(RouteList.initial);
                  } else if(!isTermConditionStepComplete){
                    edgeAlert(context, title: 'Warning', description: 'Please complete Terms & conditions step', gravity: Gravity.top);
                  } else if(!isVerifyStepComplete){
                    edgeAlert(context, title: 'Warning', description: 'Please complete verify step', gravity: Gravity.top);
                  } else if(!isRegisterStepComplete){
                    edgeAlert(context, title: 'Warning', description: 'Please complete registration process', gravity: Gravity.top);
                  }
                },
                textStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                btnTextColor: AppColor.app_txt_white,
                steps: [
                  HorizontalStep(
                    title: TranslationConstants.continueNotCaps.t(context),
                    widget: TermsAndCondition(isProcessCompleted: (){
                      print("isTermConditionStepComplete: $isTermConditionStepComplete");
                      setState(() {
                        isTermConditionStepComplete = true;
                      });
                    },),
                    state: HorizontalStepState.SELECTED,
                    isValid: true,
                  ),

                  HorizontalStep(
                    title: TranslationConstants.verify.t(context),
                    widget: Verify(isProcessCompleted: (){
                          print("isVerifyStepComplete: $isVerifyStepComplete");
                          setState(() {
                            isVerifyStepComplete = true;
                          });
                        }
                    ),
                    isValid: true,
                  ),

                  HorizontalStep(
                    title: TranslationConstants.register.t(context),
                    widget: RegisterScreen(isProcessCompleted: (){
                      print("isRegisterStepComplete: $isRegisterStepComplete");
                      setState(() {
                        isRegisterStepComplete = true;
                      });
                    },
                    ),
                    isValid: true,
                  ),

                  HorizontalStep(
                    title: TranslationConstants.success.t(context),
                    widget: AccountSuccess(),
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