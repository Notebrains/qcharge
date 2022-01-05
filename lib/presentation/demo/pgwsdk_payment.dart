/*
import 'package:flutter/material.dart';

import 'package:pgw_sdk/builder/card_payment_builder.dart';
import 'package:pgw_sdk/builder/qr_payment_builder.dart';
import 'package:pgw_sdk/models/api_environment.dart';
import 'package:pgw_sdk/models/payment_code.dart';
import 'package:pgw_sdk/models/transaction_result_request_builder.dart';
import 'package:pgw_sdk/pgw_sdk.dart';

class PgwSdkPayment extends StatefulWidget {
  @override
  _PgwSdkPaymentState createState() => _PgwSdkPaymentState();
}

class _PgwSdkPaymentState extends State<PgwSdkPayment> {

  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(title: Text("Pgw Sdk Payment")),
        body: Container(
          alignment: Alignment.center,
          child:RaisedButton(
              child: Text("Try again"),
              onPressed: () {
                doPayment();
              }),
        ),
    );
  }

  void doPayment() async {
    PGWSDK.initialize(APIEnvironment.Sandbox);

    PaymentCode paymentCode = new PaymentCode(
      channelCode: "VEMVQR",
      //agentCode: 'THKBANK',
      //agentChannelCode: 'IBANKING',
    );

    */
/*var paymentRequest = CardPaymentBuilder(paymentCode: paymentCode, cardNo: '4111111111111111')
        .setExpiryMonth(12)
        .setExpiryYear(2021)
        .setSecurityCode('123')
        .build();*//*


    var paymentRequest = QRPaymentBuilder(paymentCode: paymentCode)
        .setType(QRTypeCode.base64)
        .setName("DavidBilly")
        .setEmail("davidbilly@2c2p.com")
        .setMobileNo("08888888")
        .build();

    var request = TransactionResultRequestBuilder(
      paymentToken: 'roZG9I1hk/GYjNt+BYPYbxQtKElbZDs9M5cXuEbE+Z0QTr/yUcl1oG7t0AGoOJlBhzeyBtf5mQi1UqGbjC66E85S4m63CfV/awwNbbLbkxsvfgzn0KSv7JzH3gcs/OIL',
      paymentRequest: paymentRequest,
      //clientId: '30c7cf51-75c4-4265-a70a-effddfbbb0ff',
      //locale: 'en',
    );

    var result = await PGWSDK.proceedTransaction(request);
    //var redirectUrl = result.data;

    print('---- type : ${result.type}');
    print('---- raw : ${result.raw}');
    print('---- fallback Data : ${result.fallbackData}');
    print('---- response Description : ${result.responseDescription}');
    print('---- redirect Url : ${result.data}');
  }

}
*/
