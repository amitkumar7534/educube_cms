import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';
import '../../firebase_options.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';


class FCMNotificationService{
  static String? fcmToken;

  static late FirebaseMessaging _messaging;
  static late BuildContext _context;
  static Future<void> init(context) async{
    await runZonedGuarded<Future<void>>(() async {
      WidgetsFlutterBinding.ensureInitialized();
      try{
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
      }catch(e){

      }
      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;
    }, (error, stack) =>
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true));
    return;
  }

  static listener() async{
    _messaging = FirebaseMessaging.instance;
    await _requestPermissions();
    await _generateDeviceToken();

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    _notificationListeners();
  }

  static _generateDeviceToken() async{
    try{
      _messaging.getToken().then((value) {
        fcmToken = value;
        print('token result ....... +$value');
      });
    }catch(e){
      print('token result ....... +exception:: $e');
    }

    // if(await _requestPermissions()){
    //   _messaging.getToken().then((value) {
    //     fcmToken = value;
    //     print('token result ....... +$value');
    //   });
    // }
  }

  static _notificationListeners(){
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async{

      Map<String,dynamic> notification = message.data;
      RemoteNotification? notification1 = message.notification;

      Logger().d(message.data);
      Logger().d(message.notification);

      if (message.notification != null) {


          _flutterLocalNotificationsPlugin.show(
              1,
              message.notification?.title,
              message.notification?.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  _channel.id,
                  _channel.name,
                  channelDescription: _channel.description,
                  // icon: android?.smallIcon,
                  icon:  '@mipmap/ic_launcher',
                  // other properties...
                ),
              ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) async{
      Logger().d('notification .....onMessageOpenedApp');

    });

  }

  static void backgroundMessageListener() async{
     FirebaseMessaging.onBackgroundMessage((message) async{
      await Firebase.initializeApp();
      Logger().d('notification .....onBackgroundMessage');

    });
  }


  static  Future<bool> _requestPermissions() async{
    try{
      NotificationSettings settings = await _messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        sound: true,
        provisional: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('User granted permission');
        return true;
      } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
        print('User granted provisional permission');
        return false;
      } else {
        print('User declined or has not accepted permission');
        return false;
      }
    }catch(e){
      return false;
    }

  }
}


final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true
);


_settings(){
  // const AndroidInitializationSettings initializationSettingsAndroid =
  // AndroidInitializationSettings('@mipmap/ic_launcher');
  //
  // // IOSInitializationSettings iosInitializationSettings =
  // // IOSInitializationSettings(
  // //   requestAlertPermission: true,
  // //   requestBadgePermission: true,
  // //   requestSoundPermission: true,
  // //   onDidReceiveLocalNotification: onDidReceiveLocalNotification,
  // // );
  //
  // var initializationSettingsIOS = DarwinInitializationSettings(
  //     requestAlertPermission: true,
  //     requestBadgePermission: true,
  //     requestSoundPermission: true,
  //     onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {});
  // final InitializationSettings initializationSettings = InitializationSettings(
  //   android: initializationSettingsAndroid,
  //   iOS: initializationSettingsIOS,
  // );
  // await _flutterLocalNotificationsPlugin.initialize(
  //   initializationSettings,
  //   onDidReceiveNotificationResponse:
  //       (NotificationResponse notificationResponse) {
  //     switch (notificationResponse.notificationResponseType) {
  //       case NotificationResponseType.selectedNotification:
  //         selectNotificationSubject.add(notificationResponse.payload);
  //         break;
  //       case NotificationResponseType.selectedNotificationAction:
  //         if (notificationResponse.actionId == navigationActionId) {
  //           selectNotificationSubject.add(notificationResponse.payload);
  //         }
  //         break;
  //     }
  //   },
  //   onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
  // );
}