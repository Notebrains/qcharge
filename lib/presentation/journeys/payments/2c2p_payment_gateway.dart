
//credentials are live
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:my2c2psdk/models/my2c2psdk_type.dart';
import 'package:my2c2psdk/my2c2psdk.dart';
import 'package:qcharge_flutter/common/constants/strings.dart';

// Payment gateway used my2c2psdk flutter sdk.
// Secret key used merchant authentication key. merchantId, secretKey and privateKey get from payment admin.
// Private key generate process link:
// https://s.2c2p.com/manuals/android/download/certificategenerator.html,
// https://s.2c2p.com/manuals/android/download/my2c2pkeyengine.html
// Note: privateKey = public key(Payment admin) + private key (generate from generator)
// paymentMethodId used in switch case to select payment method


Future<Map<String, dynamic>> openProductionPaymentGateway(String amount, int paymentMethodId, String paymentText) async {
  My2c2pSDK sdk =  My2c2pSDK(privateKey: Platform.isAndroid? Strings.androidPrivateKeyForProduction : Strings.iosPrivateKeyForProduction);
  sdk.paymentUI = true; // false to direct payment and true to see payment ui to manual payment
  sdk.productionMode = true;
  sdk.merchantId = "764764000009335";
  sdk.uniqueTransactionCode = (Random().nextInt(912319541) + 154145).toString();
  sdk.desc = paymentText;
  sdk.amount = double.parse(amount);
  sdk.currencyCode = "764";
  sdk.secretKey = "21516FBA6A3FA1CBAAB295E4D8B826FB644DCACA936AD98EF2C9E4D31DE43B03";

  switch(paymentMethodId){
    case 0:
      sdk.paymentOption = PaymentOption.CREDIT_CARD;
      sdk.paymentChannel = PaymentChannel.CREDIT_CARD;
      break;
    case 1:
      sdk.paymentOption = PaymentOption.TRUE_MONEY;
      sdk.paymentChannel = PaymentChannel.TRUE_MONEY;
      break;
    case 2:
      sdk.paymentOption = PaymentOption.ONE_TWO_THREE;
      sdk.paymentChannel = PaymentChannel.ONE_TWO_THREE;
      break;
    default:
      sdk.paymentOption = PaymentOption.ALL;
  }


  final result = await sdk.proceed();
  //print('----Production Payment Result: $result');

  Map<String, dynamic> responseJson = json.decode(result!);

  return responseJson;
}


Future<Map<String, dynamic>> openSandboxPaymentGateway(String amount) async {
  final sdk = My2c2pSDK(privateKey: Platform.isAndroid? Strings.androidPrivateKeyForSandbox : Strings.iosPrivateKeyForSandbox);
  sdk.paymentUI = true; // false to direct payment and true to see payment ui to manual payment
  sdk.productionMode = false;
  sdk.merchantId = "764764000001966";
  sdk.uniqueTransactionCode = (Random().nextInt(912319541) + 154145).toString();
  sdk.desc = "product";
  sdk.amount = double.parse(amount);
  sdk.currencyCode = "764";
  sdk.secretKey = "24ABCC819638916E7DD47D09F2DEA4588FAE70636B085B8DE47A9592C4FD034F";
  //set optional fields
  //sdk.cardHolderName = "Arrow Energy";
  //sdk.panCountry = "TH";
  //sdk.securityCode = "12345";
  //sdk.cardHolderEmail = 'thanpilin-9335@arrow-energy.com';
  sdk.paymentOption = PaymentOption.ONE_TWO_THREE;


  final result = await sdk.proceed();

  print('----Test Payment Result: $result');

  Map<String, dynamic> responseJson = json.decode(result!);

  return responseJson;
}

Future<Map<String, dynamic>> openSandboxQrPaymentGateway(String amount) async {
  My2c2pSDK sdk =  My2c2pSDK(privateKey: Platform.isAndroid? Strings.androidPrivateKeyForProduction : Strings.iosPrivateKeyForProduction);
  sdk.paymentUI = true;
  sdk.productionMode = true;
  sdk.merchantId = "764764000009335";
  sdk.uniqueTransactionCode = (Random().nextInt(912319541) + 154145).toString();
  sdk.desc = "product item";
  sdk.amount = double.parse(amount);
  sdk.currencyCode = "764";
  sdk.secretKey = "21516FBA6A3FA1CBAAB295E4D8B826FB644DCACA936AD98EF2C9E4D31DE43B03";
  //sdk.cardHolderEmail = 'thanpilin-9335@arrow-energy.com';
  sdk.paymentOption = PaymentOption.ONE_TWO_THREE;
  sdk.paymentChannel = PaymentChannel.ONE_TWO_THREE;


  final result = await sdk.proceed();

  print('----Test Payment Result: $result');

  Map<String, dynamic> responseJson = json.decode(result!);

  return responseJson;
}


