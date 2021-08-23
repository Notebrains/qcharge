import 'package:flutter/material.dart';
import 'package:qcharge_flutter/presentation/journeys/review/add_review.dart';
import 'journeys/profile/profile.dart';
import 'journeys/review/review.dart';
import 'journeys/setting/setting.dart';
import 'journeys/home_screen/bottom_nav_bar.dart';

import '../common/constants/route_constants.dart';
import 'journeys/login/login_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes(RouteSettings setting) => {
        RouteList.initial: (context) => LoginScreen(),
        RouteList.login: (context) => LoginScreen(),

        RouteList.home_screen: (context) => BottomNavbar(),
        RouteList.add_review: (context) => AddReview(),
        RouteList.review: (context) => Review(),
        RouteList.profile: (context) => Profile(),
        RouteList.setting: (context) => Setting(),
      };
}
