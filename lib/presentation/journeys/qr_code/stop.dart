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

import 'Constants.dart' as Constants;

class Stop extends StatefulWidget {
//  final Function onTap;

  const Stop({Key? key}) : super(key: key);

  @override
  State<Stop> createState() => _StopState();
}

class _StopState extends State<Stop> {
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
  late Timer statusTimer;
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

    if (stopwatch.isRunning) {
      setState(() {

      });
    }
  }

  startWatch() {
    setState(() {
      stopwatch.start();
      showButton = true;
      timer = Timer.periodic(Duration(milliseconds: 100), updateTime);
    });
  }

  stopWatch() {
    statusTimer.cancel();
    setState(() {
      stopwatch.stop();
      setTime();
    });
  }

  setTime() {
    var timeSoFar = stopwatch.elapsedMilliseconds;
    setState(() {
      elapsedTime = transformMilliSeconds(timeSoFar);
      MySharedPreferences().addElapsedTime(elapsedTime);
      MySharedPreferences().addTotalUnits(units);
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

    getNormalCustomerPrice();
  }

  @override
  void dispose() {
    super.dispose();

    stopWatch();
    timer.cancel();
  }

  Future<bool> getConnectorDetails() async {
    String? data = await MySharedPreferences().getConnectorData();
    cardNo = await MySharedPreferences().getCardNo();

    //print(data);
    connectorData = jsonDecode(data.toString());
    print(connectorData);

    userID = await AuthenticationLocalDataSourceImpl().getSessionId();
    /*try {
      print('----- 2: ${connectorData["stationId"]}');
      print('----- 2: ${connectorData["chargerId"]}');
      print('----- 2: ${connectorData["connector"]["connectorId"]}');
      print('----- 2: $cardNo');
      print('----- 2: $userID');
    } catch (e) {
      print(e);
    }*/


    http.Response checkStatus = await http.get(Uri.parse(
        "${Constants.APP_BASE_URL}getchargerstatus/${connectorData["stationId"]}/${connectorData["chargerId"]}/${connectorData["connector"]["connectorId"]}"));
    //print("checkStatus: ${checkStatus.statusCode}");
    //print("checkStatus: ${checkStatus.body}");
    dynamic data1 = jsonDecode(checkStatus.body);
    if (data1["status"]) {
      isLoaded = true;
      statusData = data1["data"];
//      String temp = statusData["status"];
//      elapsedTime = "${temp.substring(0,1).toUpperCase}${temp.substring(1)}";
      //connectorStatus = statusData["status"].toString().capitalize();
      //units = statusData["kwhValue"];
      //https://mridayaitservices.com/demo/qcharge2/api/getchargerstatus/74/7401/1/440911753/1

      statusTimer = Timer.periodic(Duration(seconds: 5), (timer) async {
        http.Response checkStatus = await http.get(Uri.parse(
            "${Constants.APP_BASE_URL}getchargerstatus/${connectorData["stationId"]}/${connectorData["chargerId"]}/${connectorData["connector"]["connectorId"]}/$cardNo/$userID"));
        print("getchargerstatus code: ${checkStatus.statusCode}");
        print("get charger status res: ${checkStatus.body}");
        dynamic data = jsonDecode(checkStatus.body.toString());
        statusData = data["data"];

        setState(() {
          units = statusData["kwhValue"].toString();
          amount = statusData["price"].toString();
          connectorStatus = statusData["status"].toString().capitalize();

          try {
            usedAmount = double.parse(normalCustomerChargingPrice!) * double.parse(units);
            if(usedAmount >= double.parse(walletBalance!)){
              setState(() {
                isWalletBalanceFinished = true;
              });
            }
          } catch (e) {
            print(e);
          }

          print('-----units 1: $units');
        });

        //print('-----1  ${timer.tick}');
        //print('-----3  $isChargingStart');
        //print('-----2  ${statusData["status"].toString()}');

        if (timer.tick == 15 && !isChargingStart) {
          stopWatch();
          timer.cancel();
          showWrongConnectorDialog();
        }

        if (isWalletBalanceFinished && userSubscriptionStatus == 'Unavailable') {
          stopCharging( TranslationConstants.balanceReached.t(context), onTap: () {
            Navigator.pushReplacementNamed(context, RouteList.finish);
          });
        }

        if (statusData["status"].toString() == "charging") {

          if (!stopwatch.isRunning){
            startWatch();
            MySharedPreferences().addUserChargingStatus('Charging');
            isChargingStart = true;
          }

          MySharedPreferences().addStopWatchTime("${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}");
        }

        if(isChargingStart && statusData["status"].toString() == "available"){
          stopCharging( TranslationConstants.unplugTxt.t(context), onTap: () {
            Navigator.pushReplacementNamed(context, RouteList.finish);
          });
        }

        if (statusData["status"].toString() == "total") {
          stopCharging(TranslationConstants.carChargedTxt.t(context), onTap: () {
            Navigator.pushReplacementNamed(context, RouteList.finish);
          });
        }
      });
    }
    return true;
  }

  stopCharging(String dialogText,  {
    required Function() onTap,
  }) async {
    try {
      stopWatch();
      timer.cancel();
    } catch (e) {
      print(e);
    }
    setState(() {
      isLoading = true;
    });

    Map<String, dynamic> data = Map();
    data["chargerId"] = connectorData["chargerId"].toString();
    data["connectorId"] = connectorData["connector"]["connectorId"].toString();
    data["cardNo"] = cardNo;

    String? token = await MySharedPreferences().getApiToken();
    data["token"] = token.toString();
    try {
      http.Response response = await http.post(Uri.parse("${Constants.APP_BASE_URL}stopcharging"), body: data);
      print("stopCharge: ${response.statusCode}");
      print("stopCharge: ${response.body}");
      setState(() {
        isLoading = false;
      });
      if (response.statusCode == 200) {
        if (dialogText == 'no') {
          Navigator.pushReplacementNamed(context, RouteList.finish);
        }
      } else ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error Code : ${response.statusCode}"),
      ));

      if (dialogText != 'no') {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(TranslationConstants.message.t(context)),
                content: Text(dialogText,),
                actions: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeIn,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                      gradient: LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: [Color(0xFFEFE07D), Color(0xFFB49839)]),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_8.w),
                    margin: EdgeInsets.symmetric(vertical: Sizes.dimen_8.h, horizontal: 24),
                    width: 80,
                    height: 35,
                    child: TextButton(
                      onPressed: (){
                        Navigator.pop(context);
                        onTap();
                      },
                      child: Text(
                        TranslationConstants.okay.t(context),
                        style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              );
            });
      }
    } catch (error) {
      print("stopCharge: $error");
    }
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
              if (isLoaded)
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/scan_qr_for_filter_9_next.png',
                                  height: Sizes.dimen_130.h,
                                  width: Sizes.dimen_110.w,
                                ),
                                Image.asset(
                                  'assets/icons/pngs/scan_qr_for_filter_6.png',
                                  height: Sizes.dimen_150.h,
                                  width: Sizes.dimen_230.w,
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 36, right: 36, bottom: 70),
                              child: Button(
                                text: TranslationConstants.stop.t(context),
                                bgColor: [Color(0xFFEFE07D), Color(0xFFB49839)],
                                onPressed: () async {
                                  stopCharging('no', onTap: () {  });
                                },
                              ),
                            ),
                          ],
                        ),
                        isLoading
                            ? Positioned(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: MediaQuery.of(context).size.height - AppBar().preferredSize.height,
                                    child: Center(
                                      child: SpinKitWave(
                                        color: Colors.white,
                                        size: 50,
                                      ),
                                    ),
                                  ),
                                ),
                              ) : Container(),
                      ],
                    ),
                  ),
                );
              else return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          TranslationConstants.connectorNotFound.t(context),
                          style: TextStyle(
                            color: AppColor.app_txt_white,
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 36, right: 36, bottom: 70),
                          child: Button(
                            text: TranslationConstants.goBack.t(context),
                            bgColor: [Color(0xFFEFE07D), Color(0xFFB49839)],
                            onPressed: () async {
                              Navigator.pushReplacementNamed(context, RouteList.home_screen);
                            },
                          ),
                        ),
                      ],
                ));
            } else return Center(
                child: CircularProgressIndicator(
                  color: Colors.amber.shade600,
                ),
              );
          }),
    );
  }

  void showWrongConnectorDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text(TranslationConstants.warning.t(context),),
            content: Text(TranslationConstants.wrongConnector.t(context),),
            actions: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeIn,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                  gradient: LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [Color(0xFFEFE07D), Color(0xFFB49839)]),
                ),
                padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_8.w),
                margin: EdgeInsets.symmetric(vertical: Sizes.dimen_8.h, horizontal: 24),
                width: 130,
                height: 35,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, RouteList.qrcode);
                  },
                  child: Text(
                    TranslationConstants.goBack.t(context),
                    style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          );
        });
  }

  void getNormalCustomerPrice() async {
    normalCustomerChargingPrice = await MySharedPreferences().getNormalCustomerChargingPrice();
    normalCustomerParkingPrice = await MySharedPreferences().getNormalCustomerParkingPrice();
    walletBalance = await AuthenticationLocalDataSourceImpl().getWalletBalance();
    userSubscriptionStatus = await AuthenticationLocalDataSourceImpl().getUserSubscriptionStatus();
  }


  void showConnectorNotConnectedDialog() {

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text(TranslationConstants.warning.t(context),),
            content: Text( TranslationConstants.connectorNotConnectedTxt.t(context)),
            actions: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeIn,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                  gradient: LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [Color(0xFFEFE07D), Color(0xFFB49839)]),
                ),
                padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_8.w),
                margin: EdgeInsets.symmetric(vertical: Sizes.dimen_8.h, horizontal: 24),
                width: 130,
                height: 35,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, RouteList.qrcode);
                  },
                  child: Text(
                    TranslationConstants.goBack.t(context),
                    style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          );
        });
  }
}
