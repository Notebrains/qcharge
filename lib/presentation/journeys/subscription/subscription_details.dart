import 'package:flutter/material.dart';
import 'package:qcharge_flutter/presentation/widgets/appbar_ic_back.dart';
import 'package:qcharge_flutter/presentation/widgets/cached_net_img.dart';

class SubscriptionDetails extends StatelessWidget {
  final String subscriptionTitle;
  final String details;

  const SubscriptionDetails({Key? key, required this.subscriptionTitle, required this.details}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarIcBack(context, ""),
      body: cachedNetImage(details),
    );
  }
}
