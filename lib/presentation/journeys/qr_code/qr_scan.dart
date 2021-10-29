import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:my2c2psdk/models/my2c2psdk_type.dart';
import 'package:my2c2psdk/my2c2psdk.dart';
import 'package:qcharge_flutter/common/constants/route_constants.dart';
import 'package:qcharge_flutter/common/constants/strings.dart';
import 'package:qcharge_flutter/common/constants/translation_constants.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';
import 'package:qcharge_flutter/data/data_sources/authentication_local_data_source.dart';
import 'package:qcharge_flutter/data/repositories/authentication_repository_impl.dart';
import 'package:qcharge_flutter/presentation/journeys/qr_code/mySharedPreferences.dart';
import 'package:qcharge_flutter/presentation/journeys/subscription/billing.dart';
import 'package:qcharge_flutter/presentation/libraries/dialog_rflutter/rflutter_alert.dart';
import 'package:qcharge_flutter/presentation/libraries/edge_alerts/edge_alerts.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'Constants.dart' as Constants;

//iOS response: {"stationId" : 74, "chargerId" : 7401}

class QRScan extends StatefulWidget {
  @override
  _QRScanState createState() => _QRScanState();
}

class _QRScanState extends State<QRScan> with SingleTickerProviderStateMixin {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  int stationId = 0;
  int chargerId = 0;
  late bool isLoading = false;

//  AnimationController? _animationController;

  @override
  void initState() {
//    _animationController = new AnimationController(
//        duration: new Duration(seconds: 2), vsync: this);
//
//    _animationController.addStatusListener((status) {
//      if (status == AnimationStatus.completed) {
//        animateScanAnimation(true);
//      } else if (status == AnimationStatus.dismissed) {
//        animateScanAnimation(false);
//      }
//    });

    super.initState();
//    animateScanAnimation(true);
  }

  @override
  void dispose() {
//    _animationController.dispose();

    super.dispose();
  }

//
//  void animateScanAnimation(bool reverse) {
//    if (reverse) {
//      _animationController.reverse(from: 1.0);
//    } else {
//      _animationController.forward(from: 0.0);
//    }
//  }

  Future<void> getChargerDetails() async {
    try {
      http.Response tokenResponse = await http.get(Uri.parse("${Constants.APP_BASE_URL}token"));
      print("token api status code: ${tokenResponse.statusCode}");
      print("token api response body: ${tokenResponse.body}");
      Map<String, dynamic> tokenResult = jsonDecode(tokenResponse.body);
      MySharedPreferences().addApiToken(tokenResult["accessToken"]);

      Map<String, dynamic> data = Map();
      data["stationId"] = stationId.toString();
      data["chargerId"] = chargerId.toString();
      data["token"] = tokenResult["accessToken"];

      try {
        http.Response response = await http.post(Uri.parse("${Constants.APP_BASE_URL}qrscan"), body: data);
        print("qrscan status code: ${response.statusCode}");
        print("qrscan api res body: ${response.body}");
        MySharedPreferences().addChargerData(response.body);
      } catch (error) {
        print("qrscan error 1: $error");
      }
      setState(() {
        isLoading = false;
      });
      Navigator.pushReplacementNamed(context, RouteList.qrcode);
    } catch (error) {
      print("qrscan error 2: $error");
    }
  }

