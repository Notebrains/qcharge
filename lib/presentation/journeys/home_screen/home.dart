import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qcharge_flutter/presentation/widgets/app_bar_home.dart';
import 'package:qcharge_flutter/presentation/widgets/home_card_list.dart';
import 'package:qcharge_flutter/presentation/widgets/home_slider.dart';


class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarHome(context),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(vertical: 36.0, horizontal: 12),
            height: 180.0,
            child: ListView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                HomeCardList(title: 'Promotion', img: 'assets/images/account_success_vector_smart_object.png', onTap: (){}),
                HomeCardList(title: 'Activity', img: 'assets/images/account_success_vector_smart_object.png', onTap: (){}),
                HomeCardList(title: 'Call Center', img: 'assets/images/account_success_vector_smart_object.png', onTap: (){}),
              ],
            ),
          ),

          Container(
            color: Colors.grey,
            //height: Sizes.dimen_110.h,
            height: 330,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: HomeSliderCarouselWithIndicator(),
          ),
        ],
      ),
    );
  }

}