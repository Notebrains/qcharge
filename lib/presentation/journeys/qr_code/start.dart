import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:qcharge_flutter/common/constants/route_constants.dart';
import 'package:qcharge_flutter/common/constants/size_constants.dart';
import 'package:qcharge_flutter/common/constants/translation_constants.dart';
import 'package:qcharge_flutter/common/extensions/size_extensions.dart';
import 'package:qcharge_flutter/presentation/journeys/drawer/navigation_drawer.dart';
import 'package:qcharge_flutter/presentation/journeys/qr_code/mySharedPreferences.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/app_bar_home.dart';
import 'package:qcharge_flutter/presentation/widgets/button.dart';
import 'package:qcharge_flutter/presentation/widgets/txt_ic_row.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';
import 'package:http/http.dart' as http;
import 'Constants.dart' as Constants;


class Start extends StatefulWidget {
//  final Function onTap;

  const Start({Key? key}) : super(key: key);

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  late Future _future;
  late Map<String, dynamic> connectorData;
  late bool isLoading = false;
  String? cardNo = '';

  @override
  void initState() {
    super.initState();
    _future = getConnectorDetails();

  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> getConnectorDetails()async{
    String? data = await MySharedPreferences().getConnectorData();
    cardNo = await MySharedPreferences().getCardNo();
    print(data);
    connectorData = jsonDecode(data.toString());
    print(connectorData);
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
          if(snapShot.hasData)
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
                                txt: '${TranslationConstants.chargingTime.t(context)} 00:00:00',
                                txtColor: AppColor.app_txt_white,
                                txtSize: 12,
                                fontWeight: FontWeight.normal,
                                icon: 'assets/icons/pngs/scan_qr_for_filter_5.png',
                                icColor: AppColor.app_txt_white,
                            ),
                            ImgTxtRow(
                                txt: '${TranslationConstants.unit.t(context)} 0 kwh',
                                txtColor: AppColor.app_txt_white,
                                txtSize: 12,
                                fontWeight: FontWeight.normal,
                                icon: 'assets/icons/pngs/scan_qr_for_filter_4.png',
                                icColor: AppColor.app_txt_white,
                            ),

                            /*ImgTxtRow(
                                txt: TranslationConstants.acType.t(context),
                                txtColor: AppColor.app_txt_white,
                                txtSize: 12,
                                fontWeight: FontWeight.normal,
                                icon: 'assets/icons/pngs/scan_qr_for_filter_10_charge_ac.png',
                                icColor: AppColor.app_txt_white,
                            ),*/
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
                          text: TranslationConstants.start.t(context),
                          bgColor: [Color(0xFFEFE07D), Color(0xFFB49839)],
                          onPressed: () async{

                            setState(() {
                              isLoading = true;
                            });

                            print('----- cardNo: ${cardNo}');

                            Map<String, dynamic> data = Map();
                            data["chargerId"] = connectorData["chargerId"].toString();
                            data["connectorId"] = connectorData["connector"]["connectorId"].toString();
                            data["cardNo"] = cardNo;

                            String? token = await MySharedPreferences().getApiToken();
                            data["token"] = token.toString();
                            try{
                              http.Response response = await http.post(Uri.parse("${Constants.APP_BASE_URL}startcharging"), body: data);
                              print("startCharge: ${response.statusCode}");
                              print("startCharge: ${response.body}");
                              setState(() {
                                isLoading = false;
                              });

                              if(response.statusCode == 200)
                                Navigator.pushReplacementNamed(context, RouteList.stop);
                              else
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error Code : ${response.statusCode}"),));

                            }catch(error){
                              print("startCharge: $error");
                            }


                          },
                        ),
                      ),
                    ],
                  ),
                  isLoading ? Positioned(
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
          else return Center(child: CircularProgressIndicator(color: Colors.amber.shade600,),);
        }
      ),
    );
  }
}
