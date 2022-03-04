import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:qcharge_flutter/common/constants/route_constants.dart';
import 'package:qcharge_flutter/common/constants/size_constants.dart';
import 'package:qcharge_flutter/common/constants/translation_constants.dart';
import 'package:qcharge_flutter/common/extensions/size_extensions.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';
import 'package:qcharge_flutter/presentation/blocs/home/profile_cubit.dart';
import 'package:qcharge_flutter/presentation/blocs/login/login_cubit.dart';
import 'package:qcharge_flutter/presentation/journeys/drawer/navigation_drawer.dart';
import 'package:qcharge_flutter/presentation/journeys/qr_code/mySharedPreferences.dart';
import 'package:qcharge_flutter/presentation/libraries/dialog_rflutter/rflutter_alert.dart';
import 'package:qcharge_flutter/presentation/libraries/edge_alerts/edge_alerts.dart';
import 'package:qcharge_flutter/presentation/libraries/liquid_linear_progress_bar/liquid_linear_progress_indicator.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/app_bar_home.dart';
import 'package:qcharge_flutter/presentation/widgets/box_txt.dart';
import 'package:qcharge_flutter/presentation/widgets/button.dart';
import 'package:qcharge_flutter/presentation/widgets/cached_net_img_radius.dart';
import 'package:qcharge_flutter/presentation/widgets/no_data_found.dart';
import 'package:qcharge_flutter/presentation/widgets/txt.dart';
import 'package:qcharge_flutter/presentation/widgets/txt_ic_row.dart';

import 'cars.dart';

