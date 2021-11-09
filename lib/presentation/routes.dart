import 'package:flutter/material.dart';
import 'package:qcharge_flutter/presentation/journeys/account/account_stepper.dart';
import 'package:qcharge_flutter/presentation/journeys/account/forgot_password.dart';
import 'package:qcharge_flutter/presentation/journeys/contents/faqs.dart';
import 'package:qcharge_flutter/presentation/journeys/home_screen/home_card.dart';
import 'package:qcharge_flutter/presentation/journeys/subscription/billing.dart';
import 'journeys/home_screen/call_center.dart';
import 'journeys/home_screen/notifications.dart';
import 'journeys/profile/update_profile.dart';
import 'journeys/profile/profile.dart';
import 'journeys/qr_code/finish.dart';
import 'journeys/qr_code/qr_code.dart';
import 'journeys/qr_code/start.dart';
import 'journeys/qr_code/stop.dart';
import 'journeys/map_screen/filters.dart';
import 'journeys/home_screen/home_nav_bar.dart';

import '../common/constants/route_constants.dart';
import 'journeys/account/login_screen.dart';
import 'journeys/subscription/subscription.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes(RouteSettings setting) => {
        RouteList.initial: (context) => LoginScreen(),
        RouteList.registration: (context) => AccountStepper(),
        RouteList.forgotPassword: (context) => ForgotPassword(),
        RouteList.home_screen: (context) => HomeNavbar(page: 'Home',),
        RouteList.profile: (context) => Profile(),
        RouteList.setting: (context) => Setting(),
        RouteList.faq: (context) => Faqs(),

        RouteList.activity: (context) => HomeCards(screenTitle: '', urlEndpoint: "",),
        RouteList.update_profile: (context) => UpdateProfile(),
        RouteList.call_center: (context) => CallCenter(),
        RouteList.subscription: (context) => Subscription(),
        //RouteList.subscription_details: (context) => SubscriptionDetails(details: '',),

        RouteList.qrcode: (context) => QrCode(),
        RouteList.start: (context) => Start(),
        RouteList.stop: (context) => Stop(),
        RouteList.finish: (context) => Finish(),
        RouteList.billing: (context) => Billing(),
        RouteList.notificationsScreen: (context) => NotificationsScreen(),
      };
}
