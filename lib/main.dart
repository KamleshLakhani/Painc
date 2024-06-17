import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:painc/DashboardActivity/MedicationInsertionActivity.dart';
import 'package:painc/DashboardActivity/PainIntensityInsertionActivity.dart';
import 'package:painc/Utils/Constants.dart';
import 'package:painc/Utils/routes.dart';
import 'package:painc/screens/Dashboard.dart';
import 'package:painc/screens/LoginActivity.dart';
import 'package:painc/DrawerActivity/ProfileUpdateActivity.dart';
import 'package:painc/IntroductionActivity/splashscreen.dart';
import 'package:painc/GetX/connectivity.dart';
import 'IntroductionActivity/GetStartedActivity.dart';
import 'Utils/Utils.dart';
import 'screens/CreateNewPasswordActivity.dart';
InternetConnectivity internet = Get.put(InternetConnectivity());
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}
const AndroidNotificationChannel channel = const AndroidNotificationChannel(
'high_importance_channel', // id
'High Importance Notifications', // title
'This channel is used for important notifications.', // description
importance: Importance.high,
);
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
  await GetStorage.init();
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  Future onDidRecieveLocalNotification(int id, String title, String body, String payload) async {
// display a dialog with the notification details, tap ok to go to another page
  }
  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  }
  Future<String>getToken() async {
    var token = await FirebaseMessaging.instance.getToken();
    print('TOKENTOKEN $token');
    return token;
  }
  @override
  void initState() {
   initnotification();
    getToken();
    super.initState();
  }
  void initnotification() {

    var initializationsettingsAndroid = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();

    if(Platform.isIOS){_requestIOSPermission();}

    var initializationsettings = new InitializationSettings(android: initializationsettingsAndroid,iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializationsettings,onSelectNotification: onSelectNotification);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async{
      RemoteNotification notification = message.notification;
      var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
          'Painc', 'notification', 'Painc',
          playSound: true, importance: Importance.max, priority: Priority.high);
      var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
      var platformChannelSpecifics = new NotificationDetails(
          android: androidPlatformChannelSpecifics,
          iOS: iOSPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.show(
        0,
        (notification.title == null || notification.title == '') ? 'From Painc' : notification.title,
        notification.body,
        platformChannelSpecifics,
        payload: 'notification',
      );
    });

    /*FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channel.description,
                  icon: '@mipmap/ic_launcher',
                ),
                iOS: IOSNotificationDetails(
                  subtitle: channel.name,
                  presentBadge: true,
                  presentSound: true,
                  presentAlert: true,
                  threadIdentifier: channel.description,
                )
            ));
      }
    });*/
  }
  Future _showNotificationWithSound(String title, String body) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'Villezone', 'notification', 'Villezone',
        playSound: true, importance: Importance.max, priority: Priority.high);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      (title == null || title == '') ? 'From VilleZone' : title,
      body,
      platformChannelSpecifics,
      payload: 'notification',
    );
  }
  FirebaseMessaging _messaging = FirebaseMessaging.instance;
  _requestIOSPermission() async{
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
   /* flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        .requestPermissions(alert: true,badge: true,sound: true);*/
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: internet.nav,
      title: 'Painc',
      theme: ThemeData(
        accentColor: Utils.bottleclr,
        colorScheme: ColorScheme.light(primary: Utils.bottleclr),
        scaffoldBackgroundColor: Utils.white,
        fontFamily: 'Nunito',
      ),
      home: SplashScreen(),
      /*initialRoute: Routes.splash,*/
      /*home: Constant.token != '' ? Dashboard() :GetStarted(),*/
      /*getPages: [
        GetPage(name: Routes.splash, page: ()=>SplashScreen()),
        GetPage(name: Routes.getstarted, page: ()=>GetStarted()),
        GetPage(name: Routes.login, page: ()=>Login()),
        GetPage(name: Routes.editprofile, page: ()=>EditProfile()),
        GetPage(name: Routes.dashboard, page: ()=>Dashboard()),
      ],*/
      routes: {
        Routes.splash: (context) => SplashScreen(),
        Routes.getstarted: (context) => GetStarted(),
        Routes.login: (context) => Login(),
        Routes.editprofile: (context) => EditProfile(),
        Routes.dashboard: (context) => Dashboard(),
        Routes.createnewpassword: (context) => CreateNewPassword(),
        Routes.painintensity: (context) => PainIntensityInsertion(),
        Routes.medication: (context) => MedicationInsertion(),
      },
    );
  }
}
