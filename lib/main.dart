import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';
import 'package:pedantic/pedantic.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';


import 'di/get_it.dart' as getIt;
import 'presentation/root_app.dart';


//This function will call if app run on background
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  //print("Handling a background message-messageId: ${message.messageId}");
  //print("Handling a background message-title: ${message.notification.title}");
}

void main() async {
  // Set screen orientation to portrait
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));

  //Change the color off app status bar
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: AppColor.notification_bar));

  //firebase init for notification
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  //Init hive local database
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  //init get it package for dependency injection
  unawaited(getIt.init());

  runApp(RootApp());
}
