import 'package:flutter/material.dart';
import 'package:qcharge_flutter/common/constants/route_constants.dart';
import 'package:qcharge_flutter/data/models/home_category_model.dart';
import 'package:qcharge_flutter/presentation/journeys/home_screen/home.dart';
import 'package:qcharge_flutter/presentation/journeys/menu/menu.dart';
import 'package:qcharge_flutter/presentation/journeys/profile/profile.dart';
import 'package:qcharge_flutter/presentation/journeys/setting/setting.dart';
import 'package:qcharge_flutter/presentation/libraries/bottom_navbar_center_round/pandabar.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/app_bar_home.dart';

class BottomNavbar extends StatefulWidget {
  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  String page = 'Home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              title: 'Home'
          ),
          PandaBarButtonData(
              id: 'Map',
              icon: 'assets/icons/pngs/create_account_map.png',
              title: 'Map'
          ),
          PandaBarButtonData(
              id: 'Top Up',
              icon: 'assets/icons/pngs/create_account_top_up_1.png',
              title: 'Top Up'
          ),
          PandaBarButtonData(
              id: 'Profile',
              icon: 'assets/icons/pngs/create_account_profile.png',
              title: 'Profile'
          ),
        ],
        onChange: (id) {
          setState(() {
            page = id;
          });
        },
        onFabButtonPressed: () {

        },
      ),

      body: Builder(
        builder: (context) {
          switch (page) {
            case 'Map':
              return Container(color: Colors.grey.shade900);
            case 'Top Up':
              return Container(color: Colors.blue.shade900);
            case 'Home':
              return Home();
            case 'Profile':
              return Profile();
            default:
              return Home();
          }
        },
      ),
    );
  }
}
