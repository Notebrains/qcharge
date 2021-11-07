import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:qcharge_flutter/common/constants/route_constants.dart';
import 'package:qcharge_flutter/common/constants/translation_constants.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';
import 'package:qcharge_flutter/data/data_sources/authentication_local_data_source.dart';
import 'package:qcharge_flutter/presentation/journeys/qr_code/mySharedPreferences.dart';
import 'package:qcharge_flutter/presentation/journeys/subscription/billing.dart';
import 'package:qcharge_flutter/presentation/libraries/dialog_rflutter/rflutter_alert.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
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

    MySharedPreferences().addCardNo((Random().nextInt(912319541) + 154145).toString());
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
    try {
      String? userDuePaymentStatus = await AuthenticationLocalDataSourceImpl().getUserDuePaymentFlag();
      String? balance = await AuthenticationLocalDataSourceImpl().getWalletBalance();
      String? userSubscriptionStatus = await AuthenticationLocalDataSourceImpl().getUserSubscriptionStatus();
      double walletBalance = double.parse(balance!);

      //print('----User Due Payment Status : $userDuePaymentStatus');
      //print('----walletBalance : $walletBalance');
      //print('----userSubscriptionStatus : $userSubscriptionStatus');

      if (userSubscriptionStatus != 'Unavailable' && userDuePaymentStatus == '1') {
        showDuePaymentDialog(context);
      } else if (userSubscriptionStatus == 'Unavailable' && walletBalance == 0 || walletBalance < 100) {
        showInsufficientWalletBalanceDialog(context);
      } else {
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
      }
    } catch (e) {
      print(e);
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

  void showDuePaymentDialog(BuildContext context) {
    Alert(
      context: context,
      onWillPopActive: true,
      title: TranslationConstants.duePayment.t(context),
      desc: TranslationConstants.duePaymentExceedTxt.t(context),
      image: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Icon(
            Icons.warning,
            color: AppColor.border,
            size: 120,
          )),
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
            TranslationConstants.viewPay.t(context),
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
        ),
        DialogButton(
          color: Colors.amber,
          onPressed: () {
            Navigator.pushNamed(context, RouteList.home_screen);
            //submitChargingData();
            Navigator.pop(context);
          },
          child: Text(
            TranslationConstants.later.t(context),
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
        )
      ],
    ).show();
  }

  void showInsufficientWalletBalanceDialog(BuildContext context) {
    Alert(
      context: context,
      onWillPopActive: true,
      title: TranslationConstants.insufficientBalance.t(context),
      desc: TranslationConstants.insufficientBalanceTxt.t(context),
      image: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Icon(
            Icons.warning,
            color: AppColor.border,
            size: 120,
          )),
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
            Navigator.pushNamed(context, RouteList.home_screen);
          },
          child: Text(
            TranslationConstants.topUp.t(context),
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
        ),
      ],
    ).show();
  }
}
