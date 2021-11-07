import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcharge_flutter/common/constants/route_constants.dart';
import 'package:qcharge_flutter/common/constants/translation_constants.dart';
import 'package:qcharge_flutter/common/extensions/common_fun.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';
import 'package:qcharge_flutter/presentation/blocs/home/profile_cubit.dart';
import 'package:qcharge_flutter/presentation/blocs/login/login_cubit.dart';
import 'package:qcharge_flutter/presentation/journeys/drawer/navigation_drawer.dart';
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

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarHome(context),
      drawer: NavigationDrawer(),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (BuildContext context, state) {
          if (state is ProfileSuccess) {
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
                                          ? 'Silver Class'
                                          : state.model.response!.currentMembershipPlan!,
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
                          txt: '${state.model.response!.collectPoint!} points',
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
                        padding: const EdgeInsets.only(top: 22),
                        child: Button(
                          text: TranslationConstants.subscribeNow.t(context),
                          bgColor: [Color(0xFFEFE07D), Color(0xFFB49839)],
                          onPressed: () {
                            Navigator.pushNamed(context, RouteList.subscription);
                          },
                        ),
                      ),
                    ),

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
                              topPadding: 12,
                              onTap: () {
                                Navigator.pushNamed(context, RouteList.subscription);
                              }),

                          BoxTxt(
                              txt1: ' ${TranslationConstants.dueBill.t(context)} >',
                              txt2: TranslationConstants.total.t(context),
                              txt3: convertStrToDoubleStr(state.model.response!.dueBilling.toString()),
                              rightPadding: 0,
                              topPadding: 12,
                              onTap: () async {
                                Navigator.pushNamed(context, RouteList.billing);
                              }),
                        ],
                      ),
                    ),



                    Padding(
                      padding: const EdgeInsets.only(top: 12),
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
                      padding: const EdgeInsets.only(top: 16),
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
                      padding: const EdgeInsets.only(top: 16),
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
                              builder: (context) => Cars(
                                carList: state.model.response!.vehicles!,
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    BlocListener<LoginCubit, LoginState>(
                      listenWhen: (previous, current) => current is LogoutSuccess,
                      listener: (context, state) {
                        Navigator.of(context).pushNamedAndRemoveUntil(RouteList.initial, (route) => false);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 56, top: 34),
                        child: Button(
                          text: TranslationConstants.logoutCaps.t(context),
                          bgColor: [Color(0xFFEFE07D), Color(0xFFB49839)],
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => CupertinoAlertDialog(
                                title: new Text(TranslationConstants.logout.t(context)),
                                content: new Text(TranslationConstants.logoutDialogContent.t(context)),
                                actions: <Widget>[
                                  CupertinoDialogAction(
                                    isDefaultAction: true,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      TranslationConstants.cancel.t(context),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  CupertinoDialogAction(
                                    isDefaultAction: true,
                                    onPressed: () {
                                      BlocProvider.of<LoginCubit>(context).logout();
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      TranslationConstants.logout.t(context),
                                      style: TextStyle(color: Colors.amber),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
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
