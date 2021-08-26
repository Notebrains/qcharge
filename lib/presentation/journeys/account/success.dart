import 'package:flutter/material.dart';
import 'package:qcharge_flutter/common/constants/strings.dart';
import 'package:qcharge_flutter/common/extensions/common_fun.dart';
import 'package:qcharge_flutter/presentation/libraries/edge_alerts/edge_alerts.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/button.dart';

class AccountSuccess extends StatefulWidget {
  @override
  _AccountSuccessState createState() => _AccountSuccessState();
}

class _AccountSuccessState extends State<AccountSuccess> {
  bool isAgreed = true ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(45, 60, 45, 12),
              padding: const EdgeInsets.all(16.0),
              child: Image.asset('assets/images/account_success_vector_smart_object.png'),
            ),

            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(45, 45, 45, 24),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: AppColor.grey,
                border: Border.all(
                  color: AppColor.border,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              child: Text(
                'Car Licence Plate',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 45, right: 40),
              child: Button(text: 'GET STARTED',
                bgColor: isAgreed? Colors.amber : Colors.grey.shade400,
                onPressed: () {
                  if (!isAgreed) {
                    edgeAlert(context, title: 'Tips', description: 'Please agree to our terms & conditions', gravity: Gravity.top);
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
