import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:qcharge_flutter/common/constants/route_constants.dart';
import 'package:qcharge_flutter/common/constants/size_constants.dart';
import 'package:qcharge_flutter/common/constants/translation_constants.dart';
import 'package:qcharge_flutter/common/extensions/common_fun.dart';
import 'package:qcharge_flutter/common/extensions/size_extensions.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';
import 'package:qcharge_flutter/data/data_sources/authentication_local_data_source.dart';
import 'package:qcharge_flutter/data/data_sources/language_local_data_source.dart';
import 'package:qcharge_flutter/presentation/journeys/drawer/navigation_drawer.dart';
import 'package:qcharge_flutter/presentation/journeys/home_screen/home_nav_bar.dart';
import 'package:qcharge_flutter/presentation/libraries/dialog_rflutter/rflutter_alert.dart';
import 'package:qcharge_flutter/presentation/libraries/edge_alerts/edge_alerts.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/app_bar_home.dart';
import 'package:qcharge_flutter/presentation/widgets/button.dart';
import 'package:qcharge_flutter/presentation/widgets/txt.dart';
import 'package:qcharge_flutter/presentation/widgets/txt_ic_row.dart';
import 'Constants.dart' as Constants;
import 'mySharedPreferences.dart';

class Finish extends StatefulWidget {
  @override
  State<Finish> createState() => _FinishState();
}

class _FinishState extends State<Finish> {
  bool isPaymentDone = false;
  late Future _future;
  late String? startDateTime = "";
  late String date = "", time = "", totalUnits = "", totalPrice = "", stayTimeAfterCharge = "", parkingPrice = "", showNotificationTime = "";
  late String? userId = "0";
  //late String? isShowingSummary = "0";
  late int? couponId  = 0;
  String  endTime = '00:00:00', cardNo = '0' , language = 'en';

  // Parking charge amount and time showing in dialog is dynamic.These data coming from API.
  String dialogTxt = "Your car's charging is finished. Please move\n the car from the charger station within -- minutes. After that, the parking charge will be apply at -- thb/hr  since --. Thank you.";
  DateTime dateTime = DateTime.now();


  @override
  void initState() {
    super.initState();

    //get charging details from local db before page load
    _future = getChargingDetails();

    getCardNo();

  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> getChargingDetails() async {
    cardNo = await MySharedPreferences().getCardNo()?? '0';
    // startDateTime = await MySharedPreferences().getStartDateTime();
    couponId = await MySharedPreferences().getChargerId();
    startDateTime = DateFormat('yyyy-MM-dd hh:mm:ss').format(dateTime); //change here
    userId = await AuthenticationLocalDataSourceImpl().getSessionId();
    //isShowingSummary = await MySharedPreferences().geIsShowingSummary();
    date = DateFormat("dd/MM/yyyy").format(dateTime);


    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarHome(context),
      drawer: NavigationDrawer(onTap: (){},),
      body: FutureBuilder(
          future: _future,
          builder: (context, snapShot) {
            if (snapShot.hasData)
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: SlideInRight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12, top: 45),
                        child: Icon(Icons.notifications_active_rounded, size: 45, color: AppColor.border,),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(55, 0, 55, 12),
                        child: Txt(
                            txt: dialogTxt,
                            txtColor: Colors.white,
                            txtSize: 12,
                            fontWeight: FontWeight.normal,
                            padding: 0,
                            onTap: () {},
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 36, top: 35),
                        child: Txt(
                            txt: TranslationConstants.thanksForUsingServc.t(context),
                            txtColor: Colors.white,
                            txtSize: 18,
                            fontWeight: FontWeight.normal,
                            padding: 0,
                            onTap: () {},
                        ),
                      ),


                      Container(
                        width: Sizes.dimen_280.w,
                        padding: const EdgeInsets.fromLTRB(24,24,24, 24),
                        margin: EdgeInsets.only(bottom: Sizes.dimen_20.h),
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
                            ImgTxtRow(
                              txt: '${TranslationConstants.time.t(context)} $time',
                              txtColor: AppColor.app_txt_white,
                              txtSize: 12,
                              fontWeight: FontWeight.normal,
                              icon: 'assets/icons/pngs/scan_qr_for_filter_5.png',
                              icColor: AppColor.app_txt_white,
                            ),

                            ImgTxtRow(
                              txt: '${TranslationConstants.endTime.t(context)} ${formatStringTimeString(endTime)}',
                              txtColor: AppColor.app_txt_white,
                              txtSize: 12,
                              fontWeight: FontWeight.normal,
                              icon: 'assets/icons/pngs/scan_qr_for_filter_5.png',
                              icColor: AppColor.app_txt_white,
                            ),
                            ImgTxtRow(
                              txt: "${TranslationConstants.unit.t(context)} $totalUnits kWh",
                              txtColor: AppColor.app_txt_white,
                              txtSize: 12,
                              fontWeight: FontWeight.normal,
                              icon: 'assets/icons/pngs/scan_qr_for_filter_4.png',
                              icColor: AppColor.app_txt_white,
                            ),
                            ImgTxtRow(
                              txt: TranslationConstants.price.t(context) + " " + convertStrToDoubleStr(totalPrice) + TranslationConstants.thb.t(context),
                              txtColor: AppColor.app_txt_white,
                              txtSize: 12,
                              fontWeight: FontWeight.normal,
                              icon: 'assets/icons/pngs/scan_qr_for_filter_3.png',
                              icColor: AppColor.app_txt_white,
                            ),


                            ImgTxtRow(
                              txt: "7 % VAT ${TranslationConstants.applied.t(context)}",
                              txtColor: AppColor.app_txt_white,
                              txtSize: 12,
                              fontWeight: FontWeight.normal,
                              icon: 'assets/icons/pngs/vat.png',
                              icColor: AppColor.app_txt_white,
                            ),
                          ],
                        ),
                      ),


