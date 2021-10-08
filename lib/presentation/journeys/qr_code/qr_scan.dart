/*
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:qcharge_flutter/common/constants/size_constants.dart';
import 'package:qcharge_flutter/common/constants/translation_constants.dart';
import 'package:qcharge_flutter/common/extensions/size_extensions.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/button.dart';
import 'package:qcharge_flutter/presentation/widgets/txt_ic_row.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScan extends StatefulWidget {
  @override
  _QRScanState createState() => _QRScanState();
}

class _QRScanState extends State<QRScan> with SingleTickerProviderStateMixin {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
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

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async{
      print(scanData);
      print(scanData.format);
      print(scanData.code);
      controller.stopCamera();

    });
  }
  @override
  Widget build(BuildContext context) {
    return SlideInRight(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,

          child: Center(
            child:
              Container(
                height: MediaQuery.of(context).size.height / 2.5,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: QRView(key: qrKey, onQRViewCreated: _onQRViewCreated,)),
              ),
          ),
        ),
      ),
    );
  }
}
*/
