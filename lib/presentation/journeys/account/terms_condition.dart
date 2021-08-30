import 'package:flutter/material.dart';
import 'package:qcharge_flutter/common/constants/route_constants.dart';
import 'package:qcharge_flutter/common/constants/size_constants.dart';
import 'package:qcharge_flutter/common/extensions/size_extensions.dart';
import 'package:qcharge_flutter/common/constants/strings.dart';
import 'package:qcharge_flutter/presentation/libraries/edge_alerts/edge_alerts.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/button.dart';

class TermsAndCondition extends StatefulWidget {
  @override
  _TermsAndConditionState createState() => _TermsAndConditionState();
}

class _TermsAndConditionState extends State<TermsAndCondition> {
  bool isAgreed = true ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
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
              child: Text(
                Strings.txt_lorem_ipsum_big + Strings.txt_lorem_ipsum_big,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13.0),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 25,),
              child: CheckboxListTile(
                activeColor: Colors.amber,
                checkColor: Colors.black,
                title: Text("I agree with terms & conditions",
                  style: TextStyle(fontSize: 13.0),),
                value: isAgreed,
                onChanged: (newValue) {
                  setState(() {
                    isAgreed = newValue!;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 45, right: 40),
              child: Button(text: 'CONTINUE',
                  bgColor: isAgreed? Colors.amber : Colors.grey.shade400,
                  onPressed: () {
                    if (!isAgreed) {
                      edgeAlert(context, title: 'Tips', description: 'Please agree to our terms & conditions', gravity: Gravity.top);
                    } else {
                      edgeAlert(context, title: 'Tips', description:'Please slide to view next screen');
                    }
                  },
              ),
            )
          ],
        ),
      ),
    );
  }
}
