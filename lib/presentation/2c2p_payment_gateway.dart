
//credentials are live
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:my2c2psdk/models/my2c2psdk_type.dart';
import 'package:my2c2psdk/my2c2psdk.dart';
import 'package:qcharge_flutter/common/constants/strings.dart';


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
  sdk.paymentOption = PaymentOption.ALL;
  sdk.paymentChannel = PaymentChannel.GCASH;

  final result = await sdk.proceed();

  print('----Test Payment Result: $result');

  Map<String, dynamic> responseJson = json.decode(result!);

  return responseJson;
}

Future<Map<String, dynamic>> openProductionPaymentGateway(String amount) async {
  My2c2pSDK sdk = new My2c2pSDK(privateKey: Strings.privateKeyForProduction);
  sdk.paymentUI = true; // false to direct payment and true to see payment ui to manual payment
  sdk.productionMode = true;
  sdk.merchantId = "764764000009335";
  sdk.uniqueTransactionCode = (Random().nextInt(912319541) + 154145).toString();
  sdk.desc = "Payment";
  sdk.amount = double.parse(amount);
  sdk.currencyCode = "764";
  sdk.secretKey = "E481239D5F14F5C08AB83299C33346A3EF093EE3BA36C7DA8F0F5DA47916E1C6";
  sdk.enableStoreCard = true;

  final result = await sdk.proceed();
  print('----Production Payment Result: $result');

  Map<String, dynamic> responseJson = json.decode(result!);

  return responseJson;
}

Future<Map<String, dynamic>> openProductionPaymentGatewayWithMultipleOption(String amount) async {
  My2c2pSDK sdk = new My2c2pSDK(privateKey: Strings.privateKeyForProduction);
  sdk.paymentUI = true; // false to direct payment and true to see payment ui to manual payment
  sdk.productionMode = true;
  sdk.merchantId = "764764000009335";
  sdk.uniqueTransactionCode = (Random().nextInt(912319541) + 154145).toString();
  sdk.desc = "Payment";
  sdk.amount = double.parse(amount);
  sdk.currencyCode = "764";
  sdk.securityCode = "764";
  sdk.secretKey = "E481239D5F14F5C08AB83299C33346A3EF093EE3BA36C7DA8F0F5DA47916E1C6";
  //sdk.enableStoreCard = true;
  //sdk.cardType = CardType.OPEN_LOOP;
  sdk.paymentOption = PaymentOption.ALL;

  final result = await sdk.proceed();
  print('----Production Payment Result: $result');

  Map<String, dynamic> responseJson = json.decode(result!);

  return responseJson;
}

