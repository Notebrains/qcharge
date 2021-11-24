import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qcharge_flutter/presentation/libraries/dialog_rflutter/rflutter_alert.dart';
import 'Constants.dart' as Constants;

import 'package:flutter/material.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in.dart';
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
import 'package:qcharge_flutter/presentation/widgets/container_txt.dart';

class QrCode extends StatefulWidget{

  @override
  _QrCodeState createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  late String selectedText = "";
  late Future _future;
  late bool isSocketSelected = false;
  late bool hasLeft = false;
  late bool hasRight = false;
  late bool isProcessingDone = false;
  late Map<String, dynamic> chargerData;
  late List<dynamic> connectors;
  late Map<String, dynamic> statusData;
  String connectorStatus = '', leftConnectorId= '', rightConnectorId = '', leftConnectorStatus= '', rightConnectorStatus = '';
  late Timer timer;


  @override
  void initState() {
    super.initState();
    _future = getChargerDetails();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();

  }

  Future<bool> getChargerDetails() async {
    String? token = await MySharedPreferences().getApiToken();
    String? data = await MySharedPreferences().getChargerData();
    print(data);
    chargerData = jsonDecode(data.toString());
    print(chargerData);

    connectors = chargerData["charger"]["detail"]["connector"];

    //print('----00---- : ${connectors[0]["status"]}');
    //print('----00---- : ${connectors[1]["status"]}');

    leftConnectorId = connectors[0]["status"];
    rightConnectorId = connectors[1]["status"];

/*
    if(connectors[0]["status"] == "1") {
        //print('----11---- : ${connectors[0]["status"]}');
        hasLeft = true;
        MySharedPreferences().addLeftConnectorId(connectors[0]["connectorId"].toString());
      }
    if(connectors[1]["status"] == "1") {
        //print('----22---- : ${connectors[1]["status"]}');
        hasRight = true;
        MySharedPreferences().addRightConnectorId(connectors[1]["connectorId"].toString());
      }*/

    String stationId = chargerData["station"]["stationId"].toString();
    String chargerId = chargerData["charger"]["id"].toString();

    timer = Timer.periodic(Duration(seconds: 5), (timer) async {
      print("----stationId:  $stationId");
      print("----chargerId:  $chargerId");
      print("----token:  $token");

      try {
        Map<String, dynamic> data = Map();
        data["stationId"] = stationId;
        data["chargerId"] = chargerId;
        data["token"] = token;

        http.Response response = await http.post(Uri.parse("${Constants.APP_BASE_URL}qrscan"), body: data);
        //print("qrscan status code: ${response.statusCode}");
        print("qrscan api res body: ${response.body}");

        chargerData = jsonDecode(response.body.toString());
        //stationId = chargerData["station"]["stationId"].toString();
        //chargerId = chargerData["charger"]["id"].toString();

        connectors = chargerData["charger"]["detail"]["connector"];
        leftConnectorId = connectors[0]["connectorId"].toString();
        rightConnectorId = connectors[1]["connectorId"].toString();
        leftConnectorStatus = connectors[0]["status"].toString();
        rightConnectorStatus = connectors[1]["status"].toString();


        print('----- leftConnectorId:  $leftConnectorId');
        print('----- rightConnectorId:  $rightConnectorId');
        print('----- leftConnectorStatus:  $leftConnectorStatus');
        print('----- rightConnectorStatus:  $rightConnectorStatus');

      } catch (error) {
        print("qrscan error 1: $error");
      }

      if (leftConnectorStatus == '5') {
        try{
          http.Response response = await http.get(Uri.parse("https://mridayaitservices.com/demo/qcharge2/api/getsensorstatus/$stationId/$chargerId/$leftConnectorId"));
          //print("getsensorstatus Res 1: ${response.body}");

          if(response.statusCode == 200){
            dynamic data = jsonDecode(response.body);
            print('----- parkingSensor: ${data["data"]["parkingSensor"]}');
            setState(() {
              data["data"]["parkingSensor"] == "1" && leftConnectorStatus == '5' ? hasLeft = true: hasLeft = false;
            });

          } else
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error Code : ${response.statusCode}"),));

        }catch(error){
          print("startCharge: $error");
        }
      } else {
        setState(() {
          hasLeft = false;
        });
      }

      if (rightConnectorStatus == '5') {
        try{
          http.Response response = await http.get(Uri.parse("https://mridayaitservices.com/demo/qcharge2/api/getsensorstatus/$stationId/$chargerId/$rightConnectorId"));
          //print("get sensor status Res 2: ${response.body}");

          if(response.statusCode == 200){
            dynamic data = jsonDecode(response.body);
            print('-----ss parkingSensor: ${data["data"]["parkingSensor"]}');

            setState(() {
              print('-----ss hasRight: $hasRight');
              print('-----ss rightConnectorStatus: $rightConnectorStatus');
              data["data"]["parkingSensor"] == "1" && rightConnectorStatus == '5' ? hasRight = true: hasRight = false;

            });
          } else
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error Code : ${response.statusCode}"),));

        }catch(error){
          print("startCharge: $error");
        }
      } else {
        setState(() {
          hasRight = false;
        });
      }
    });

    print('----hasLeft:  $hasLeft,  hasRight:  $hasRight');
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarHome(context),
      drawer: NavigationDrawer(onTap: (){
        try {
          timer.cancel();
        } catch (e) {
          print(e);
        }
      },),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapShot) {
          if(snapShot.hasData){
            return FadeIn(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 56),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                ContainerTxt(txt: TranslationConstants.leftSocket.t(context), txtColor: AppColor.app_txt_white, txtSize: 12),

                                ContainerTxt(txt: connectors[0]["type"] + ', '  + connectors[0]["kw"], txtColor: AppColor.app_txt_white, txtSize: 12),

                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeIn,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                    gradient: LinearGradient(begin: Alignment.centerRight, end: Alignment.centerLeft,
                                        colors: hasLeft? [Color(0xFFEFE07D), Color(0xFFB49839)]: [Color(0xFF8D8D8D), Color(0xFFD2D2D2)]),
                                  ),
                                  //padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_8.w),
                                  margin: EdgeInsets.symmetric(vertical: Sizes.dimen_8.h),
                                  width: 80,
                                  height: 35,
                                  child: TextButton(
                                    onPressed: (){
                                      setState(() {
                                        isSocketSelected = true;
                                        selectedText = "Left Socket";
                                      });
                                    },
                                    child: Text(
                                      hasLeft? TranslationConstants.select.t(context): TranslationConstants.notReady.t(context),
                                      style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),

                          Image.asset('assets/images/scan_qr_for_filter_9_next.png', height: Sizes.dimen_150.h,
                            width: 100,),

                          Expanded(
                            child: Column(
                              children: [
                                ContainerTxt(txt: TranslationConstants.rightSocket.t(context), txtColor: AppColor.app_txt_white, txtSize: 12),

                                ContainerTxt(txt: connectors[0]["type"] + ', ' + connectors[1]["kw"], txtColor: AppColor.app_txt_white, txtSize: 12),

                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeIn,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                    gradient: LinearGradient(begin: Alignment.centerRight, end: Alignment.centerLeft,
                                        colors: hasRight? [Color(0xFFEFE07D), Color(0xFFB49839)]: [Color(0xFF8D8D8D), Color(0xFFD2D2D2)]),
                                  ),
                                  //padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_8.w),
                                  margin: EdgeInsets.symmetric(vertical: Sizes.dimen_8.h),
                                  width: 80,
                                  height: 35,
                                  child: TextButton(
                                    onPressed: (){
                                      setState(() {
                                        isSocketSelected = true;
                                        selectedText = "Right Socket";
                                      });
                                    },
                                    child: Text(
                                      hasRight? TranslationConstants.select.t(context): TranslationConstants.notReady.t(context),
                                      style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),


                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeIn,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                        gradient: LinearGradient(begin: Alignment.centerRight, end: Alignment.centerLeft,
                            colors: [Colors.grey.shade900, Colors.grey.shade900]),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_12.w),
                      margin: EdgeInsets.symmetric(horizontal: Sizes.dimen_8.h),
                      width: double.maxFinite,
                      height: 90,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            TranslationConstants.notReadyNote1.t(context),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12, color: AppColor.app_txt_white),
                            maxLines: 2,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            TranslationConstants.notReadyNote2.t(context),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12, color: AppColor.app_txt_white),
                            maxLines: 2,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            TranslationConstants.notReadyNote3.t(context),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12, color: AppColor.app_txt_white),
                            maxLines: 2,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      )
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: isSocketSelected ? ContainerTxt(txt: selectedText, txtColor: AppColor.app_txt_amber_light, txtSize: 14) : Container(),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(36.0),
                      child: Button(text: TranslationConstants.next.t(context), bgColor: [Color(0xFFEFE07D), Color(0xFFB49839)],
                        onPressed: (){
                        if(isSocketSelected && (hasLeft || hasRight)) {
                          Map<String, dynamic> selectedSocketData = Map();
                          selectedSocketData["stationId"] = chargerData["station"]["stationId"];
                          selectedSocketData["chargerId"] = chargerData["charger"]["id"];
                          if(selectedText == "Left Socket")
                            selectedSocketData["connector"] = connectors.first;
                          if(selectedText == "Right Socket")
                            selectedSocketData["connector"] = connectors.elementAt(1);

                          MySharedPreferences().addConnectorData(jsonEncode(selectedSocketData));
                          Navigator.pushReplacementNamed(context, RouteList.start);
                        }
                        else ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please select socket first"),));

                      },),
                    ),
                  ],
                ),
              ),
            );
          }else return Center(child: CircularProgressIndicator(
              color: Colors.amber.shade600,
            ),);
        }
      ),
    );
  }

  void showNotParkedDialog() {
    Alert(
      context: context,
      onWillPopActive: true,
      title: 'Car is not parked',
      desc:  'Please park the car to start charging',
      image: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Icon(
            Icons.warning_rounded,
            color: AppColor.border,
            size: 100,
          )),
      closeIcon: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, RouteList.home_screen);
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.cancel,
            color: Colors.white70,
          )),
      buttons: [
        DialogButton(
          color: Colors.amber,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            TranslationConstants.okay.t(context),
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
        ),
      ],
    ).show();
  }
}