/*

Future<Map<String, dynamic>> openProductionPaymentGatewayForAllPayment(String amount) async {
  My2c2pSDK sdk =  My2c2pSDK(privateKey:  Strings.androidPrivateKeyForProduction);
  sdk.paymentUI = true; // false to direct payment and true to see payment ui to manual payment
  sdk.productionMode = true;
  sdk.merchantId = "764764000009335";
  sdk.uniqueTransactionCode = (Random().nextInt(912319541) + 154145).toString();
  sdk.desc = "Payment";
  sdk.amount = double.parse(amount);
  sdk.currencyCode = "764";
  sdk.secretKey = "21516FBA6A3FA1CBAAB295E4D8B826FB644DCACA936AD98EF2C9E4D31DE43B03";

  final result = await sdk.proceed();
  //print('----Production Payment Result: $result');

  Map<String, dynamic> responseJson = json.decode(result!);

  return responseJson;
}



// this method tested
Future<Map<String, dynamic>> openProductionPaymentGatewayForAndroid(String amount) async {
  My2c2pSDK sdk =  My2c2pSDK(privateKey:  Strings.androidPrivateKeyForProduction);
  sdk.paymentUI = true; // false to direct payment and true to see payment ui to manual payment
  sdk.productionMode = true;
  sdk.merchantId = "764764000009335";
  sdk.uniqueTransactionCode = (Random().nextInt(912319541) + 154145).toString();
  sdk.desc = "Payment";
  sdk.amount = double.parse(amount);
  sdk.currencyCode = "764";
  sdk.secretKey = "21516FBA6A3FA1CBAAB295E4D8B826FB644DCACA936AD98EF2C9E4D31DE43B03";

  final result = await sdk.proceed();
  //print('----Production Payment Result: $result');

  Map<String, dynamic> responseJson = json.decode(result!);

  return responseJson;
}


Future<Map<String, dynamic>> openProductionPaymentGatewayForIos(String amount) async {
  My2c2pSDK sdk =  My2c2pSDK(privateKey: Strings.iosPrivateKeyForProduction);
  sdk.paymentUI = true; // false to direct payment and true to see payment ui to manual payment
  sdk.productionMode = true;
  sdk.merchantId = "764764000009335";
  sdk.uniqueTransactionCode = (Random().nextInt(912319541) + 154145).toString();
  sdk.desc = "Payment";
  sdk.amount = double.parse(amount);
  sdk.currencyCode = "764";
  sdk.secretKey = "21516FBA6A3FA1CBAAB295E4D8B826FB644DCACA936AD98EF2C9E4D31DE43B03";
 sdk.securityCode = "k9932255";

  sdk.paymentOption = PaymentOption.ONE_TWO_THREE;
  sdk.paymentChannel = PaymentChannel.ONE_TWO_THREE;
  sdk.cardHolderName = "Thanpilin";
  sdk.mobileNo = '0909564636';
  sdk.cardHolderEmail = 'thanpilin-9335@arrow-energy.com';
  sdk.agentCode = "SCB";
  sdk.channelCode = "iBanking";
  sdk.accountNo = "010555303610000";



  //optional
  //sdk.version = "9.7";
  //sdk.cardType = CardType.OPEN_LOOP;
  //sdk.allowAccumulate = true;
  //sdk.enableStoreCard = true;
  //sdk.panCountry = "TH";
  //sdk.request3DS = "Y";
  //sdk.securityCode = "65DCAEAE";
  //sdk.paymentOption = PaymentOption.ALL;
  //sdk.paymentChannel = PaymentChannel.CREDIT_CARD;


  //final resultData =  sdk.toJson();
  //print('----Production Payment resultData: $resultData');


  final result = await sdk.proceed();
  print('----Production Payment Result: $result');

  Map<String, dynamic> responseJson = json.decode(result!);

  return responseJson;
}



Future<Map<String, dynamic>> openProductionPaymentGatewayWithMultipleOption(String amount) async {
  My2c2pSDK sdk = My2c2pSDK(privateKey: Strings.androidPrivateKeyForProduction);
  sdk.paymentUI = true; // false to direct payment and true to see payment ui to manual payment
  sdk.productionMode = true;
  sdk.merchantId = "764764000009335";
  sdk.uniqueTransactionCode = (Random().nextInt(912319541) + 154145).toString();
  sdk.desc = "Payment";
  sdk.amount = double.parse(amount);
  sdk.currencyCode = "764";
  sdk.securityCode = "764";
  sdk.secretKey = "21516FBA6A3FA1CBAAB295E4D8B826FB644DCACA936AD98EF2C9E4D31DE43B03";
  //sdk.cardType = CardType.OPEN_LOOP;
  sdk.paymentOption = PaymentOption.ALL;
  //sdk.paymentChannel = PaymentChannel.TRUE_MONEY;

  final result = await sdk.proceed();
  print('----Production Payment Result: $result');

  Map<String, dynamic> responseJson = json.decode(result!);

  return responseJson;
}

Future<Map<String, dynamic>> openProductionPaymentGatewayForQr(String amount) async {
  final sdk = My2c2pSDK(privateKey: Strings.androidPrivateKeyForProduction);
  sdk.paymentUI = false; // false to direct payment and true to see payment ui to manual payment
  sdk.productionMode = true;
  sdk.merchantId = "764764000009335";
  sdk.uniqueTransactionCode = (Random().nextInt(912319541) + 154145).toString();
  sdk.desc = "123 Payment";
  sdk.amount = double.parse(amount);
  sdk.currencyCode = "764";
  sdk.cardHolderName = "Arrow Energy";
  sdk.panCountry = "TH";
  sdk.secretKey = "21516FBA6A3FA1CBAAB295E4D8B826FB644DCACA936AD98EF2C9E4D31DE43B03";
  //set optional fields
  sdk.securityCode = "764";
  sdk.cardHolderEmail = 'thanpilin-9335@arrow-energy.com';
  sdk.paymentOption = PaymentOption.ONE_TWO_THREE;
  sdk.paymentChannel = PaymentChannel.ONE_TWO_THREE;

  sdk.agentCode = "123TH";
  sdk.channelCode = "QRPayment";
  sdk.accountNo = "088888888";
  sdk.mobileNo = "0909564636";

  final result = await sdk.proceed();

  print('----Test Payment Result: $result');

  Map<String, dynamic> responseJson = json.decode(result!);

  return responseJson;
}

Future<Map<String, dynamic>> openSandboxPaymentGatewayWithMultiplePaymentOption(String s) async {
  //initiate My2c2pSDK constructor with My2c2pKey
  My2c2pSDK sdk = My2c2pSDK(privateKey: "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");

//set mandatory fields
  sdk.paymentUI = true;
  sdk.merchantId = "JT01";
  sdk.productionMode = false;
  sdk.uniqueTransactionCode = "123456789";
  sdk.desc = "product item 1";
  sdk.amount = 20.00;
  sdk.currencyCode = "764";
  sdk.secretKey = "123456";

  sdk.paymentOption = PaymentOption.ALL;
  //mandatory for Payment Channel
  //sdk.paymentChannel = PaymentChannel.ONE_TWO_THREE; //Refer My2c2pSDK.PaymentChannel class

  //mandatory for certain Payment Channel
  //sdk.accountNo = "088888888";

  //optionals
  sdk.cardHolderName = "Mr. John";
  sdk.cardHolderEmail = "user@domain.com";
  sdk.mobileNo = "088888888";
  sdk.userDefined1 = "ref1";
  sdk.userDefined2 = "ref2";
  sdk.userDefined3 = "ref3";
  sdk.userDefined4 = "ref4";
  sdk.userDefined5 = "ref5";
  sdk.agentCode = '123TH';
  //proceed payment

  final result = await sdk.proceed();
  print('----Production Payment Result: $result');

  Map<String, dynamic> responseJson = json.decode(result!);

  return responseJson;
}

Future<Map<String, dynamic>> openSandboxPaymentGateway(String amount) async {
  final sdk = My2c2pSDK(privateKey: Platform.isAndroid? Strings.androidPrivateKeyForSandbox : Strings.iosPrivateKeyForSandbox);
  sdk.paymentUI = true; // false to direct payment and true to see payment ui to manual payment
  sdk.productionMode = false;
  sdk.merchantId = "764764000001966";
  sdk.uniqueTransactionCode = (Random().nextInt(912319541) + 154145).toString();
  sdk.desc = "product item 1";
  sdk.amount = double.parse(amount);
  sdk.currencyCode = "764";
  sdk.secretKey = "24ABCC819638916E7DD47D09F2DEA4588FAE70636B085B8DE47A9592C4FD034F";
  //set optional fields
  //sdk.cardHolderName = "Arrow Energy";
  //sdk.panCountry = "TH";
  //sdk.securityCode = "12345";
  //sdk.cardHolderEmail = 'thanpilin-9335@arrow-energy.com';
  //sdk.paymentOption = PaymentOption.ALL;


  final result = await sdk.proceed();

  print('----Test Payment Result: $result');

  Map<String, dynamic> responseJson = json.decode(result!);

  return responseJson;
}

Future<Map<String, dynamic>> openSandboxPaymentGatewayFor123(String amount) async
{
  final sdk = My2c2pSDK(privateKey: Platform.isAndroid? Strings.androidPrivateKeyForSandbox : Strings.iosPrivateKeyForSandbox);
  sdk.paymentUI = false; // false to direct payment and true to see payment ui to manual payment
  sdk.productionMode = false;
  sdk.merchantId = "764764000001966";
  sdk.uniqueTransactionCode = (Random().nextInt(912319541) + 154145).toString();
  sdk.desc = "product item 1";
  sdk.amount = double.parse(amount);
  sdk.currencyCode = "764";
  sdk.cardHolderName = "Arrow Energy";
  sdk.panCountry = "TH";
  sdk.secretKey = "24ABCC819638916E7DD47D09F2DEA4588FAE70636B085B8DE47A9592C4FD034F";
  //set optional fields
  sdk.securityCode = "12345";
  sdk.cardHolderEmail = 'thanpilin-9335@arrow-energy.com';
  sdk.mobileNo = '0909564636';
  sdk.paymentOption = PaymentOption.ONE_TWO_THREE;
  sdk.paymentChannel = PaymentChannel.ONE_TWO_THREE;

  sdk.agentCode = "SCB";
  sdk.channelCode = "iBanking";
  sdk.accountNo = "010555303610000";

 */
