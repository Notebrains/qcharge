import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:qcharge_flutter/common/constants/route_constants.dart';
import 'package:qcharge_flutter/common/constants/size_constants.dart';
import 'package:qcharge_flutter/common/constants/translation_constants.dart';
import 'package:qcharge_flutter/common/extensions/common_fun.dart';
import 'package:qcharge_flutter/common/extensions/size_extensions.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';
import 'package:qcharge_flutter/data/data_sources/authentication_local_data_source.dart';
import 'package:qcharge_flutter/presentation/journeys/drawer/navigation_drawer.dart';
import 'package:qcharge_flutter/presentation/journeys/qr_code/mySharedPreferences.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/app_bar_home.dart';
import 'package:qcharge_flutter/presentation/widgets/button.dart';
import 'package:qcharge_flutter/presentation/widgets/txt_ic_row.dart';


class StopWatchTimerPage extends StatefulWidget {
//  final Function onTap;

  const StopWatchTimerPage({Key? key}) : super(key: key);

  @override
  State<StopWatchTimerPage> createState() => _StopState();
}

class _StopState extends State<StopWatchTimerPage> {
  late Future _future;
  late Map<String, dynamic> connectorData;
  late Map<String, dynamic> statusData;
  late bool isLoading = false;
  late bool isLoaded = false;
  late bool showButton = false;
  late bool isChargingStart = false;
  late bool isCharged = false;
  late bool isWalletBalanceFinished = false;
  late Stopwatch stopwatch = Stopwatch();
  late Timer timer;
  late String elapsedTime = '00:00:00';
  late String connectorStatus = 'Waiting';
  late String units = '0';
  String amount = '0';
  String? cardNo = '', walletBalance = '', normalCustomerParkingPrice = "", normalCustomerChargingPrice = "", userSubscriptionStatus = "", userID = "";
  double usedAmount = 0.00;

  updateTime(Timer timer) async {
    String? chargerStatus = await MySharedPreferences().getUserChargingStatus();
    if(chargerStatus == "Charging"){
      String? previousTime = await MySharedPreferences().getStopWatchTime();
      var format = DateFormat("HH:mm:ss");
      var preTime = format.parse(previousTime!);
      var currTime = format.parse("${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}");
      print("---------${currTime.difference(preTime).inSeconds}"); // prints 7:40
      int timeDifference = currTime.difference(preTime).inSeconds;
      var duration = Duration(seconds: timeDifference);

      elapsedTime = transformMilliSeconds(duration.inSeconds * 1000);
    } else {
      elapsedTime = transformMilliSeconds(stopwatch.elapsedMilliseconds);
    }

    setState(() {

    });
  }

  startWatch() {
    setState(() {
      stopwatch.start();
      showButton = true;
      timer = Timer.periodic(Duration(milliseconds: 100), updateTime);
    });
  }

  stopWatch() {
    timer.cancel();
    setState(() {
      stopwatch.stop();
      setTime();
    });
  }

  setTime() {
    var timeSoFar = stopwatch.elapsedMilliseconds;
    setState(() {
      elapsedTime = transformMilliSeconds(timeSoFar);
      MySharedPreferences().addStopWatchTime("00:00:00");
      MySharedPreferences().addEndTime("${DateTime.now().hour.toString() + ":" + DateTime.now().minute.toString()}");
    });
  }

  transformMilliSeconds(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    String hoursStr = (hours % 60).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return "$hoursStr:$minutesStr:$secondsStr";
  }

  @override
  void initState() {
    super.initState();
    _future = getConnectorDetails();
  }

  @override
  void dispose() {
    super.dispose();

    stopWatch();
    timer.cancel();
  }

  Future<bool> getConnectorDetails() async {
    timer = Timer.periodic(Duration(seconds: 1), (timer)async{
      if (!stopwatch.isRunning) {
        startWatch();
      } else {
        MySharedPreferences().addEndTime("${DateTime.now().hour.toString() + ":" + DateTime.now().minute.toString()}");
        MySharedPreferences().addUserChargingStatus('Charging');
      }
    });

    return true;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarHome(context),
      drawer: NavigationDrawer(onTap: (){
        try {
          stopWatch();
          timer.cancel();
        } catch (e) {
          print(e);
        }
      },),
      body: FutureBuilder(
          future: _future,
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              return SlideInRight(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: Sizes.dimen_280.w,
                            padding: const EdgeInsets.all(24),
                            margin: const EdgeInsets.only(bottom: 12, top: 36),
                            decoration: BoxDecoration(
                              color: AppColor.grey,
                              borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ImgTxtRow(
                                  txt: '${TranslationConstants.connectorStatus.t(context)} $connectorStatus',
                                  txtColor: AppColor.app_txt_white,
                                  txtSize: 12,
                                  fontWeight: FontWeight.normal,
                                  icon: 'assets/icons/pngs/scan_qr_for_filter_10_charge_ac.png',
                                  icColor: AppColor.app_txt_white,
                                ),
                                ImgTxtRow(
                                  txt: '${TranslationConstants.chargingTime.t(context)} $elapsedTime',
                                  txtColor: AppColor.app_txt_white,
                                  txtSize: 12,
                                  fontWeight: FontWeight.normal,
                                  icon: 'assets/icons/pngs/scan_qr_for_filter_5.png',
                                  icColor: AppColor.app_txt_white,
                                ),
                                ImgTxtRow(
                                  txt: '${TranslationConstants.unit.t(context)} $units kWh',
                                  txtColor: AppColor.app_txt_white,
                                  txtSize: 12,
                                  fontWeight: FontWeight.normal,
                                  icon: 'assets/icons/pngs/scan_qr_for_filter_4.png',
                                  icColor: AppColor.app_txt_white,
                                ),
                                ImgTxtRow(
                                  txt: TranslationConstants.priceRegular.t(context) + ': $amount${TranslationConstants.thb.t(context)}' ,
                                  txtColor: AppColor.app_txt_white,
                                  txtSize: 12,
                                  fontWeight: FontWeight.normal,
                                  icon: 'assets/icons/pngs/thai_baht.png',
                                  icColor: AppColor.app_txt_white,
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 36, right: 36, bottom: 70),
                            child: Button(
                              text: TranslationConstants.stop.t(context),
                              bgColor: [Color(0xFFEFE07D), Color(0xFFB49839)],
                              onPressed: () async {
                                  stopWatch();
                                  timer.cancel();
                                  Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            } else return Center(
              child: CircularProgressIndicator(
                color: Colors.amber.shade600,
              ),
            );
          }),
    );
  }

}
