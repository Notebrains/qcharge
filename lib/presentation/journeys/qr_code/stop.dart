import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
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

// Page content: Show charging details in realtime. Real time data works by calling API every seconds.

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
  late String elapsedTime = '00:00:00', sessionTime = '00:00:00';
  late String connectorStatus = 'Waiting';
  late String units = '0';
  String amount = '0';
  String? cardNo = '', walletBalance = '', normalCustomerParkingPrice = "", normalCustomerChargingPrice = "", userSubscriptionStatus = "", userID = "";
  double usedAmount = 0.00;

  updateTime(Timer timer) {
    if (stopwatch.isRunning) {
      setState(() {
        elapsedTime = transformMilliSeconds(stopwatch.elapsedMilliseconds);
      });
    }
  }

  startWatch() async {
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
    try {
      stopWatch();
      timer.cancel();
    } catch (e) {
      print(e);
    }
    super.dispose();
  }

  Future<bool> getConnectorDetails() async {
    String? data = await MySharedPreferences().getConnectorData();
    cardNo = await MySharedPreferences().getCardNo();

    connectorData = jsonDecode(data.toString());
    // print(connectorData);

    userID = await AuthenticationLocalDataSourceImpl().getSessionId();

  /*  try {
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
      //http://qcapp2134.arrow-energy.com/qcharge/api/getchargerstatus/74/7401/1/440911753/1

      statusTimer = Timer.periodic(Duration(seconds: 1), (timer) async {
        http.Response checkStatus = await http.get(Uri.parse(
            "${Constants.APP_BASE_URL}getchargerstatus/${connectorData["stationId"]}/${connectorData["chargerId"]}/${connectorData["connector"]["connectorId"]}/$cardNo/$userID"));
        // print("getchargerstatus code: ${checkStatus.statusCode}");
        // print("get charger status res: ${checkStatus.body}");
        dynamic data = jsonDecode(checkStatus.body.toString());
        statusData = data["data"];

        setState(() {
          units = statusData["kwhValue"].toString();
          amount = statusData["price"].toString();
          connectorStatus = statusData["status"].toString().capitalize();
          sessionTime = statusData["session_time"].toString();

          //print('---------sessionTime : $sessionTime');

          // Checking if user has enough balance balance to charge car else charging will be stopped.
          try {
            usedAmount = double.parse(normalCustomerChargingPrice!) * double.parse(units);
            if(usedAmount >= double.parse(walletBalance!)){
              setState(() {
                isWalletBalanceFinished = true;
              });
            }
          } catch (e) {
            // print(e);
          }
        });

        // Waiting for 16 sec. if charging not star then show wrong connector message
        if (timer.tick == 16 && !isChargingStart) {
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
          //MySharedPreferences().addUserChargingStatus('Charging');
          if (!stopwatch.isRunning){
            startWatch();
            isChargingStart = true;
          }
        }

        if(isChargingStart && statusData["status"].toString() == "available"){
          stopCharging( TranslationConstants.unplugTxt.t(context), onTap: () {
            Navigator.pushReplacementNamed(context, RouteList.finish);
          });
        }

        //Show charging status Total when charging finished or user manually unpluged from charger.
        // When status show "total", app show dialog and finish charging
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
      //MySharedPreferences().addEndTime("${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}");

    } catch (e) {
      print(e);
    }
    setState(() {
      isLoading = true;
      isChargingStart = false;
    });

    //Token api called again because sometime token expires
    http.Response tokenResponse = await http.get(Uri.parse("http://qcapp2134.arrow-energy.com/qcharge/api/token"));
    //print("token api status code: ${tokenResponse.statusCode}");
    //print("Stop token api response body: ${tokenResponse.body}");
    Map<String, dynamic> tokenResult = jsonDecode(tokenResponse.body);

    if (tokenResponse.statusCode == 200) {
      try {
        String accessToken = tokenResult["accessToken"].toString();

       /* print('---- accessToken: $accessToken');
        print('---- cardNo: $cardNo');
        //print('----- 2: ${connectorData["stationId"]}');
        print('----- 2: ${connectorData["chargerId"]}');
        print('----- 2: ${connectorData["connector"]["connectorId"]}');
        print('----- 2: $userID');*/

        MySharedPreferences().addApiToken(accessToken);


        //Calling stopcharging api

        Map<String, dynamic> data = Map();
        data["chargerId"] = connectorData["chargerId"].toString();
        data["connectorId"] = connectorData["connector"]["connectorId"].toString();
        data["cardNo"] = cardNo;
        data["token"] = accessToken;

        try {
          http.Response response = await http.post(Uri.parse("${Constants.APP_BASE_URL}stopcharging"), body: data);
          //print("stopCharge: ${response.statusCode}");
          //print("stopCharge: ${response.body}");
          setState(() {
            isLoading = false;
          });
          if (response.statusCode == 200) {
            //print('----Stop charge response.body : ${response.body}');
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
          //print("stopCharge: $error");
        }
      } catch (error) {
        //print("charging: $error");
      }

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
                                    txt: '${TranslationConstants.chargingTime.t(context)} $sessionTime',
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
                            Visibility(
                              visible: !isChargingStart,
                              child: Row(
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
                            ),

                            Visibility(
                              visible: isChargingStart,
                              child: Center(
                                child: Lottie.asset(
                                  'assets/animations/lottiefiles/charging_animation_lottie.json',
                                  height: Sizes.dimen_450.w,
                                  width: Sizes.dimen_450.w,
                                  repeat: true,
                                  animate: true,
                                ),
                              ),
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
    walletBalance = await AuthenticationLocalDataSourceImpl().getWalletBalance();
    normalCustomerParkingPrice = await MySharedPreferences().getNormalCustomerParkingPrice();
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
