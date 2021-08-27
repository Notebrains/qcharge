import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';
import 'package:pedantic/pedantic.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';

import 'data/tables/movie_table.dart';
import 'di/get_it.dart' as getIt;
import 'presentation/root_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColor.notification_bar
  ));
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(MovieTableAdapter());
  unawaited(getIt.init());
  runApp(RootApp());
}
