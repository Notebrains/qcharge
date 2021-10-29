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
import 'package:qcharge_flutter/common/extensions/size_extensions.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';
import 'package:qcharge_flutter/presentation/journeys/drawer/navigation_drawer.dart';
import 'package:qcharge_flutter/presentation/journeys/qr_code/mySharedPreferences.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/app_bar_home.dart';
import 'package:qcharge_flutter/presentation/widgets/button.dart';
import 'package:qcharge_flutter/presentation/widgets/txt_ic_row.dart';

import 'Constants.dart' as Constants;
import 'finish.dart';

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
  late Stopwatch stopwatch = Stopwatch();
  late Timer timer;
  late Timer statusTimer;
  late String elapsedTime = '00:00:00';
  late String connectorStatus = '';
  late String units = '0';

  updateTime(Timer timer) {
    if (stopwatch.isRunning) {
      setState(() {
        elapsedTime = transformMilliSeconds(stopwatch.elapsedMilliseconds);
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
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> getConnectorDetails() async {
    String? data = await MySharedPreferences().getConnectorData();
    print(data);
    connectorData = jsonDecode(data.toString());
    print(connectorData);
    int? stationId = await MySharedPreferences().getStationId();
    int? chargerId = await MySharedPreferences().getStationId();
    http.Response checkStatus = await http.get(Uri.parse(
        "https://qcharge.hashtrix.in/public/api/getchargerstatus/${connectorData["stationId"]}/${connectorData["chargerId"]}/${connectorData["connector"]["connectorId"]}"));
    print("checkStatus: ${checkStatus.statusCode}");
    print("checkStatus: ${checkStatus.body}");
    dynamic data1 = jsonDecode(checkStatus.body);
    if (data1["status"]) {
      isLoaded = true;
      statusData = data1["data"];
//      String temp = statusData["status"];
//      elapsedTime = "${temp.substring(0,1).toUpperCase}${temp.substring(1)}";
      connectorStatus = statusData["status"].toString().capitalize();
      units = statusData["kwhValue"];
      statusTimer = Timer.periodic(Duration(seconds: 3), (timer) async {
        http.Response checkStatus = await http.get(Uri.parse(
            "https://qcharge.hashtrix.in/public/api/getchargerstatus/${connectorData["stationId"]}/${connectorData["chargerId"]}/${connectorData["connector"]["connectorId"]}"));
        print("checkStatus: ${checkStatus.statusCode}");
        print("checkStatus: ${checkStatus.body}");
        dynamic data = jsonDecode(checkStatus.body);
        statusData = data["data"];
        setState(() {
          connectorStatus = statusData["status"].toString().capitalize();
          units = statusData["kwhValue"];
        });
        if (statusData["data"].toString() == "charging") {
          if (!stopwatch.isRunning) startWatch();
        }
        if (statusData["data"].toString() == "charged") {
          stopWatch();
          timer.cancel();
          setState(() {
            isLoading = true;
          });
          Map<String, dynamic> data = Map();
          data["chargerId"] = connectorData["chargerId"].toString();
          data["connectorId"] = connectorData["connector"]["connectorId"].toString();
          data["cardNo"] = "ABCDE";

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
            } else
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Error Code : ${response.statusCode}"),
              ));

            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text("Your car battery is fully charged!"),
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
                        margin: EdgeInsets.symmetric(vertical: Sizes.dimen_8.h),
                        width: 80,
                        height: 35,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Finish(),
                              ),
                            );
                          },
                          child: Text(
                            "Ok",
                            style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  );
                });
          } catch (error) {
            print("stopCharge: $error");
          }
        }
      });
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarHome(context),
      drawer: NavigationDrawer(),
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
                                    txt: 'Connector Status: $connectorStatus',
                                    txtColor: AppColor.app_txt_white,
                                    txtSize: 12,
                                    fontWeight: FontWeight.normal,
                                    icon: 'assets/icons/pngs/scan_qr_for_filter_10_charge_ac.png',
                                    icColor: AppColor.app_txt_white,
                                  ),
                                  ImgTxtRow(
                                    txt: 'Charging Time: $elapsedTime',
                                    txtColor: AppColor.app_txt_white,
                                    txtSize: 12,
                                    fontWeight: FontWeight.normal,
                                    icon: 'assets/icons/pngs/scan_qr_for_filter_5.png',
                                    icColor: AppColor.app_txt_white,
                                  ),
                                  ImgTxtRow(
                                    txt: 'Units: $units',
                                    txtColor: AppColor.app_txt_white,
                                    txtSize: 12,
                                    fontWeight: FontWeight.normal,
                                    icon: 'assets/icons/pngs/scan_qr_for_filter_4.png',
                                    icColor: AppColor.app_txt_white,
                                  ),
                                  ImgTxtRow(
                                    txt: TranslationConstants.acType.t(context),
                                    txtColor: AppColor.app_txt_white,
                                    txtSize: 12,
                                    fontWeight: FontWeight.normal,
                                    icon: 'assets/icons/pngs/scan_qr_for_filter_10_charge_ac.png',
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
                                  setState(() {
                                    isLoading = true;
                                  });

                                  Map<String, dynamic> data = Map();
                                  data["chargerId"] = connectorData["chargerId"].toString();
                                  data["connectorId"] = connectorData["connector"]["connectorId"].toString();
                                  data["cardNo"] = "ABCDE";

                                  String? token = await MySharedPreferences().getApiToken();
                                  data["token"] = token.toString();
                                  try {
                                    http.Response response =
                                        await http.post(Uri.parse("${Constants.APP_BASE_URL}stopcharging"), body: data);
                                    print("stopCharge: ${response.statusCode}");
                                    print("stopCharge: ${response.body}");
                                    setState(() {
                                      isLoading = false;
                                    });
                                    if (response.statusCode == 200) {
                                      stopWatch();
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Finish(),
                                        ),
                                      );
                                    } else
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text("Error Code : ${response.statusCode}"),
                                        ),
                                      );
                                  } catch (error) {
                                    print("stopCharge: $error");
                                  }

            //                    widget.onTap();
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
                              )
                            : Container(),
                      ],
                    ),
                  ),
                );
              else
                return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          " Connector not found",
                          style: TextStyle(
                            color: AppColor.app_txt_white,
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 36, right: 36, bottom: 70),
                          child: Button(
                            text: "Go Back",
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
}
