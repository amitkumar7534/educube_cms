

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../config/size_config.dart';


class AppConsts {

  AppConsts._();


  static const String appName = 'Money Patrol';
  static const double tabFontFactor = 1.5;
  static const double mobileFontFactor = 1.0;



  static double commonFontSizeFactor = SizeConfig.isMobile ? mobileFontFactor : tabFontFactor;


  //false on release

  static const bool isLog = true;
  static const bool isDebug = true;





  static var systemOverlayStyle = SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark
  );


}