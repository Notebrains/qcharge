import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:qcharge_flutter/common/constants/route_constants.dart';
import 'package:qcharge_flutter/common/constants/size_constants.dart';
import 'package:qcharge_flutter/common/constants/translation_constants.dart';
import 'package:qcharge_flutter/common/extensions/size_extensions.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';
import 'package:qcharge_flutter/presentation/journeys/drawer/navigation_drawer.dart';
import 'package:qcharge_flutter/presentation/journeys/qr_code/finish.dart';
import 'package:qcharge_flutter/presentation/journeys/qr_code/mySharedPreferences.dart';
import 'package:qcharge_flutter/presentation/routes.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/app_bar_home.dart';
import 'package:qcharge_flutter/presentation/widgets/button.dart';
import 'package:qcharge_flutter/presentation/widgets/container_txt.dart';

import 'next.dart';
import 'start.dart';
import 'stop.dart';

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
  late Map<String, dynamic> chargerData;
  late List<dynamic> connectors;

  @override
  void initState() {
    super.initState();
    _future = getChargerDetails();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> getChargerDetails() async {
    String? data = await MySharedPreferences().getChargerData();
    print(data);
    chargerData = jsonDecode(data.toString());
    print(chargerData);
    connectors = chargerData["charger"]["detail"]["connector"];
    if(connectors.length == 2){
      hasLeft = true;
      hasRight = true;
    }else{
      if(connectors.first["connectorId"] == 1)
        hasLeft = true;
      if(connectors.first["connectorId"] == 2)
        hasRight = true;
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
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                hasLeft ? ContainerTxt(txt: TranslationConstants.leftSocket.t(context), txtColor: AppColor.app_txt_white, txtSize: 12) : Container(),

                                hasLeft ? ContainerTxt(txt: TranslationConstants.acType.t(context), txtColor: AppColor.app_txt_white, txtSize: 12) : Container(),

                                hasLeft ? AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeIn,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                    gradient: LinearGradient(begin: Alignment.centerRight, end: Alignment.centerLeft, colors: [Color(0xFFEFE07D), Color(0xFFB49839)]),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_8.w),
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
                                      "Select",
                                      style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ) : Container(),
                              ],
                            ),
                          ),

                          Image.asset('assets/images/scan_qr_for_filter_9_next.png', height: Sizes.dimen_150.h,
                            width: Sizes.dimen_110.w,),

                          Expanded(
                            child: Column(
                              children: [
                                hasRight ? ContainerTxt(txt: TranslationConstants.rightSocket.t(context), txtColor: AppColor.app_txt_white, txtSize: 12) : Container(),

                                hasRight ? ContainerTxt(txt: TranslationConstants.dcType.t(context), txtColor: AppColor.app_txt_white, txtSize: 12) : Container(),

                                hasRight ? AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeIn,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                    gradient: LinearGradient(begin: Alignment.centerRight, end: Alignment.centerLeft, colors: [Color(0xFFEFE07D), Color(0xFFB49839)]),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_8.w),
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
                                      "Select",
                                      style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ) : Container(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: isSocketSelected ? ContainerTxt(txt: selectedText, txtColor: AppColor.app_txt_amber_light, txtSize: 14) : Container(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(36.0),
                      child: Button(text: TranslationConstants.next.t(context), bgColor: [Color(0xFFEFE07D), Color(0xFFB49839)],
                        onPressed: (){
                        if(isSocketSelected) {
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
                        else
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please select Socket first"),));
//                        widget.onTap();
                      },),
                    ),
                  ],
                ),
              ),
            );
          }else
            return Center(child: CircularProgressIndicator(
              color: Colors.amberAccent,
            ),);
        }
      ),
    );
  }

//  Widget loadNextScreen(){
//    print('----Screen Title : $screenTitle');
//    switch (screenTitle) {
//      case 'next':
//        return Next(onTap:(){
//          setState(() {
//            screenTitle = 'start';
//          });
//        },);
//      case 'start':
//        return Start(onTap:(){
//          setState(() {
//            screenTitle = 'stop';
//          });
//        },);
//      case 'stop':
//        return Stop(onTap:(){
//          setState(() {
//            screenTitle = 'finish';
//          });
//        },);
//      case 'finish':
//        return Finish(onTap:(){
//          setState(() {
//            screenTitle = 'next';
//          });
//        },);
//      default:
//        return Next(onTap:(){
//          setState(() {
//            setState(() {
//              screenTitle = 'next';
//            });
//          });
//        },);
//    }
//  }
}