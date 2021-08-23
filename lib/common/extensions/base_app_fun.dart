import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void setScreenOrientationToLandscape(){
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // SystemChrome.setEnabledSystemUIOverlays([]);
}

void goBackToPreviousScreen(BuildContext context){
  if (Navigator.canPop(context)) {
    Navigator.pop(context);
  } else {
    SystemNavigator.pop();
  }
}