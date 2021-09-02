import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_animator/widgets/sliding_entrances/slide_in_up.dart';
import 'package:lottie/lottie.dart';
import 'package:qcharge_flutter/common/constants/translation_constants.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';
import 'package:qcharge_flutter/presentation/widgets/app_bar_home.dart';
import 'package:qcharge_flutter/presentation/widgets/appbar_ic_back.dart';
import 'package:qcharge_flutter/presentation/widgets/button.dart';
import 'package:qcharge_flutter/presentation/widgets/txt_if_ic_round.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ForgotPasswordState();
  }
}

class _ForgotPasswordState extends State {
  String email = '';
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: appBarHome(context),

      body: Form(
        key: _key,
        autovalidateMode: AutovalidateMode.always,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SlideInUp(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50, left: 30, right: 30, bottom: 24),
                  child: Text(
                    TranslationConstants.forgotPassSuggestionTxt.t(context),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14, color: Colors.white),
                  ),
                ),
                preferences: AnimationPreferences(autoPlay: AnimationPlayStates.Forward, duration: Duration(milliseconds: 700)),
              ),


              SlideInUp(
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: IfIconRound(hint: TranslationConstants.email.t(context), icon: Icons.phone_android_rounded),
                ),
                preferences: AnimationPreferences(autoPlay: AnimationPlayStates.Forward, duration: Duration(milliseconds: 750)),
              ),

              SlideInUp(
                child: Padding(
                  padding: const EdgeInsets.only(left: 36, right: 36, top: 24),
                  child: Button(text: TranslationConstants.sendCaps.t(context),
                    bgColor: Colors.amber,
                    onPressed: () {

                    },
                  ),
                ),
                preferences: AnimationPreferences(autoPlay: AnimationPlayStates.Forward, duration: Duration(milliseconds: 800)),
              ),
            ],
          ),
        ),
      ),
    );
  }

/*
  _sendToServer() {
    if (_key.currentState.validate()) {
      // No any error in validation
      _key.currentState.save();
      print(" Email $email ");
      fetchDataApi(context);
    } else {
      // validation error
      setState(() {
        _validate = true;
      });
    }
  }*/

}
