import 'dart:io';

import 'package:educube1/route/app_pages.dart';
import 'package:educube1/route/app_routes.dart';
import 'package:educube1/services/firebase/fcmNotification.dart';
import 'package:educube1/utils/prefrence_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:overlay_support/overlay_support.dart';
import 'config/app_theme.dart';
import 'config/size_config.dart';
import 'const/local_strings.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceManager.init();
  await GetStorage.init();
  HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  onCreate(BuildContext context) async{
    await FCMNotificationService.init(context);
    FCMNotificationService.backgroundMessageListener();
    FCMNotificationService.listener();
  }


  @override
  Widget build(BuildContext context) {
    onCreate(context);
    return OverlaySupport(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return OrientationBuilder(
            builder: (context, orientation) {
              SizeConfig.init(constraints, orientation);
              return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                themeMode: ThemeMode.light,
                title: 'EduCube',
                theme: appTheme(context),
                translations: LocalString(),
                locale: const Locale('en', 'US'),
                getPages: AppPages.pages,
                // initialRoute: PreferenceManager.user != null
                //     ? AppRoutes.routeProfile
                //
                //     : AppRoutes.routeSplash,
                initialRoute:AppRoutes.routeSplash,


              );
            },
          );
        },
      ),
    );

  }
}


