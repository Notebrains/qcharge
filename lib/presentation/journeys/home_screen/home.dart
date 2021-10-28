import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcharge_flutter/common/constants/route_constants.dart';
import 'package:qcharge_flutter/common/constants/size_constants.dart';
import 'package:qcharge_flutter/common/constants/translation_constants.dart';
import 'package:qcharge_flutter/common/extensions/size_extensions.dart';
import 'package:qcharge_flutter/data/models/home_banner_api_res_model.dart';
import 'package:qcharge_flutter/presentation/blocs/home/home_banner_cubit.dart';
import 'package:qcharge_flutter/presentation/journeys/drawer/navigation_drawer.dart';
import 'package:qcharge_flutter/presentation/journeys/home_screen/home_card.dart';
import 'package:qcharge_flutter/presentation/libraries/dialog_rflutter/rflutter_alert.dart';
import 'package:qcharge_flutter/presentation/widgets/app_bar_home.dart';
import 'package:qcharge_flutter/presentation/widgets/home_card_list.dart';
import 'package:qcharge_flutter/presentation/widgets/home_slider.dart';
import 'package:qcharge_flutter/presentation/widgets/no_data_found.dart';

import '../../../common/extensions/string_extensions.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarHome(context),
      drawer: NavigationDrawer(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: BlocBuilder<HomeBannerCubit, HomeBannerState>(
          builder: (BuildContext context, state) {
            if (state is HomeBannerSuccess) {
              //showUpdateDialog(context, state.model.response!);
              return Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(vertical: Sizes.dimen_8.h, horizontal: 12),
                    height: Sizes.dimen_220.w,
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        HomeCardList(
                            title: TranslationConstants.promotion.t(context),
                            img: 'assets/images/home_screen_9.png',
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
                          title: TranslationConstants.activity.t(context),
                          img: 'assets/images/home_screen_8.png',
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
                          title: TranslationConstants.callCenter.t(context),
                          img: 'assets/images/home_screen_7.png',
                          onTap: () {
                            Navigator.pushNamed(context, RouteList.call_center);

                            /*Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomeCards(
                              screenTitle: TranslationConstants.activity.t(context),
                              urlEndpoint: 'activity',
                            ),
                            ),
                          );*/
                          },
                        ),
                      ],
                    ),
                  ),
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

  void showUpdateDialog(BuildContext context, List<Response> response) {
    /*
                      String title = "App Update Available";
                      String btnLabel = "Update Now";
                      String btnLabelCancel = "Later";
                      String btnLabelDontAskAgain = "Don't ask me again";
                      return DoNotAskAgainDialog(
                        'kUpdateDialogKeyName',
                        title,
                        'A newer version of the app is available',
                */

    Alert(
      context: context,
      title: "App Update Available",
      desc: "A newer version of the app is available\n",
      image: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Icon(Icons.system_update_rounded, size: 100,),
      ),
      buttons: [
        DialogButton(
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Update Now',
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
        ),
        DialogButton(
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Later',
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
        )
      ],
    ).show();
  }
}
