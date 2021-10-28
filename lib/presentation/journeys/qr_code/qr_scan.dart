import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:qcharge_flutter/common/constants/route_constants.dart';
import 'package:qcharge_flutter/presentation/journeys/qr_code/mySharedPreferences.dart';
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

  Future<void> getChargerDetails()async{
    try {
      http.Response tokenResponse = await http.get(Uri.parse("${Constants.APP_BASE_URL}token"));
      print("getToken: ${tokenResponse.statusCode}");
      print("getToken: ${tokenResponse.body}");
      Map<String, dynamic> tokenResult = jsonDecode(tokenResponse.body);
      MySharedPreferences().addApiToken(tokenResult["accessToken"]);

      Map<String, dynamic> data = Map();
      data["stationId"] = stationId.toString();
      data["chargerId"] = chargerId.toString();
      data["token"] = tokenResult["accessToken"];

      try{
        http.Response response = await http.post(Uri.parse("${Constants.APP_BASE_URL}qrscan"), body: data);
        print("getToken: ${response.statusCode}");
        print("getToken: ${response.body}");
        MySharedPreferences().addChargerData(response.body);
      }catch(error){
        print("qrscan: $error");
      }
      setState(() {
        isLoading = false;
      });
      Navigator.pushReplacementNamed(context, RouteList.qrcode);

    }catch(error){
      print("getToken: $error");
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async{
      print(scanData);
      print(scanData.format);
      print(scanData.code);
      controller.stopCamera();
      if(scanData.code.isNotEmpty){
        Map<String, dynamic> data = jsonDecode(scanData.code);
        stationId = data["stationId"];
        chargerId = data["chargerId"];
        MySharedPreferences().addChargerId(data["stationId"]);
        MySharedPreferences().addChargerId(data["chargerId"]);
        setState(() {
          isLoading = true;
        });
        await getChargerDetails();
      }
    });
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
                child:
                Container(
                  height: MediaQuery.of(context).size.height / 2.5,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: QRView(key: qrKey, onQRViewCreated: _onQRViewCreated,)),
                ),
              ),
              isLoading ? Positioned(
                child: Align(
                  alignment: Alignment.center,
                  child: SpinKitWave(
                    color: Colors.black,
                    size: 50,
                  ),
                ),
              ) : Container(),

            ],
          ),
        ),
      ),
    );
  }
}
