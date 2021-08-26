import 'package:flutter/material.dart';
import 'package:qcharge_flutter/presentation/libraries/edge_alerts/edge_alerts.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/button.dart';
import 'package:qcharge_flutter/presentation/widgets/ic_if_row.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isAgreed = true ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(45, 60, 45, 0),
              child: IcIfRow(txt: 'First name*', txtColor: Colors.white, txtSize: 12, fontWeight: FontWeight.normal,
                icon: 'assets/icons/pngs/account_Register_6.png', icColor: Colors.white,
                initialTxtValue: 'First name*', hint: 'Enter first name', textInputType: TextInputType.text,
              ),
            ),

            Container(
              margin: const EdgeInsets.fromLTRB(45, 0, 45, 8),
              child: IcIfRow(txt: 'Email*', txtColor: Colors.white, txtSize: 12, fontWeight: FontWeight.normal,
                icon: 'assets/icons/pngs/account_Register_7.png', icColor: Colors.white,
                initialTxtValue: 'Email*', hint: 'Enter first name', textInputType: TextInputType.text,
              ),
            ),

            Container(
              margin: const EdgeInsets.fromLTRB(45, 0, 45, 8),
              child: IcIfRow(txt: 'Password*', txtColor: Colors.white, txtSize: 12, fontWeight: FontWeight.normal,
                icon: 'assets/icons/pngs/account_Register_8.png', icColor: Colors.white,
                initialTxtValue: 'Password*', hint: 'Enter first name', textInputType: TextInputType.text,
              ),
            ),

            Container(
              margin: const EdgeInsets.fromLTRB(45, 0, 45, 8),
              child: IcIfRow(txt: 'Confirm password*', txtColor: Colors.white, txtSize: 12, fontWeight: FontWeight.normal,
                icon: 'assets/icons/pngs/account_Register_9.png', icColor: Colors.white,
                initialTxtValue: 'Confirm password*', hint: 'Enter first name', textInputType: TextInputType.text,
              ),
            ),

            Container(
              margin: const EdgeInsets.fromLTRB(45, 0, 45, 8),
              child: IcIfRow(txt: 'Car model', txtColor: Colors.white, txtSize: 12, fontWeight: FontWeight.normal,
                icon: 'assets/icons/pngs/account_Register_11.png', icColor: Colors.white,
                initialTxtValue: 'Car model', hint: 'Enter first name', textInputType: TextInputType.text,
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(45, 0, 45, 8),
              child: IcIfRow(txt: 'Car licence plate', txtColor: Colors.white, txtSize: 12, fontWeight: FontWeight.normal,
                icon: 'assets/icons/pngs/account_Register_10.png', icColor: Colors.white,
                initialTxtValue: 'Car licence plate', hint: 'Enter first name', textInputType: TextInputType.text,
              ),
            ),

            Container(
              margin: const EdgeInsets.fromLTRB(45, 0, 45, 36),
              child: IcIfRow(txt: 'Confirm mobile number', txtColor: Colors.white, txtSize: 12, fontWeight: FontWeight.normal,
                icon: 'assets/icons/pngs/account_Register_1.png', icColor: Colors.white,
                initialTxtValue: 'Confirm mobile number', hint: 'Enter first name', textInputType: TextInputType.text,
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 45, right: 40),
              child: Button(text: 'REGISTER',
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
