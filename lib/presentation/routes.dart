import 'package:flutter/material.dart';
import 'package:qcharge_flutter/presentation/journeys/account/account_stepper.dart';
import 'package:qcharge_flutter/presentation/journeys/account/forgot_password.dart';
import 'package:qcharge_flutter/presentation/journeys/contents/faqs.dart';
import 'package:qcharge_flutter/presentation/journeys/home_screen/home_card.dart';
import 'package:qcharge_flutter/presentation/journeys/subscription/subscription_details.dart';
import 'journeys/account/update_profile.dart';
import 'journeys/profile/cars.dart';
import 'journeys/profile/profile.dart';
import 'journeys/setting/setting.dart';
import 'journeys/home_screen/home_nav_bar.dart';

import '../common/constants/route_constants.dart';
import 'journeys/account/login_screen.dart';
import 'journeys/subscription/subscription.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes(RouteSettings setting) => {
        RouteList.initial: (context) => LoginScreen(),
        RouteList.registration: (context) => AccountStepper(),
        RouteList.forgotPassword: (context) => ForgotPassword(),
        RouteList.home_screen: (context) => HomeNavbar(),
        RouteList.profile: (context) => Profile(),
        RouteList.setting: (context) => Setting(),
        RouteList.faq: (context) => Faqs(),

        RouteList.activity: (context) => HomeCards(screenTitle: '', urlEndpoint: "",),
        RouteList.update_profile: (context) => UpdateProfile(),
        //RouteList.cars: (context) => Cars(),
        RouteList.subscription: (context) => Subscription(),
        RouteList.subscription_details: (context) => SubscriptionDetails(),
      };
}
