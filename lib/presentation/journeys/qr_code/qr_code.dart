import 'package:flutter/material.dart';
import 'package:qcharge_flutter/presentation/journeys/drawer/navigation_drawer.dart';
import 'package:qcharge_flutter/presentation/journeys/qr_code/finish.dart';
import 'package:qcharge_flutter/presentation/widgets/app_bar_home.dart';

import 'next.dart';
import 'start.dart';
import 'stop.dart';

class QrCode extends StatefulWidget{

  @override
  _QrCodeState createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  late String screenTitle = 'next';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarHome(context),
      drawer: NavigationDrawer(),
      body: loadNextScreen(),
    );
  }

  Widget loadNextScreen(){
    print('----Screen Title : $screenTitle');
    switch (screenTitle) {
      case 'next':
        return Next(onTap:(){
          setState(() {
            screenTitle = 'start';
          });
        },);
      case 'start':
        return Start(onTap:(){
          setState(() {
            screenTitle = 'stop';
          });
        },);
      case 'stop':
        return Stop(onTap:(){
          setState(() {
            screenTitle = 'finish';
          });
        },);
      case 'finish':
        return Finish(onTap:(){
          setState(() {
            screenTitle = 'next';
          });
        },);
      default:
        return Next(onTap:(){
          setState(() {
            setState(() {
              screenTitle = 'next';
            });
          });
        },);
    }
  }
}