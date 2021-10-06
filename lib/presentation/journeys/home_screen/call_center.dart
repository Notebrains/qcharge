import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qcharge_flutter/presentation/widgets/app_bar_home.dart';
import 'package:qcharge_flutter/presentation/widgets/button.dart';
import 'package:url_launcher/url_launcher.dart';

class CallCenter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SubscriptionState();
  }
}

class _SubscriptionState extends State {

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: appBarHome(context),
      body: Column(
        children: [
          Button(text: 'Send Email', bgColor: [Color(0xFFEFE07D), Color(0xFFB49839)], onPressed: (){
            _launchEmailApp();
          }),

          Button(text: 'Call US', bgColor: [Color(0xFFEFE07D), Color(0xFFB49839)], onPressed: (){
            _launchCaller();
          }),
        ],
      )
    );
  }

  _launchCaller() async {
    const url = "tel:1234567890";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchEmailApp() async {
    const url = 'mailto:sejpalbhargav67@gmail.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
