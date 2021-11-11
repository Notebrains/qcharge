
//credentials are live
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:my2c2psdk/models/my2c2psdk_type.dart';
import 'package:my2c2psdk/my2c2psdk.dart';
import 'package:qcharge_flutter/common/constants/strings.dart';

/*
import 'package:pgw_sdk/models/api_environment.dart';
import 'package:pgw_sdk/builder/card_payment_builder.dart';
import 'package:pgw_sdk/models/payment_code.dart';
import 'package:pgw_sdk/models/transaction_result_request_builder.dart';
import 'package:pgw_sdk/pgw_sdk.dart';
*/




Future<Map<String, dynamic>> openSandboxPaymentGateway(String amount) async {
  final sdk = My2c2pSDK(privateKey: Platform.isAndroid? Strings.androidPrivateKey : Strings.iosPrivateKey);
  sdk.paymentUI = true; // false to direct payment and true to see payment ui to manual payment
  sdk.productionMode = false;
  sdk.merchantId = "764764000001966";
  sdk.uniqueTransactionCode = (Random().nextInt(912319541) + 154145).toString();
  sdk.desc = "product item 1";
  sdk.amount = double.parse(amount);
  sdk.currencyCode = "764";
  sdk.pan = "5105105105105100";
  sdk.cardExpireMonth = 12;
  sdk.cardExpireYear = 2025;
  sdk.cardHolderName = "Arrow Energy";
  sdk.cardPin = "4111111111111111";
  sdk.cardType = CardType.OPEN_LOOP;
  sdk.panCountry = "TH";
  sdk.panBank = 'Kasikom Bank';
  sdk.secretKey = "24ABCC819638916E7DD47D09F2DEA4588FAE70636B085B8DE47A9592C4FD034F";
  //set optional fields
  sdk.securityCode = "2234523";
  sdk.cardHolderEmail = 'thanpilin-9335@arrow-energy.com';
  sdk.paymentOption = PaymentOption.TRUE_MONEY;
  sdk.paymentChannel = PaymentChannel.TRUE_MONEY;

  final result = await sdk.proceed();

  print('----Test Payment Result: $result');

  Map<String, dynamic> responseJson = json.decode(result!);

  return responseJson;
}

Future<Map<String, dynamic>> openProductionPaymentGateway(String amount) async {
  My2c2pSDK sdk =  My2c2pSDK(privateKey: Strings.privateKeyForProduction);
  sdk.paymentUI = true; // false to direct payment and true to see payment ui to manual payment
  sdk.productionMode = true;
  sdk.merchantId = "764764000009335";
  sdk.uniqueTransactionCode = (Random().nextInt(912319541) + 154145).toString();
  sdk.desc = "Payment";
  sdk.amount = double.parse(amount);
  sdk.currencyCode = "764";
  sdk.secretKey = "03036FF087ADF3FDF13E455A2D3C8AA68D305FE6E584464DC6F947C0739F07E1";
  sdk.enableStoreCard = true;

  final result = await sdk.proceed();
  print('----Production Payment Result: $result');

  Map<String, dynamic> responseJson = json.decode(result!);

  return responseJson;
}

Future<Map<String, dynamic>> openProductionPaymentGatewayWithMultipleOption(String amount) async {
  My2c2pSDK sdk = My2c2pSDK(privateKey: Strings.privateKeyForProduction);
  sdk.paymentUI = true; // false to direct payment and true to see payment ui to manual payment
  sdk.productionMode = true;
  sdk.merchantId = "764764000009335";
  sdk.uniqueTransactionCode = (Random().nextInt(912319541) + 154145).toString();
  sdk.desc = "Payment";
  sdk.amount = double.parse(amount);
  sdk.currencyCode = "764";
  sdk.securityCode = "764";
  sdk.secretKey = "03036FF087ADF3FDF13E455A2D3C8AA68D305FE6E584464DC6F947C0739F07E1";
  sdk.cardType = CardType.OPEN_LOOP;
  sdk.paymentOption = PaymentOption.ALL;
  sdk.paymentChannel = PaymentChannel.TRUE_MONEY;

  final result = await sdk.proceed();
  print('----Production Payment Result: $result');

  Map<String, dynamic> responseJson = json.decode(result!);

  return responseJson;
}

Future<Map<String, dynamic>> openProductionPaymentGatewayForQr(String amount) async {
  My2c2pSDK sdk = My2c2pSDK(privateKey: Strings.androidPrivateKeyForProduction);
  sdk.paymentUI = true; // false to direct payment and true to see payment ui to manual payment
  sdk.productionMode = true;
  sdk.merchantId = "764764000009335";
  sdk.uniqueTransactionCode = (Random().nextInt(912319541) + 154145).toString();
  sdk.desc = "Payment";
  sdk.amount = double.parse(amount);
  sdk.currencyCode = "764";
  //sdk.securityCode = "764";
  sdk.secretKey = "03036FF087ADF3FDF13E455A2D3C8AA68D305FE6E584464DC6F947C0739F07E1";
  sdk.paymentOption = PaymentOption.ALL;
  sdk.paymentChannel = PaymentChannel.ONE_TWO_THREE;
  sdk.agentCode = '123TH';
  sdk.mobileNo = "021150653";
  sdk.request3DS = "Y";

  final result = await sdk.proceed();
  print('----Production Payment Result: $result');

  Map<String, dynamic> responseJson = json.decode(result!);

  return responseJson;
}

/*openPgwSdk() async {
  PGWSDK.initialize(APIEnvironment.Production);
  var paymentCode = PaymentCode(channelCode: 'CC');
  var paymentRequest = CardPaymentBuilder(paymentCode: paymentCode, cardNo: '4111111111111111')
      .setExpiryMonth(12)
      .setExpiryYear(2021)
      .setSecurityCode('123')
      .build();

  var request = TransactionResultRequestBuilder(
    paymentToken: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJtZXJjaGFudElEIjoiNzY0NzY0MDAwMDA5MzM1IiwiaW52b2ljZU5vIjoiMTUyMzk1MzY2MSIsImRlc2NyaXB0aW9uIjoiVGVzdCIsImFtb3VudCI6MTAsImN1cnJlbmN5Q29kZSI6Ijc2NCJ9.ONFdaBiXc2YM6kng37XQFCsXiqA-o1YW_rEgSRWVuNQ',
    paymentRequest: paymentRequest,
  );

  var result = await PGWSDK.proceedTransaction(request);
  var redirectUrl = result.data;
  print('----Pgw Sdk Result: ${result.toString()}');


}*/

