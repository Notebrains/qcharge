import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:qcharge_flutter/common/constants/languages.dart';
import 'package:qcharge_flutter/common/constants/route_constants.dart';
import 'package:qcharge_flutter/common/screenutil/screenutil.dart';
import 'package:qcharge_flutter/di/get_it.dart';
import 'package:qcharge_flutter/presentation/blocs/language/language_cubit.dart';
import 'package:qcharge_flutter/presentation/blocs/loading/loading_cubit.dart';
import 'package:qcharge_flutter/presentation/blocs/theme/theme_cubit.dart';
import 'app_localizations.dart';
import 'blocs/login/login_cubit.dart';
import 'fade_page_route_builder.dart';
import 'journeys/loading/loading_screen.dart';
import 'routes.dart';
import 'themes/theme_color.dart';
import 'themes/theme_text.dart';

class RootApp extends StatefulWidget {
  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  late LanguageCubit _languageCubit;
  late LoginCubit _loginBloc;
  late LoadingCubit _loadingCubit;
  late ThemeCubit _themeCubit;

  late FirebaseMessaging messaging;
  late FlutterLocalNotificationsPlugin fltNotification;

  @override
  void initState() {
    super.initState();
    _languageCubit = getItInstance<LanguageCubit>();
    _languageCubit.loadPreferredLanguage();
    _loginBloc = getItInstance<LoginCubit>();
    _loadingCubit = getItInstance<LoadingCubit>();
    _themeCubit = getItInstance<ThemeCubit>();
    _themeCubit.loadPreferredTheme();

    // firebase notification
    messaging = FirebaseMessaging.instance;
    notificationPermission();
    initMessaging();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void getToken() async {
    print(await messaging.getToken());
  }


  @override
  void dispose() {
    _languageCubit.close();
    _loginBloc.close();
    _loadingCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageCubit>.value(value: _languageCubit),
        BlocProvider<LoginCubit>.value(value: _loginBloc),
        BlocProvider<LoadingCubit>.value(value: _loadingCubit),
        BlocProvider<ThemeCubit>.value(value: _themeCubit),
      ],
      child: BlocBuilder<ThemeCubit, Themes>(
        builder: (context, theme) {
          return BlocBuilder<LanguageCubit, Locale>(
            builder: (context, locale) {
              return MaterialApp(
                navigatorKey: _navigatorKey,
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  unselectedWidgetColor: AppColor.secondary_color,
                  primaryColor: AppColor.primary_color,
                  accentColor: AppColor.app_txt_white,
                  scaffoldBackgroundColor: AppColor.app_bg,
                  brightness: Brightness.dark,
                  cardTheme: CardTheme(color: Colors.white,),
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  textTheme: ThemeText.getTextTheme(),
                  appBarTheme: const AppBarTheme(elevation: 0),
                  inputDecorationTheme: InputDecorationTheme(
                    hintStyle: Theme.of(context).textTheme.greySubtitle1,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                  ),
                ),
                supportedLocales: Languages.languages.map((e) => Locale(e.code)).toList(),
                locale: locale,
                localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                builder: (context, child) {
                  var size = MediaQuery.of(context).size;
                  ScreenUtil().setWidth(size.width);
                  ScreenUtil().setHeight(size.height - MediaQuery.of(context).padding.top - 65);

                  return LoadingScreen(
                    screen: child!,
                  );

                  //return HomeNavbar();
                },
                initialRoute: RouteList.initial,
                onGenerateRoute: (RouteSettings settings) {
                  final routes = Routes.getRoutes(settings);
                  final WidgetBuilder? builder = routes[settings.name];
                  return FadePageRouteBuilder(
                    builder: builder!,
                    settings: settings,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }


  void initMessaging() async {
    var androidInit = const AndroidInitializationSettings('ic_notification');
    var iosInit = const IOSInitializationSettings();
    var initSetting = InitializationSettings(android: androidInit, iOS: iosInit);

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'qcharge_channel_id', // id //change here
      'Q Charge', // title
      'This notification is from  Stories', // description
      importance: Importance.max,
    );

    fltNotification = FlutterLocalNotificationsPlugin();
    await fltNotification
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    fltNotification.initialize(initSetting);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      //Show local notification when app in foreground and message is received.
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null && android != null) {
        print('Message also contained a notification: ${message.data}');
        fltNotification.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                icon: android.smallIcon,
                // other properties...
              ),
              iOS: IOSNotificationDetails(),
            ),
            payload: message.data['game_data'] ?? '');

        fltNotification.initialize(initSetting, onSelectNotification: onSelectNotification);
      }
    });
  }

  Future onSelectNotification(String? payload) async {
    if (payload != null && payload.isNotEmpty) {
      print('----payload: $payload');
      openPageWithData(payload);
    }
  }

  void notificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await messaging.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

  void initUserInteractionOnNotification() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen

    //print('----Firebase notification data onClicked 1: ${initialMessage.data}');
    //print('----Firebase notification contentAvailable onClicked 1: ${initialMessage.contentAvailable}');

    if (initialMessage != null && initialMessage.data['game_data'] != null) {
      print('----Firebase notification data onClicked 1: ${initialMessage.data}');
      openPageWithData(initialMessage.data['game_data']);
    } else {
      //Open Page
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('----Firebase notification data onClicked 2: ${message.data}');
      if (message != null && message.data['game_data'] != null) {
        openPageWithData(message.data['game_data']);
      } else {
        //Open Page
      }
    });
  }

  void openPageWithData(String payload) {
    try {
      // get data from payload and navigate to screen
      var gameNotiData = json.decode(payload);
      print('-----openPageWithData: $gameNotiData');
      /*
      output
      {gameType: test, friendName: Imdadul, gameCat4: 1991-2000, friendId: MEM000033, playerType: bowler, friendImage:
      https://lh3.googleusercontent.com/a-/AOh14GhhY4WoN2ln1gzcQE_QSQ3tOtyjWCk3oHEniCp4=s96-c, gameCat1: sports, gameCat2: cricket,
       gameCat3: IPL, cardsToPlay: 120}
       */

      print('----- ${gameNotiData['gameCat1']}');
      //MyRootApp.navigatorKey.currentState.push(MaterialPageRoute(builder: (_) => HomeNavigation(),),);
    } catch (e) {
      print(e);
    }
  }


/* Notification data ex:
Message data: {game_data: {"gameType":"test","friendName":"Imdadul","gameCat4":"1991-2000","friendId":"MEM000033",
"playerType":"bowler","friendImage":"https:\/\/lh3.googleusercontent.com\/a-\/AOh14GhhY4WoN2ln1gzcQE_QSQ3tOtyjWCk3oHEniCp4=s96-c",
"gameCat1":"sports","gameCat2":"cricket","gameCat3":"IPL","cardsToPlay":"120"}, click_action: FLUTTER_NOTIFICATION_CLICK}
*/
}