                      Visibility(
                        visible: !isPaymentDone,
                        child: CircularProgressIndicator(
                          color: Colors.amber.shade600,
                        ),
                      ),

                      Visibility(
                        visible: !isPaymentDone,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12, bottom: 16),
                          child: Text(
                            TranslationConstants.processing.t(context),
                            style: TextStyle(fontWeight: FontWeight.normal, fontSize: Sizes.dimen_20.w, color: Colors.white, letterSpacing: 3),
                          ),
                        ),
                      ),

                      Container(
                        width: 280,
                        margin: EdgeInsets.only(left: 12, bottom: 20),
                        child: Button(
                          text: TranslationConstants.finish.t(context),
                          bgColor: isPaymentDone? [Color(0xFFEFE07D), Color(0xFFB49839)] : [Color(0xFF8D8D8D), Color(0xFFD2D2D2)],
                          onPressed: () {
                            if (isPaymentDone) {
                              showParkingChargeDialog(context);
                            } else edgeAlert(context, title: TranslationConstants.warning.t(context), description: 'Please wait until processing is done', gravity: Gravity.top);
                          },
                        ),
                      ),

                    ],
                  ),
                ),
              );
            else
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.amber.shade600,
                ),
              );
          }),
    );
  }

  // This API is called to get time of charging and total unit
  void getTransactionDetails(String cardNo) async {
    try {
      //print('---- cardNo: $cardNo');
      http.Response response =
      await http.get(Uri.parse("${Constants.APP_BASE_URL}transaction/$cardNo"));
      // print("Transaction API response: ${response.body}");

      if (response.statusCode == 200) {
        var resData = jsonDecode(response.body.toString());

        // print('----status: ${resData["status"]}');
        // print('----message: ${resData["message"]}');

        if(resData["status"]){
          // print('----stationId: ${resData["data"]["stationId"]}');

          setState(() {
            String stationId = resData["data"]["stationId"].toString();
            time = resData["data"]["session_time"].toString();
            //String chargerId = resData["chargerId"].toString();
            totalUnits = resData["data"]["kwhValue"].toString();

            getChargingCalculatedData(stationId);
          });

        } else {
          edgeAlert(context, title: TranslationConstants.warning.t(context), description: resData["message"], gravity: Gravity.top);
        }

      } else
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Something went wrong. Please try again."),
          ),
        );
    } catch (error) {
      print("Something went wrong. Please try again.");
    }
  }

  // This API is called to get
  void getChargingCalculatedData(String stationId) async {
    try {
      /*print('---- cardNo: $cardNo');
      print('---- userId: $userId');
      print('---- stationId: $stationId');
      print('---- startDateTime: $startDateTime');
      print('---- time: $time');
      print('---- totalUnits: $totalUnits');*/

      Map<String, dynamic> data = Map();
      data["user_id"] = userId;
      data["station_id"] = stationId;
      data["vehicle_id"] = '1';
      data["start_time"] = startDateTime;
      data["end_time"] = DateFormat('yyyy-MM-dd hh:mm:ss').format(dateTime);
      data["duration"] = time;
      data["consume_charge"] = totalUnits;
      data["coupon_id"] = couponId.toString();
      data["transaction_id"] = cardNo;
      data["status"] = '1';

      http.Response response =
      await http.post(Uri.parse("http://54.151.172.184/qcharge/api/v1/charging"), body: data);
      // print("charging response: ${response.body}");

      if (response.statusCode == 200) {
        var resData = jsonDecode(response.body.toString());

        // print('----id: ${resData["id"]}');
        // print('----total_price: ${resData["total_price"]}');

        String id = resData["id"].toString();
        
        setState(() {
          totalPrice = resData["total_price"].toString();
          stayTimeAfterCharge = resData["stay_time_after_charge"].toString();
          parkingPrice = resData["parking_price"].toString();

          endTime = resData["end_time"].toString().split(" ")[1];

          try {
            var splitString = endTime.split(':');
            int hourEndTime = int.parse(splitString[0].trim());
            int minuteEndTime = int.parse(splitString[1].trim());

            var d = Duration(minutes: int.parse(stayTimeAfterCharge));
            List<String> parts = d.toString().split(':');
            int hour = int.parse(parts[0].padLeft(2, '0'));
            int minute = int.parse(parts[1].padLeft(2, '0'));

            var format = DateFormat("HH:mm");
            DateTime dateTime = format.parse("${hourEndTime + hour}:${minuteEndTime + minute}");
            String parkingTime = DateFormat.Hm().format(dateTime);

            if (language != 'en') {
                dialogTxt = "การชาร์จรถยนต์ของคุณเสร็จสิ้น โปรดย้ายรถออกจากสถานีชาร์จภายใน $stayTimeAfterCharge นาที หลังจากนั้นจะมีการเรียกเก็บค่าบริการที่จอดรถในอัตรา $parkingPrice บาท/ชม. ตั้งแต่เวลา $parkingTime.  ขอขอบคุณ.";
              } else {
                dialogTxt = "Your car's charging is finished. Please move\n the car from the charger station within $stayTimeAfterCharge minutes. After that, the parking charge will be apply at $parkingPrice thb/hr. since $parkingTime. Thank you.";
              }
          } catch (e) {
            print(e);
          }
        });

        String? userSubscriptionStatus = await AuthenticationLocalDataSourceImpl().getUserSubscriptionStatus();
        //print('---- userSubscriptionStatus: $userSubscriptionStatus');

        // update-payment-status API called only for non-subscribe user and for subscribe user charging payment will be added when stop charging API called and price value will be added as due payment
        if (userSubscriptionStatus == 'Unavailable') {
          updatePaymentStatus(id, totalPrice);
        } else {
          setState(() {
            isPaymentDone = true;
          });
        }
      } else
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Something went wrong. Please try again."),
          ),
        );
    } catch (error) {
      //print("Something went wrong. Please try again.");
    }
  }

  void updatePaymentStatus(String id, String totalPrice) async {
    try {
      Map<String, dynamic> data = Map();
      data["id"] = id;
      data["transaction_id"] = cardNo;
      data["user_id"] = userId;
      data["total_price"] = totalPrice;

      http.Response response = await http.post(Uri.parse("http://54.151.172.184/qcharge/api/v1/update-payment-status"), body: data);
      //print("update-payment-status response: ${response.body}");

      if (response.statusCode == 200) {
        setState(() {
          isPaymentDone = true;
        });
        // edgeAlert(context, title: TranslationConstants.message.t(context), description: 'Processing complete. Thank you!', gravity: Gravity.top);
        // Navigator.pushReplacementNamed(context, RouteList.home_screen);
      } else ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Something went wrong. Please try again."),),
        );
    } catch (error) {
      print("charging pay: $error");
    }
  }


  void showParkingChargeDialog(BuildContext context) {
    Alert(
      context: context,
      onWillPopActive: true,
      title: TranslationConstants.message.t(context),
      desc:  dialogTxt,
      image: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Icon(
            Icons.notifications_active_rounded,
            color: AppColor.border,
            size: 120,
          )),
      closeIcon: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, RouteList.home_screen);
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.cancel,
            color: Colors.white70,
          ),
      ),
      buttons: [
        DialogButton(
          color: Colors.amber,
          onPressed: () {
            //MySharedPreferences().addUserChargingStatus("Charged");
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeNavbar(page: 'Top Up',),
              ),
            );
          },
          child: Text(
            TranslationConstants.okay.t(context),
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
        ),
      ],
    ).show();
  }

  void getCardNo() async {
    await MySharedPreferences().getCardNo().then((cardNo) => {
    Future.delayed(const Duration(seconds: 5), () {
      getTransactionDetails(cardNo!);
    }),
    });


    language = await LanguageLocalDataSourceImpl().getPreferredLanguage();
    //print('----lang : $language');
  }

}

