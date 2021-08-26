import 'package:flutter/material.dart';
import 'package:qcharge_flutter/presentation/journeys/drawer/navigation_drawer.dart';
import 'package:qcharge_flutter/presentation/journeys/qr_code/finish.dart';
import 'package:qcharge_flutter/presentation/journeys/qr_code/start.dart';
import 'package:qcharge_flutter/presentation/widgets/app_bar_home.dart';

class QrCode extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarHome(context),
      drawer: NavigationDrawer(),
      body: Finish(),

    );
  }

}