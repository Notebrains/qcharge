import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:qcharge_flutter/common/constants/route_constants.dart';
import 'package:qcharge_flutter/common/constants/size_constants.dart';
import 'package:qcharge_flutter/common/constants/translation_constants.dart';
import 'package:qcharge_flutter/common/extensions/size_extensions.dart';
import 'package:qcharge_flutter/data/data_sources/authentication_local_data_source.dart';
import 'package:qcharge_flutter/data/models/coupon_code_api_res_model.dart';
import 'package:qcharge_flutter/data/models/status_message_api_res_model.dart';
import 'package:qcharge_flutter/presentation/journeys/drawer/navigation_drawer.dart';
import 'package:qcharge_flutter/presentation/journeys/qr_code/mySharedPreferences.dart';
import 'package:qcharge_flutter/presentation/libraries/edge_alerts/edge_alerts.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/app_bar_home.dart';
import 'package:qcharge_flutter/presentation/widgets/button.dart';
import 'package:qcharge_flutter/presentation/widgets/txt_ic_row.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';
import 'package:http/http.dart' as http;
import 'package:qcharge_flutter/presentation/widgets/voucher_code_ui.dart';
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
  String couponId = '';
  TextEditingController _controller = TextEditingController();
  String applyBtnTxt = 'Apply';


  @override
  void initState() {
    super.initState();
    _future = getConnectorDetails();

  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
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
      drawer: NavigationDrawer(onTap: (){},),
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
                                txt: '${TranslationConstants.unit.t(context)} 0 kWh',
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
                        padding: const EdgeInsets.only(left: 34, right: 34, bottom: 8),
                        child: VoucherCodeUi(
                            controller: _controller,
                            hint: TranslationConstants.couponCodeHere.t(context),
                            textInputType: TextInputType.text,
                            onSaved: (value){

                            },
                            onTap: (){
                                validateCouponCode();
                            },
                          
                          onIconTap: () async {
                            try {
                              http.Response response =
                                  await http.post(Uri.parse("https://mridayaitservices.com/demo/qcharge/public/api/v1/promocode"));
                              print("promo code API response: ${response.body}");

                              if (response.statusCode == 200) {
                                CouponCodeApiResModel model = CouponCodeApiResModel.fromJson(jsonDecode(response.body.toString()));

                                //print('----status: ${model.status}');
                                //print('----message: ${model.response}');

                                if(model.status == 1 && model.response != null){
                                  showCouponsBottomSheet(model.response);
                                }else {
                                  edgeAlert(context, title: TranslationConstants.message.t(context), description: 'Currently coupon code not available', gravity: Gravity.top);
                                }


                              }
                                //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error Code : ${response.statusCode}"),),);
                            } catch (error) {
                              print("charging: $error");
                            }
                          }, applyBtnTxt: applyBtnTxt == 'Apply'? TranslationConstants.apply.t(context): TranslationConstants.applied.t(context),
                        )
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

                            print('----- 1: ${connectorData["chargerId"]}');
                            print('----- 1: ${connectorData["connector"]["connectorId"]}');

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
                              //else ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error Code : ${response.statusCode}"),));

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

  void showCouponsBottomSheet(List<Response>? response) {

    showModalBottomSheet<void>(
        backgroundColor: Colors.grey.shade900,
        context: context,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (BuildContext context, StateSetter state) {
            return Container(
              height: 500,
              padding: EdgeInsets.only(bottom: 26, left: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    child: Text(
                      TranslationConstants.avCouponCode.t(context),
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    child: Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.grey[200],
                    ),
                  ),

                  Expanded(
                    child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: response!.length,
                        itemBuilder: (BuildContext context, int index) {

                          return InkWell(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              width: double.maxFinite,
                              padding: const EdgeInsets.all(18),
                              margin: const EdgeInsets.all(8),
                              color: Colors.grey[850],
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 12, left: 6),
                                        child: Icon(Icons.local_offer_rounded, size: 20, color: AppColor.border,),
                                      ),
                                      Text(response[index].discountType! == 'Percentage'?
                                      '${response[index].amount!}% OFF':
                                      'FLAT${response[index].amount!} OFF',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(fontSize: 16, color: AppColor.border),
                                      ),

                                    ],
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 36, top: 2, bottom: 2),
                                    child: Text('${TranslationConstants.code.t(context)} ${response[index].couponCode!}',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(fontSize: 12, color: Colors.white),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 36),
                                    child: Text(response[index].title!,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(fontSize: 12, color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            onTap: (){
                              setState(() {
                                _controller.text = response[index].couponCode!;
                                couponId = response[index].id.toString();
                                applyBtnTxt = 'Apply';
                                Navigator.pop(context);
                              });
                            },
                          );
                        }),
                  ),
                ],
              ),
            );
          });
        });
  }

  void validateCouponCode() async {
    isLoading = true;
    String? userId = await AuthenticationLocalDataSourceImpl().getSessionId();

    print('---- couponId: $couponId,  $userId, ');
    if(userId != null && couponId.isNotEmpty){

      Map<String, dynamic> data = Map();
      data["user_id"] = userId;
      data["id"] = couponId;

      try{
        http.Response response = await http.post(Uri.parse("https://mridayaitservices.com/demo/qcharge/public/api/v1/apply-promocode"), body: data);
        print("apply promo code status code: ${response.statusCode}");
        print("apply promo code res: ${response.body}");
        setState(() {
          isLoading = false;
        });
        StatusMessageApiResModel model = StatusMessageApiResModel.fromJson(jsonDecode(response.body.toString()));

        if(response.statusCode == 200 && model.status == 1) {
          edgeAlert(context, title: TranslationConstants.message.t(context), description: model.message!, gravity: Gravity.top);
          MySharedPreferences().addCouponId(couponId);
          setState(() {
            applyBtnTxt = 'Applied';
          });
        }else
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(TranslationConstants.somethingWentWrong.t(context)),));

      }catch(error){
        print("startCharge: $error");
      }
    }
  }
}
