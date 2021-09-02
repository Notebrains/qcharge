import 'package:flutter/material.dart';
import 'package:qcharge_flutter/common/constants/strings.dart';
import 'package:qcharge_flutter/common/constants/translation_constants.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';
import 'package:qcharge_flutter/common/extensions/common_fun.dart';
import 'package:qcharge_flutter/presentation/libraries/edge_alerts/edge_alerts.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/button.dart';
import 'package:qcharge_flutter/presentation/widgets/txt_if_ic_round.dart';
import 'package:qcharge_flutter/presentation/widgets/txt.dart';

class Verify extends StatefulWidget {
  @override
  _VerifyState createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(45, 100, 45, 24),
              child: Txt(txt: TranslationConstants.verifyMobTxt.t(context), txtColor: Colors.white, txtSize: 14,
                  fontWeight: FontWeight.bold, padding: 0, onTap: (){},
              ),
            ),

            IfIconRound(hint: TranslationConstants.mobNo.t(context), icon: Icons.phone_android_rounded),

            Padding(
              padding: const EdgeInsets.only(left: 34, right: 34, top: 25),
              child: Button(text: TranslationConstants.reqOtp.t(context),
                bgColor: Colors.amber,
                onPressed: () {
                  edgeAlert(context, title: 'Tips', description: 'Please slide to view next screen', gravity: Gravity.top);
                },
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 25),
              child: Txt(txt: TranslationConstants.resendOtp.t(context), txtColor: Colors.white, txtSize: 14,
                fontWeight: FontWeight.bold, padding: 0, onTap: (){},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
