import 'package:flutter/material.dart';
import 'package:qcharge_flutter/data/models/home_banner_api_res_model.dart';
import 'package:qcharge_flutter/presentation/journeys/account/account_stepper.dart';
import 'package:qcharge_flutter/presentation/journeys/account/forgot_password.dart';
import 'package:qcharge_flutter/presentation/journeys/contents/faqs.dart';
import 'package:qcharge_flutter/presentation/journeys/home_screen/home_card.dart';
import 'package:qcharge_flutter/presentation/journeys/review/add_review.dart';
import 'journeys/account/update_profile.dart';
import 'journeys/profile/profile.dart';
import 'journeys/review/review.dart';
import 'journeys/setting/setting.dart';
import 'journeys/home_screen/home_nav_bar.dart';

import '../common/constants/route_constants.dart';
import 'journeys/account/login_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes(RouteSettings setting) => {
        RouteList.initial: (context) => LoginScreen(),
        RouteList.registration: (context) => AccountStepper(),
        RouteList.forgotPassword: (context) => ForgotPassword(),
        RouteList.home_screen: (context) => HomeNavbar(),
        RouteList.add_review: (context) => AddReview(),
        RouteList.review: (context) => Review(),
        RouteList.profile: (context) => Profile(),
        RouteList.setting: (context) => Setting(),
        RouteList.faq: (context) => Faqs(),

        RouteList.activity: (context) => HomeCards(screenTitle: '', urlEndpoint: "",),
        RouteList.update_profile: (context) => UpdateProfile(),
      };
}
