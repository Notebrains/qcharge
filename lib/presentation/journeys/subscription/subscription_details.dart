import 'package:flutter/material.dart';
import 'package:qcharge_flutter/common/extensions/common_fun.dart';
import 'package:qcharge_flutter/presentation/widgets/appbar_ic_back.dart';

class SubscriptionDetails extends StatelessWidget {
  final String subscriptionTitle;
  final String details;

  const SubscriptionDetails({Key? key, required this.subscriptionTitle, required this.details}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarIcBack(context, subscriptionTitle),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 8),
          child: Text(
            parseHtmlString(details),
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
