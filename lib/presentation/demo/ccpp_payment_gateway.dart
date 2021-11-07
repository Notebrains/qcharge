/* Details : https://pub.dev/packages/my2c2psdk
Other credentials link: https://github.com/siamsiandev/flutter_myccpp/blob/master/example/lib/main.dart

  void openPaymentGateway() async {
    try {
      final sdk = My2c2pSDK(privateKey: Platform.isAndroid? Strings.androidPrivateKey : Strings.iosPrivateKey);
      sdk.paymentUI = true; // false to direct payment and true to see payment ui to manual payment
      sdk.productionMode = false;
      sdk.merchantId = "764764000001966";
      sdk.uniqueTransactionCode = (Random().nextInt(912319541) + 154145).toString();
      sdk.desc = "product item 1";
      sdk.amount = double.parse(_topupAmountController!.text);
      sdk.currencyCode = "764";
      sdk.pan = "5105105105105100";
      sdk.cardExpireMonth = 12;
      sdk.cardExpireYear = 2025;
      sdk.cardHolderName = "Mr. John";
      sdk.cardPin = "4111111111111111";
      sdk.cardType = CardType.OPEN_LOOP;
      sdk.panCountry = "TH";
      sdk.panBank = 'Kasikom Bank';
      sdk.secretKey = "24ABCC819638916E7DD47D09F2DEA4588FAE70636B085B8DE47A9592C4FD034F";
      //set optional fields
      sdk.securityCode = "2234523";
      sdk.cardHolderEmail = 'thanpilin-9335@arrow-energy.com';

      final result = await sdk.proceed();
      print('----2c2p payment result: $result');

      Map<String, dynamic> responseJson = json.decode(result!);

      String uniqueTransactionCode = responseJson["uniqueTransactionCode"];

      /*String amount = responseJson["amt"];

      print('----amount: ${responseJson["amt"]}');
      print('----uniqueTransactionCode: ${responseJson["uniqueTransactionCode"]}');
      print('----tranRef: ${responseJson["tranRef"]}');
      print('----approvalCode: ${responseJson["approvalCode"]}');
      print('----refNumber: ${responseJson["refNumber"]}');*/

      if (uniqueTransactionCode.isNotEmpty) {
        BlocProvider.of<WalletRechargeCubit>(context).initiateWalletRecharge(
          userId,
          responseJson["uniqueTransactionCode"],
          _topupAmountController!.text,
        );
      } else {
        edgeAlert(context, title: TranslationConstants.message.t(context), description: 'Payment Failed', gravity: Gravity.top);
      }
    } catch (e) {
      print('----Error : $e');
    }
  }

// Payment result:

{"ippPeriod":"","ippInterestType":"","ippInterestRate":"","ippMerchantAbsorbRate":"","paidChannel":"","paidAgent":"",
"paymentChannel":"","backendInvoice":"4026915","issuerCountry":"US","bankName":"BANK","subMerchantList":{"subMerchant":[]},
"version":"9.7","timeStamp":"211021125039","respCode":"00","merchantID":"764764000001966","subMerchantID":"",
"pan":"411111XXXXXX1111","amt":"000000001000","uniqueTransactionCode":"1015091923644","tranRef":"4280361",
"approvalCode":"805430","refNumber":"1015091923644","eci":"05","paymentScheme":"VI","processBy":"VI",
"dateTime":"211021142210","status":"A","raw":"MIIGtAYJKoZIhvcNAQcDoIIGpTCCBqECAQAxggGpMIIBpQIBADCBjDB/MQswCQYDVQQGEwJUSDEQMA
4GA1UECBMHU29uZ3NvZDEQMA4GA1UEBxMHQmFuZ2tvazEQMA4GA1UEChMHUGxhcGluZzEgMB4GA1UECxMXRm91cm5pIHBhciBUQlMgaW50ZXJuZXQxGDAWBgNVBA
MTD3d3dy5zb25nc29kLmNvbQIJAMgAhjHEiVtOMA0GCSqGSIb3DQEBAQUABIIBANm5CDDMzIXjMucURdGKzks1PD4zqTXnLqhcgxso59OoshF+WO2R6f79NskyFV
2rWpWtIhU8aKsbcEqVHIoBgrbbOIJemC6T6jl300KZOA5suhsmwvqq+QNtgwwYA6I9KBzT

*/

/*


Live Credentials


final sdk = My2c2pSDK(privateKey: "0044694DA6BC19D3D57CF2B9D731A931D3B9890F0B545C6C3F2BAF3A481438DF");
sdk.paymentUI = true; // false to direct payment and true to see payment ui to manual payment
sdk.productionMode = false;
sdk.merchantId = "764764000009335";
sdk.uniqueTransactionCode = (Random().nextInt(912319541) + 154145).toString();
sdk.desc = "Payment";
sdk.amount = double.parse(_topupAmountController!.text);
sdk.currencyCode = "764";
sdk.secretKey = "0044694DA6BC19D3D57CF2B9D731A931D3B9890F0B545C6C3F2BAF3A481438DF";
sdk.securityCode = "JWE";
sdk.cardHolderEmail = 'thanpilin-9335@arrow-energy.com';
//set optional fields
sdk.pan = "5105105105105100";
sdk.cardExpireMonth = 12;
sdk.cardExpireYear = 2025;
sdk.cardHolderName = "Mr. John";
sdk.cardPin = "4111111111111111";
sdk.cardType = CardType.OPEN_LOOP;
sdk.panCountry = "TH";
sdk.panBank = 'Kasikom Bank';


*/

