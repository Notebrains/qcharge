import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_version/new_version.dart';
import 'package:qcharge_flutter/common/constants/route_constants.dart';
import 'package:qcharge_flutter/common/constants/size_constants.dart';
import 'package:qcharge_flutter/common/constants/strings.dart';
import 'package:qcharge_flutter/common/constants/translation_constants.dart';
import 'package:qcharge_flutter/common/extensions/size_extensions.dart';
import 'package:qcharge_flutter/presentation/blocs/home/home_banner_cubit.dart';
import 'package:qcharge_flutter/presentation/journeys/drawer/navigation_drawer.dart';
import 'package:qcharge_flutter/presentation/journeys/home_screen/home_card.dart';
import 'package:qcharge_flutter/presentation/widgets/app_bar_home.dart';
import 'package:qcharge_flutter/presentation/widgets/home_card_list.dart';
import 'package:qcharge_flutter/presentation/widgets/home_slider.dart';
import 'package:qcharge_flutter/presentation/widgets/no_data_found.dart';

import '../../../common/extensions/string_extensions.dart';
import '../payments/2c2p_payment_gateway.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? cardNo = '', walletBalance = '', normalCustomerParkingPrice = "", normalCustomerChargingPrice = "";

  @override
  void initState() {
    super.initState();

    // Instantiate NewVersion manager object (Using GCP Console app as example).
    // This package check if app has new version available on app/play store by giving application id for android and bundle id for iOS
    final newVersion = NewVersion(
      iOSId: 'com.arrow.energy.qcharge',
      androidId: 'com.arrowenergy.qcharge',
    );

    // You can let the plugin handle fetching the status and showing a dialog,
    // or you can fetch the status and display your own dialog, or no dialog.
    const simpleBehavior = false;

    if (simpleBehavior) {
      basicStatusCheck(newVersion);
    } else {
      advancedStatusCheck(newVersion);
    }
  }

  basicStatusCheck(NewVersion newVersion) {
    newVersion.showAlertIfNecessary(context: context);
  }

  advancedStatusCheck(NewVersion newVersion) async {
    final status = await newVersion.getVersionStatus();
    if (status != null) {
      /*print(status.releaseNotes);
      print(status.appStoreLink);
      print(status.localVersion);
      print(status.storeVersion);
      print(status.canUpdate.toString());*/

      //
      if (status.canUpdate) {
        newVersion.showUpdateDialog(
          context: context,
          versionStatus: status,
          dialogTitle: 'App Update Available',
          dialogText: "Current version: ${status.localVersion}\nNew version: ${status.storeVersion}\n\n${Strings.updateDescTxt}",
          updateButtonText: 'UPDATE',
          allowDismissal: true,
          dismissButtonText: 'MAYBE LATER',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarHome(context),
      drawer: NavigationDrawer(onTap: () {},),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: BlocBuilder<HomeBannerCubit, HomeBannerState>(
          builder: (BuildContext context, state) {
            if (state is HomeBannerSuccess) {
              return Column(
                children: [
                  //Three cards showing on top of home screen
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(vertical: Sizes.dimen_8.h, horizontal: 12),
                    height: Sizes.dimen_220.w,
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        HomeCardList(
                          title: TranslationConstants.activity.t(context),
                          img: 'assets/images/avtars.png',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeCards(
                                  screenTitle: TranslationConstants.activity.t(context),
                                  urlEndpoint: 'activity',
                                ),
                              ),
                            );
                          },
                        ),
                        HomeCardList(
                            title: TranslationConstants.promotion.t(context),
                            img: 'assets/images/mic.png',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeCards(
                                    screenTitle: TranslationConstants.promotion.t(context),
                                    urlEndpoint: 'promotion',
                                  ),
                                ),
                              );
                            }),

                        HomeCardList(
                          title: TranslationConstants.callCenter.t(context),
                          img: 'assets/images/call_center.png',
                          onTap: () async {
                            Navigator.pushNamed(context, RouteList.call_center);

                           /* Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaymentMethods(onTap: (selectedIndex){
                                    print('----selectedIndex : $selectedIndex');
                                    openPaymentGateway( selectedIndex);
                                }),
                              ),
                            );*/

                             //openPaymentGateway();
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => PgwSdkPayment(),),);
                          },
                        ),
                      ],
                    ),
                  ),

                  //Auto sliding Banner: Carousel Slider With Indicator
                  Container(
                    height: Sizes.dimen_350.w,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: HomeSliderCarouselWithIndicator(
                      model: state.model,
                    ),
                  ),
                ],
              );
            } else {
              return NoDataFound(
                txt: TranslationConstants.loadingCaps.t(context),
                onRefresh: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    RouteList.home_screen,
                    (route) => false,
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }


  //This method called only for testing payment gateway.
  void openPaymentGateway() async {
    try {
      openSandboxQrPaymentGateway('100.00').then((responseJson) => {
            print('-------respCode: ${responseJson["respCode"]}'),
            print('-------failReason: ${responseJson["failReason"]}'),
            print('-------status: ${responseJson["status"]}'),

            /*String amount = responseJson["amt"];
            String respCode = responseJson["respCode"];
            print('----amount: ${responseJson["amt"]}');
            print('----uniqueTransactionCode: ${responseJson["uniqueTransactionCode"]}');
            print('----tranRef: ${responseJson["tranRef"]}');
            print('----approvalCode: ${responseJson["approvalCode"]}');
            print('----refNumber: ${responseJson["refNumber"]}');*/

          });
    } catch (e) {
      print('----Error : $e');
    }
  }
}
