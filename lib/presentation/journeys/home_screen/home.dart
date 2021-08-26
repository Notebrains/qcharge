import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qcharge_flutter/presentation/journeys/drawer/navigation_drawer.dart';
import 'package:qcharge_flutter/presentation/journeys/home_screen/activity.dart';
import 'package:qcharge_flutter/presentation/journeys/setting/setting.dart';
import 'package:qcharge_flutter/presentation/widgets/app_bar_home.dart';
import 'package:qcharge_flutter/presentation/widgets/home_card_list.dart';
import 'package:qcharge_flutter/presentation/widgets/home_slider.dart';


class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarHome(context),
      drawer: NavigationDrawer(),
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
                HomeCardList(title: 'Promotion', img: 'assets/images/home_screen_9.png', onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Activity(screenTitle: 'Promotion',)),
                  );
                }),
                HomeCardList(title: 'Activity', img: 'assets/images/home_screen_8.png', onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Activity(screenTitle: 'Activity',)),
                  );
                  },
                ),

                HomeCardList(title: 'Call Center', img: 'assets/images/home_screen_7.png', onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Setting()),
                  );
                  },
                ),
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