/*
*  Page content: currentMembershipPlan! == 'Unavailable' means user not subscribed. This info saved in local db and
* used throughout the app to differentiate between sub and non sub user.
*
*
*
* */
class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isAcDeleteFeatureEnable = false;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarHome(context),
      drawer: NavigationDrawer(onTap: (){},),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (BuildContext context, state) {
          if (state is ProfileSuccess) {
            isAcDeleteFeatureEnable = state.model.response!.isDeletedFeatureEnable?? false;
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 85),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 24, bottom: 24),
                          child: cachedNetImgWithRadius(
                            state.model.response!.image!,
                            110,
                            110,
                            60,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: ImgTxtRow(
                                  txt: state.model.response!.name!,
                                  txtColor: AppColor.app_txt_white,
                                  txtSize: 14,
                                  fontWeight: FontWeight.normal,
                                  icon: 'assets/icons/pngs/account_Register_6.png',
                                  icColor: AppColor.app_txt_white,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 12.0),
                                color: Colors.white,
                                height: 1,
                              ),
                              InkWell(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 12),
                                    child: ImgTxtRow(
                                      txt: state.model.response!.currentMembershipPlan! == 'Unavailable'
                                          ? state.model.response!.userLevel! : state.model.response!.currentMembershipPlan!,
                                      txtColor: AppColor.app_txt_white,
                                      txtSize: 14,
                                      fontWeight: FontWeight.normal,
                                      icon: 'assets/icons/pngs/user_class.png',
                                      icColor: AppColor.app_txt_white,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pushNamed(context, RouteList.subscription);
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Txt(
                          txt: TranslationConstants.collectPoint.t(context),
                          txtColor: Colors.white,
                          txtSize: 13,
                          fontWeight: FontWeight.normal,
                          padding: 0,
                          onTap: () {},
                        ),
                        Txt(
                          txt: '${state.model.response!.collectPoint!}/500 ${TranslationConstants.points.t(context)}',
                          txtColor: Colors.white,
                          txtSize: 13,
                          fontWeight: FontWeight.normal,
                          padding: 0,
                          onTap: () {},
                        ),
                      ],
                    ),

                    Container(
                      width: double.infinity,
                      height: 25,
                      margin: EdgeInsets.only(bottom: 3, top: 8),
                      child: LiquidLinearProgressIndicator(
                        value: double.parse(state.model.response!.collectPoint!) / 1000,
                        backgroundColor: AppColor.grey,
                        valueColor: AlwaysStoppedAnimation(AppColor.border),
                        borderColor: Colors.grey,
                        borderWidth: 1.0,
                        borderRadius: 6.0,
                      ),
                    ),

                    Visibility(
                      visible: state.model.response!.currentMembershipPlan! == 'Unavailable',
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Button(
                          text: TranslationConstants.subscribeNow.t(context),
                          bgColor: [Color(0xFFEFE07D), Color(0xFFB49839)],
                          onPressed: () {
                            Navigator.pushNamed(context, RouteList.subscription);
                          },
                        ),
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
                            colors: [Colors.grey.shade600, Colors.grey.shade600]),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_8.w),
                      margin: EdgeInsets.only(top: Sizes.dimen_8.h),
                      width: double.infinity,
                      height: 45,
                      child: TextButton(
                        onPressed: () async {
                          http.Response tokenResponse = await http.get(Uri.parse("http://qcapp2134.arrow-energy.com/qcharge/api/token"));
                          //print("token api status code: ${tokenResponse.statusCode}");
                          //print("token api response body: ${tokenResponse.body}");
                          Map<String, dynamic> tokenResult = jsonDecode(tokenResponse.body);
                          MySharedPreferences().addApiToken(tokenResult["accessToken"]);
                          String? cardNo = await MySharedPreferences().getCardNo();
                          if (tokenResponse.statusCode == 200) {
                            try {
                              //print('---- cardNo: $cardNo');
                              http.Response response = await http.get(Uri.parse("http://qcapp2134.arrow-energy.com/qcharge/api/transaction/$cardNo"));
                              //print("Transaction API response: ${response.body}");

                              if (response.statusCode == 200) {
                                var resData = jsonDecode(response.body.toString());

                                //print('----status: ${resData["status"]}');
                                //print('----message: ${resData["message"]}');


                                // If status is true, car charging is finished and navigating to finish page to show charging summary.
                                // If status is false, car still charging and navigating to stop page to show charging status

                                if(resData["status"]){
                                  //MySharedPreferences().addIsShowingSummary('');

                                  Navigator.pushNamed(context, RouteList.finish);
                                } else {
                                  //edgeAlert(context, title: TranslationConstants.warning.t(context), description: resData["message"], gravity: Gravity.top);
                                  Navigator.pushNamed(context, RouteList.stop);
                                }
                              } else
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Something went wrong."),
                                  ),
                                );
                            } catch (error) {
                              print("charging: $error");
                            }

                          }
                        },
                        child: Text(
                          TranslationConstants.chargingStatus.t(context),
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),

                    // This due ui only show if user has subscribed
                    Visibility(
                      visible: state.model.response!.currentMembershipPlan! != 'Unavailable',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          BoxTxt(
                              txt1: ' ${TranslationConstants.activePlan.t(context)} >',
                              txt2: state.model.response!.currentMembershipPlan!,
                              txt3: state.model.response!.currentMembershipPlanPrice!,
                              rightPadding: 12,
                              topPadding: 0,
                              onTap: () {
                                Navigator.pushNamed(context, RouteList.subscription);
                              }),

                          BoxTxt(
                              txt1: ' ${TranslationConstants.dueBill.t(context)} >',
                              txt2: TranslationConstants.total.t(context),
                              txt3: state.model.response!.dueBilling!,
                              rightPadding: 0,
                              topPadding: 0,
                              onTap: () async {
                                Navigator.pushNamed(context, RouteList.billing);
                              }),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: TextFormField(
                        initialValue: state.model.response!.email!,
                        autocorrect: true,
                        keyboardType: TextInputType.emailAddress,
                        readOnly: true,
                        //validator: validator,
                        //onSaved: onSaved,
                        decoration: InputDecoration(
                          hintText: TranslationConstants.email.t(context),
                          contentPadding: EdgeInsets.only(top: 15),
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(top: 8, bottom: 8, right: 24),
                            child: Image.asset(
                              'assets/icons/pngs/account_Register_7.png',
                              width: 15,
                              height: 15,
                            ),
                          ),
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 14),
                      child: TextFormField(
                        initialValue: state.model.response!.mobile!,
                        autocorrect: true,
                        keyboardType: TextInputType.phone,
                        readOnly: true,
                        //validator: validator,
                        //onSaved: onSaved,
                        decoration: InputDecoration(
                          hintText: TranslationConstants.phoneNumber.t(context),
                          contentPadding: EdgeInsets.only(top: 15),
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(top: 11, bottom: 11, right: 28),
                            child: Image.asset(
                              'assets/icons/pngs/account_Register_1.png',
                              width: 15,
                              height: 15,
                            ),
                          ),
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(top: 14),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1.0, color: Colors.white70),
                        ),
                      ),
                      child: InkWell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/icons/pngs/profile_screen_8_car.png',
                              width: 26,
                              height: 26,
                              color: Colors.white,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8, top: 8, bottom: 14),
                              child: Text(
                                '   ${TranslationConstants.myCar.t(context)}      ',
                                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14, color: Colors.white),
                                maxLines: 4,
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Icon(Icons.keyboard_arrow_right_rounded),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Cars(),
                            ),
                          );
                        },
                      ),
                    ),

                    // Logout user and clean login data fom local db
                    BlocListener<LoginCubit, LoginState>(
                      listenWhen: (previous, current) => current is LogoutSuccess,
                      listener: (context, state) {
                        Navigator.of(context).pushNamedAndRemoveUntil(RouteList.initial, (route) => false);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: isAcDeleteFeatureEnable ?  0 : 35,
                            top: 16,
                        ),
                        child: Button(
                          text: TranslationConstants.logoutCaps.t(context),
                          bgColor: [Color(0xFFEFE07D), Color(0xFFB49839)],
                          onPressed: () {
                            Alert(
                              context: context,
                              onWillPopActive: true,
                              title: TranslationConstants.logout.t(context),
                              desc: TranslationConstants.logoutDialogContent.t(context),
                              image: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Icon(
                                    Icons.logout_outlined,
                                    color: AppColor.border,
                                    size: 80,
                                  )),
                              closeIcon: IconButton(
                                  onPressed: () {
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
                                      TranslationConstants.cancel.t(context),
                                    style: TextStyle(color: Colors.black, fontSize: 14),
                                  ),
                                ),
                                DialogButton(
                                  color: Colors.amber,
                                  onPressed: () {
                                    BlocProvider.of<LoginCubit>(context).logout();
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    TranslationConstants.logout.t(context),
                                    style: TextStyle(color: Colors.black, fontSize: 14),
                                  ),
                                )
                              ],
                            ).show();

                          },
                        ),
                      ),
                    ),

                    // Logout user and clean login data fom local db
                    Visibility(
                      visible: isAcDeleteFeatureEnable,
                      child: BlocListener<LoginCubit, LoginState>(
                        listenWhen: (previous, current) => current is DeleteUserSuccess,
                        listener: (context, state) {
                          Navigator.of(context).pushNamedAndRemoveUntil(RouteList.initial, (route) => false);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 35,),
                          child: Button(
                            text: TranslationConstants.deleteAc.t(context),
                            bgColor: [Color(0xFFEFE07D), Color(0xFFB49839)],
                            onPressed: () {
                              if (state.model.response!.paymentFlag! == 0) {
                                Alert(
                                  context: context,
                                  onWillPopActive: true,
                                  title: TranslationConstants.exitDialogTitle.t(context),
                                  desc: TranslationConstants.deleteAcDialogContent.t(context),
                                  image: Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: Icon(
                                        Icons.delete,
                                        color: AppColor.border,
                                        size: 80,
                                      )),
                                  closeIcon: IconButton(
                                      onPressed: () {
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
                                        TranslationConstants.cancel.t(context),
                                        style: TextStyle(color: Colors.black, fontSize: 14),
                                      ),
                                    ),
                                    DialogButton(
                                      color: Colors.amber,
                                      onPressed: () {
                                        BlocProvider.of<LoginCubit>(context).deleteUserAc();
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        TranslationConstants.delete.t(context),
                                        style: TextStyle(color: Colors.black, fontSize: 14),
                                      ),
                                    )
                                  ],
                                ).show();
                              } else edgeAlert(context, title: TranslationConstants.warning.t(context), description: TranslationConstants.dueClearText.t(context));
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return NoDataFound(
              txt: TranslationConstants.noDataFound.t(context),
              onRefresh: () {
                Navigator.of(context).pushNamedAndRemoveUntil(RouteList.home_screen,(route) => false,);
              },
            );
          }
        },
      ),
    );
  }
}
