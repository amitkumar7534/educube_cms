import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:educube1/utils/app_alerts.dart';
import 'package:flutter/cupertino.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger/logger.dart';

import '../const/app_const.dart';
import '../network/ApiUrls.dart';

class Helpers {
  Helpers._();
  static String getCompleteUrl(String? url) {
    if (url == null) return "";

    if (url.startsWith('http')) {
      return url;
    } else {
      return ApiUrls.baseUrl+ url;
    }
  }
  static printLog({required String screenName, required String message}) {
    if (AppConsts.isDebug) debugPrint("$screenName ==== $message");
  }

  static bool isResponseSuccessful(int code) {
    return code >= 200 && code < 300;
  }

  static String getImgUrl(String? url) {
    debugPrint("url ======= = $url");

    if (url == null) return '';
    if (url.startsWith('http')) {
      return url;
    } else {
      return ApiUrls.baseUrl + url;
    }
  }




  static Future<bool> checkConnectivity() async {
    final value = await NetworkInfo(InternetConnectionChecker()).isConnected;
    if(!value){
      AppAlerts.error(message: 'Internet is not connected');
    }
    return value;
  }
}


abstract class INetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfo implements INetworkInfo {
  final InternetConnectionChecker connectionChecker;
  NetworkInfo(this.connectionChecker);
  @override
  Future<bool> get isConnected async => Platform.isAndroid || Platform.isIOS
      ? await connectionChecker.hasConnection
      : true;
}