/*
 'paymentChannel': 'ONE_TWO_THREE',
'agentCode': 'SCB',
'channelCode': 'iBanking',
*//*


  final result = await sdk.proceed();

  print('----Test Payment Result: $result');

  Map<String, dynamic> responseJson = json.decode(result!);

  return responseJson;
}

Future<Map<String, dynamic>> openSandboxPaymentGatewayForSamsungPay() async
{
  //initiate My2c2pSDK constructor with My2c2pKey
  My2c2pSDK sdk = new My2c2pSDK(privateKey: "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");

  //set mandatory fields
  sdk.merchantId = "JT01";
  sdk.uniqueTransactionCode = "123456789";
  sdk.desc = "product item 1";
  sdk.amount = 20.00;
  sdk.currencyCode = "840";
  sdk.secretKey = "123456";
  sdk.paymentUI = false;

  //set Samsung Pay mandatory fields
  sdk.paymentChannel = PaymentChannel.SAMSUNG_PAY; //Refer My2c2pSDK.PaymentChannel class
  sdk.samsungPayServiceId = "";
  sdk.samsungPayMerchantName = "";


  final result = await sdk.proceed();
  print('----Production Payment Result: $result');

  Map<String, dynamic> responseJson = json.decode(result!);

  return responseJson;
}


Future<Map<String, dynamic>> openSandboxPaymentGatewayForBank() async
{
  //initiate My2c2pSDK constructor with My2c2pKey
  My2c2pSDK sdk = new My2c2pSDK(privateKey: "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");

  //set mandatory fields
  sdk.merchantId = "JT01";
  sdk.uniqueTransactionCode = "123456789";
  sdk.desc = "product item 1";
  sdk.amount = 20.00;
  sdk.currencyCode = "764";
  sdk.pan = "5105105105105100";
  sdk.cardExpireMonth = 12;
  sdk.cardExpireYear = 2022;
  sdk.cardHolderName = "Mr. John";
  sdk.panCountry = "MM";
  sdk.secretKey = "123456";

  //mandatory for KBZ
  sdk.cardPin = "123456";
  sdk.paymentChannel = PaymentChannel.KBZ;

  //set optional fields
  sdk.cardHolderEmail = "user@domain.com";

  final result = await sdk.proceed();
  print('----Production Payment Result: $result');

  Map<String, dynamic> responseJson = json.decode(result!);

  return responseJson;
}
*/
