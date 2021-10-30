import 'package:flutter/material.dart';
import 'package:qcharge_flutter/common/constants/size_constants.dart';
import 'package:qcharge_flutter/common/constants/strings.dart';
import 'package:qcharge_flutter/common/constants/translation_constants.dart';
import 'package:qcharge_flutter/common/extensions/size_extensions.dart';
import 'package:qcharge_flutter/presentation/libraries/edge_alerts/edge_alerts.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/extensions/string_extensions.dart';

class TermsAndCondition extends StatefulWidget {
  final Function isProcessCompleted;

  const TermsAndCondition({Key? key, required this.isProcessCompleted}) : super(key: key);

  @override
  _TermsAndConditionState createState() => _TermsAndConditionState();
}

class _TermsAndConditionState extends State<TermsAndCondition> {
  bool isAgreed = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          InkWell(
            child: Container(
              margin: EdgeInsets.fromLTRB(45, Sizes.dimen_24.h, 45, Sizes.dimen_16.h),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppColor.grey,
                border: Border.all(
                  color: Colors.white,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    Strings.tAndCTxt,
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 13.0),
                  ),

                  Text(
                    '\nRead More...',
                    style: TextStyle(fontSize: 13.0),
                  ),
                ],
              ),
            ),

            onTap: (){
              _launchInBrowser("https://docs.google.com/gview?embedded=true&url=" + Strings.termAndCondPdfUrl);
              //_launchInBrowser("https://docs.google.com/viewer?url="+ Strings.termAndCondPdfUrl);
            },
          ),

          Padding(
            padding: const EdgeInsets.only(left: 25,),
            child: CheckboxListTile(
              activeColor: Colors.amber,
              checkColor: Colors.black,
              title: Text(TranslationConstants.tAndCTxt.t(context),
                style: TextStyle(fontSize: 13.0),),
              value: isAgreed,
              onChanged: (isChecked) {
                print('---- : $isChecked ,isAgreed: $isAgreed');
                setState(() {
                  isAgreed = isChecked!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
            ),
          ),


          Padding(
              padding: const EdgeInsets.only(left: 45, right: 40),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeIn,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                  gradient: LinearGradient(begin: Alignment.centerRight, end: Alignment.centerLeft, colors: [
                    isAgreed? Color(0xFFEFE07D) : Color(0xFFD7D3CB),
                    isAgreed? Color(0xFFB49839) : Color(0xFFADADAD),
                  ]),
                ),
                padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_8.w),
                margin: EdgeInsets.symmetric(vertical: Sizes.dimen_8.h),
                width: double.infinity,
                height: 45,
                child: TextButton(
                  onPressed: (){
                    if (!isAgreed) {
                      edgeAlert(context, title: 'Tips', description: 'Please agree to our terms & conditions', gravity: Gravity.top);
                    } else {
                      edgeAlert(context, title: 'Tips', description:'Thanks. \n Now verify your device');
                      widget.isProcessCompleted();
                    }
                  },
                  child: Text(
                    TranslationConstants.continueCaps.t(context),
                    style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'Terms and Condition'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