  void _onQRViewCreated(QRViewController controller) async {
    String? userDuePaymentStatus = await AuthenticationLocalDataSourceImpl().getUserDuePaymentFlag();
    print('----User Due Payment Status : $userDuePaymentStatus');

    if (userDuePaymentStatus != null && userDuePaymentStatus == '1') {
      if (!controller.hasPermissions) {
        edgeAlert(context,
            title: 'Warning!', description: 'Please give camera permission to use the QR Scanner', gravity: Gravity.top);
      }
      this.controller = controller;
      controller.scannedDataStream.listen((scanData) async {
        print(scanData);
        print(scanData.format);
        print(scanData.code);
        controller.stopCamera();
        if (scanData.code.isNotEmpty) {
          Map<String, dynamic> data = jsonDecode(scanData.code);
          stationId = data["stationId"];
          chargerId = data["chargerId"];
          MySharedPreferences().addStationId(data["stationId"]);
          MySharedPreferences().addChargerId(data["chargerId"]);
          setState(() {
            isLoading = true;
          });
          await getChargerDetails();
        }
      });
    } else {
      showDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SlideInRight(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height / 2.5,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: QRView(
                      key: qrKey,
                      onQRViewCreated: _onQRViewCreated,
                    ),
                  ),
                ),
              ),
              isLoading
                  ? Positioned(
                      child: Align(
                        alignment: Alignment.center,
                        child: SpinKitWave(
                          color: Colors.black,
                          size: 50,
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  void showDialog(BuildContext context) {
    Alert(
      context: context,
      onWillPopActive: true,
      title: 'DUE PAYMENT!',
      desc: "Your charging bill limit is exceeded. Please pay due bill to continue charging.\n",
      image: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Image.asset(
          "assets/images/payment-credit-card.png",
          width: 170,
          height: 170,
        ),
      ),
      closeIcon: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, RouteList.home_screen);
          },
          icon: Icon(
            Icons.cancel,
            color: Colors.white70,
          )),
      buttons: [
        DialogButton(
          color: Colors.amber,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Billing(),
              ),
            );
          },
          child: Text(
            ' View and Pay ',
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
        ),
        DialogButton(
          color: Colors.amber,
          onPressed: () {
            //Navigator.pushNamed(context, RouteList.home_screen);
            submitChargingData();
            //updatePaymentStatus();
            Navigator.pop(context);
          },
          child: Text(
            'Later',
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
        )
      ],
    ).show();
  }

  void submitChargingData() async {
    String startDateTime = DateFormat('yyyy-MM-DD hh:mm:ss').format(DateTime.now());
    print('----startDateTime : $startDateTime');

    Map<String, dynamic> data = Map();
    data["user_id"] = '15';
    data["station_id"] = '1113';
    data["vehicle_id"] = '1113';
    data["start_time"] = '2021-10-29 18:40:15';
    data["end_time"] = '2021-10-29 18:55:17';
    data["duration"] = '16';
    data["parking_time"] = '22';
    data["consume_charge"] = '50';

    try {
      http.Response response =
      await http.post(Uri.parse("https://mridayaitservices.com/demo/qcharge/public/api/v1/charging"), body: data);
      print("charging response: ${response.body}");

      if (response.statusCode == 200) {
        var resData = jsonDecode(response.body.toString());

        print('----id: ${resData["id"]}');
        print('----total_price: ${resData["total_price"]}');

        String id = resData["id"].toString();
        String totalPrice = resData["total_price"].toString();

        Alert(
          context: context,
          title: TranslationConstants.paymentMethod.t(context),
          desc: '',//"${TranslationConstants.message.t(context)}\n\n ${TranslationConstants.walletBalance.t(context)}: ${convertStrToDoubleStr(walletBalance)} thb",
          image: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.asset("assets/images/payment-credit-card.png", width: 170, height: 170,),
          ),
          buttons: [
            DialogButton(
              color: Colors.amber,
              onPressed: () {
                //pay by wallet api
                Navigator.of(context).pop();
              },
              child: Text(
                TranslationConstants.wallet.t(context),
                style: TextStyle(
                    color: Colors.black, fontSize: 14),
              ),
            ),
            DialogButton(
              color: Colors.amber,
              onPressed: () {
                openPaymentGateway(id, totalPrice,);
                Navigator.of(context).pop();
              },
              child: Text(
                TranslationConstants.payOnline.t(context),
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            )
          ],
        ).show();
      } else
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error Code : ${response.statusCode}"),),
        );
    } catch (error) {
      print("charging: $error");
    }
  }


  void openPaymentGateway(String id, String totalPrice, ) async {
    try {
      final sdk = My2c2pSDK(privateKey: Platform.isAndroid? Strings.androidPrivateKey : Strings.iosPrivateKey);
      sdk.paymentUI = true; // false to direct payment and true to see payment ui to manual payment
      sdk.productionMode = false;
      sdk.merchantId = "764764000001966";
      sdk.uniqueTransactionCode = (Random().nextInt(912319541) + 154145).toString();
      sdk.desc = "product item 1";
      sdk.amount = double.parse(totalPrice);
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
      sdk.cardHolderEmail = 'Thanpilin@arrow-energy.com';

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
        updatePaymentStatus(uniqueTransactionCode, id);
      } else {
        edgeAlert(context, title: TranslationConstants.message.t(context), description: 'Payment Failed', gravity: Gravity.top);
      }
    } catch (e) {
      print('----Error : $e');
    }
  }

  void updatePaymentStatus(String uniqueTransactionCode, String id) async {
    Map<String, dynamic> data = Map();
    data["id"] = id;
    data["transaction_id"] = uniqueTransactionCode;

    try {
      http.Response response =
      await http.post(Uri.parse("https://mridayaitservices.com/demo/qcharge/public/api/v1/update-payment-status"), body: data);
      print("charging pay response: ${response.body}");

      if (response.statusCode == 200) {
        edgeAlert(context, title: TranslationConstants.message.t(context), description: 'Payment Successful', gravity: Gravity.top);
        Navigator.pushReplacementNamed(context, RouteList.home_screen);
      } else
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error Code : ${response.statusCode}"),
          ),
        );
    } catch (error) {
      print("charging pay: $error");
    }
  }
}
