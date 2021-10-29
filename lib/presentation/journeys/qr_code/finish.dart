import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:intl/intl.dart';
import 'package:qcharge_flutter/common/constants/route_constants.dart';
import 'package:qcharge_flutter/common/constants/size_constants.dart';
import 'package:qcharge_flutter/common/constants/translation_constants.dart';
import 'package:qcharge_flutter/common/extensions/size_extensions.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';
import 'package:qcharge_flutter/data/data_sources/authentication_local_data_source.dart';
import 'package:qcharge_flutter/presentation/journeys/drawer/navigation_drawer.dart';
import 'package:qcharge_flutter/presentation/journeys/qr_code/mySharedPreferences.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/app_bar_home.dart';
import 'package:qcharge_flutter/presentation/widgets/button.dart';
import 'package:qcharge_flutter/presentation/widgets/txt.dart';
import 'package:qcharge_flutter/presentation/widgets/txt_ic_row.dart';
import 'package:http/http.dart' as http;

class Finish extends StatefulWidget {

  @override
  State<Finish> createState() => _FinishState();
}

class _FinishState extends State<Finish> {
  late Future _future;
  late String? startDateTime = "";
  late String? elapsedTime = "";
  late String? totalUnits = "";
  late int? stationId = 0;
  late String date = "";
  late String? userId = "0";

  @override
  void initState() {
    super.initState();
    _future = getChargingDetails();

    submitChargingData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> getChargingDetails() async {
    startDateTime = await MySharedPreferences().getStartDateTime();
    elapsedTime = await MySharedPreferences().getElapsedTime();
    totalUnits = await MySharedPreferences().getTotalUnits();
    stationId = await MySharedPreferences().getStationId();

    userId = await AuthenticationLocalDataSourceImpl().getSessionId();

    print("elapsedTime: $elapsedTime");
    print("elapsedTime: $totalUnits");
    date = DateFormat("dd/MM/yy").format(DateTime.now());
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: appBarHome(context),
      drawer: NavigationDrawer(),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapShot) {
          if(snapShot.hasData)
            return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: SlideInRight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 36, top: 100),
                    child: Txt(txt: TranslationConstants.thanksForUsingServc.t(context), txtColor: Colors.white, txtSize: 18,
                        fontWeight: FontWeight.normal, padding: 0, onTap: (){}),
                  ),

                  Container(
                    width: Sizes.dimen_280.w,
                    padding: const EdgeInsets.all(24),
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: AppColor.grey,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ImgTxtRow(
                          txt: '${TranslationConstants.date.t(context)}: $date',
                          txtColor: AppColor.app_txt_white,
                          txtSize: 12,
                          fontWeight: FontWeight.normal,
                          icon: 'assets/icons/pngs/scan_qr_for_filter_17.png',
                          icColor: AppColor.app_txt_white,
                        ),
//                        ImgTxtRow(
//                          txt: "${TranslationConstants.unit.t(context)}: $totalUnits",
//                          txtColor: AppColor.app_txt_white,
//                          txtSize: 12,
//                          fontWeight: FontWeight.normal,
//                          icon: 'assets/icons/pngs/scan_qr_for_filter_5.png',
//                          icColor: AppColor.app_txt_white,
//                        ),

                        ImgTxtRow(
                          txt: '${TranslationConstants.time.t(context)}: $elapsedTime',
                          txtColor: AppColor.app_txt_white,
                          txtSize: 12,
                          fontWeight: FontWeight.normal,
                          icon: 'assets/icons/pngs/scan_qr_for_filter_5.png',
                          icColor: AppColor.app_txt_white,
                        ),

                        ImgTxtRow(
                          txt: "Units: $totalUnits",
                          txtColor: AppColor.app_txt_white,
                          txtSize: 12,
                          fontWeight: FontWeight.normal,
                          icon: 'assets/icons/pngs/scan_qr_for_filter_4.png',
                          icColor: AppColor.app_txt_white,
                        ),

                        ImgTxtRow(
                          txt: TranslationConstants.price.t(context),
                          txtColor: AppColor.app_txt_white,
                          txtSize: 12,
                          fontWeight: FontWeight.normal,
                          icon: 'assets/icons/pngs/scan_qr_for_filter_3.png',
                          icColor: AppColor.app_txt_white,
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(36, Sizes.dimen_30.h, 36, 20),
                    child: Button(
                      text: TranslationConstants.finish.t(context),
                      bgColor: [Color(0xFFEFE07D), Color(0xFFB49839)],
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, RouteList.initial);//                    widget.onTap();
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
          else
            return Center(child: CircularProgressIndicator(color: Colors.amber.shade600,),);
        }
      ),
    );
  }


  void submitChargingData() async {
    Map<String, dynamic> data = Map();
    data["user_id"] = userId;
    data["station_id"] = stationId;
    data["vehicle_id"] = '1';
    data["start_time"] = startDateTime;
    data["end_time"] = DateFormat('yyyy-MM-DD hh:mm:ss').format(DateTime.now());;
    data["duration"] = elapsedTime;
    data["parking_time"] = elapsedTime;
    data["consume_charge"] = totalUnits;

    try {
      http.Response response =
      await http.post(Uri.parse("https://mridayaitservices.com/demo/qcharge/public/api/v1/charging"), body: data);
      print("charging response: ${response.body}");

      if (response.statusCode == 200) {

      } else
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error Code : ${response.statusCode}"),
          ),
        );
    } catch (error) {
      print("charging: $error");
    }
  }



  void updatePaymentStatus() async {
    Map<String, dynamic> data = Map();
    data["id"] = '15';
    data["transaction_id"] = '10';

    try {
      http.Response response =
      await http.post(Uri.parse("https://mridayaitservices.com/demo/qcharge/public/api/v1/update-payment-status"), body: data);
      print("charging pay response: ${response.body}");

      if (response.statusCode == 200) {

      } else
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error Code : ${response.statusCode}"),
          ),
        );
    } catch (error) {
      print("charging pay: $error");
    }
  }
}
