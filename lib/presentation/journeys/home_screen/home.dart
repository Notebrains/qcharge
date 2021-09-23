import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcharge_flutter/common/constants/translation_constants.dart';
import 'package:qcharge_flutter/presentation/blocs/home/home_banner_cubit.dart';
import 'package:qcharge_flutter/presentation/journeys/drawer/navigation_drawer.dart';
import 'package:qcharge_flutter/presentation/journeys/home_screen/home_card.dart';
import 'package:qcharge_flutter/presentation/widgets/app_bar_home.dart';
import 'package:qcharge_flutter/presentation/widgets/home_card_list.dart';
import 'package:qcharge_flutter/presentation/widgets/home_slider.dart';
import 'package:qcharge_flutter/common/constants/size_constants.dart';
import 'package:qcharge_flutter/common/extensions/size_extensions.dart';
import 'package:qcharge_flutter/presentation/widgets/no_data_found.dart';
import '../../../common/extensions/string_extensions.dart';


class Home extends StatelessWidget{
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
              // print('---- : ${state.model.response![0].image}');
              return Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(vertical: Sizes.dimen_8.h, horizontal: 12),
                    height: Sizes.dimen_80.h,
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        HomeCardList(title: TranslationConstants.promotion.t(context), img: 'assets/images/home_screen_9.png',
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => HomeCards(
                                  screenTitle:  TranslationConstants.promotion.t(context),
                                  urlEndpoint: 'promotion',
                                  ),
                                ),
                              );
                        }),
                        HomeCardList(title: TranslationConstants.activity.t(context), img: 'assets/images/home_screen_8.png',
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomeCards(
                                screenTitle:  TranslationConstants.activity.t(context),
                                urlEndpoint: 'activity',
                                ),
                              ),
                            );
                        },
                        ),

                        HomeCardList(title: TranslationConstants.callCenter.t(context), img: 'assets/images/home_screen_7.png', onTap: (){

                        },
                        ),
                      ],
                    ),
                  ),

                  Container(
                    height: Sizes.dimen_140.h,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: HomeSliderCarouselWithIndicator(model: state.model,),
                  ),
                ],
              );
            } else {
              return NoDataFound(txt: 'No Data Found', onRefresh: (){
              },);
            }
          },
        ),
      ),
    );
  }
}