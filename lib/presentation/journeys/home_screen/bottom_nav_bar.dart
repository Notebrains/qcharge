import 'package:flutter/material.dart';
import 'package:qcharge_flutter/common/constants/translation_constants.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';
import 'package:qcharge_flutter/presentation/journeys/drawer/navigation_drawer.dart';
import 'package:qcharge_flutter/presentation/journeys/home_screen/home.dart';
import 'package:qcharge_flutter/presentation/journeys/map_screen/map_screen.dart';
import 'package:qcharge_flutter/presentation/journeys/profile/profile.dart';
import 'package:qcharge_flutter/presentation/journeys/qr_code/qr_code.dart';
import 'package:qcharge_flutter/presentation/journeys/topup/topup.dart';
import 'package:qcharge_flutter/presentation/libraries/bottom_navbar_center_round/pandabar.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';

class BottomNavbar extends StatefulWidget {
  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  String page = 'Home';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        drawer: NavigationDrawer(),
        extendBody: true,
        backgroundColor: AppColor.app_bg,
        bottomNavigationBar: PandaBar(
          buttonSelectedColor: AppColor.app_ic,
          backgroundColor: AppColor.grey,
          buttonColor: AppColor.app_txt_white,
          buttonData: [
            PandaBarButtonData(
                id: 'Home',
                icon: 'assets/icons/pngs/create_account_home.png',
                title:  TranslationConstants.home.t(context),
            ),
            PandaBarButtonData(
                id: 'Map',
                icon: 'assets/icons/pngs/create_account_map.png',
                title:  TranslationConstants.map.t(context),
            ),
            PandaBarButtonData(
                id: 'Top Up',
                icon: 'assets/icons/pngs/create_account_top_up_1.png',
                title:  TranslationConstants.topUp.t(context),
            ),
            PandaBarButtonData(
                id: 'Profile',
                icon: 'assets/icons/pngs/create_account_profile.png',
                title:  TranslationConstants.profile.t(context),
            ),
          ],
          onChange: (id) {
            setState(() {
              page = id;
            });
          },
          onFabButtonPressed: () {
            setState(() {
              page = 'QrCode';
            });
          },
        ),

        body: Builder(
          builder: (context) {
            switch (page) {
              case 'Map':
                return MapScreen();
              case 'Top Up':
                return TopUp();
              case 'Home':
                return Home();
              case 'QrCode':
                return QrCode();
              case 'Profile':
                return Profile();
              default:
                return Home();
            }
          },
        ),
      ),
    );
  }


  Future<bool> onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) =>
      new AlertDialog(
        title: Text( TranslationConstants.exitDialogTitle.t(context)),
        content: Text( TranslationConstants.exitDialogContent.t(context)),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text( TranslationConstants.no.t(context)),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text( TranslationConstants.yes.t(context),),
          ),
        ],
      ),
    )) ?? false;
  }
}
