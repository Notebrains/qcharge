import 'package:flutter/material.dart';
import 'package:qcharge_flutter/presentation/journeys/drawer/navigation_drawer.dart';
import 'package:qcharge_flutter/presentation/widgets/app_bar_home.dart';

class ScanQr extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarHome(context),
      drawer: NavigationDrawer(
        onTap: () {},
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/icons/pngs/qr_code.png', color: Colors.amberAccent,),
        ],
      ),
    );
  }

}