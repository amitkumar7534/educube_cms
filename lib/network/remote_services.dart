import 'dart:convert';


import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../model/common_res_model.dart';
import '../utils/helpers.dart';
import '../utils/prefrence_manager.dart';
import 'ApiUrls.dart';

class RemoteService {
  static var client = http.Client();

  static const String _baseUrl = ApiUrls.baseUrl;

  static Map<String, String> getHeaders() {
    String? bearerToken = PreferenceManager.getPref(PreferenceManager.prefKeyUserToken)
            as String?;
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json;charset=utf-8"
    };
    if (bearerToken != null) {
      headers.addAll({"Authorization": "Bearer $bearerToken"});
    }
    if (kDebugMode) {
      Logger().d('token = $bearerToken');
    }
    return headers;
  }

  static Future<CommonResModel?> simplePost(
      Map<String, dynamic> requestBody,
      String endUrl, {
        bool showStatus = true,
        Map<String, String>? headers, // <--- Accept custom headers
      }) async {
    if (kDebugMode && showStatus) {
      Logger().d("it worked");
    }

    if (showStatus) {
      Helpers.printLog(
        screenName: 'Remote_Service_simple_post',
        message: "request_data = $requestBody",
      );
      Logger().d('request_url = ${_baseUrl + endUrl}');
    }

    var body = json.encode(requestBody);

    final response = await http.post(
      Uri.parse(_baseUrl + endUrl),
      headers: headers ?? await getHeaders(),
      body: body,
    );

    if (showStatus) {
      Helpers.printLog(
        screenName: 'Remote_Service_simple_post',
        message: "response = ${response.body}",
      );
    }

    var responseCode = response.statusCode;
    if (Helpers.isResponseSuccessful(responseCode)) {
      return CommonResModel(statusCode: responseCode, response: response.body);
    } else {
      return null;
    }
  }


  // static Future<CommonResModel?> simplePost(
  //     Map<String, dynamic> requestBody, String endUrl, {bool showStatus = true}) async {
  //
  //   // showStatus = true;
  //
  //   if (kDebugMode && showStatus) {
  //     Logger().d("it worked");
  //   }
  //   // var isConnected = await InternetConnection.isConnected();
  //   //
  //   // if (!isConnected) {
  //   //   return null;
  //   // }
  //   if(showStatus){
  //     Helpers.printLog(
  //         screenName: 'Remote_Service_simple_post',
  //         message: "request_data = $requestBody");
  //     Logger().d('request_url = ${_baseUrl + endUrl}');
  //   }
  //
  //
  //   var body = json.encode(requestBody);
  //   final response = await http.post(Uri.parse(_baseUrl + endUrl),
  //       headers: getHeaders(), body: body);
  //   if(showStatus){
  //     // Logger().d(response.statusCode);
  //     // Logger().d(response.body);
  //   }
  //
  //   if(showStatus){
  //     Helpers.printLog(
  //         screenName: 'Remote_Service_simple_post',
  //         message: "response = ${response.body}");
  //   }
  //
  //   debugPrint('request_url = ${_baseUrl + endUrl}');
  //   var responseCode = response.statusCode;
  //   if (Helpers.isResponseSuccessful(responseCode)) {
  //     return CommonResModel(statusCode: responseCode, response: response.body);
  //   } else {
  //     return null;
  //   }
  // }

  static Future<CommonResModel?> simpleGet(String endUrl) async {
    // var isConnected = await InternetConnection.isConnected();
    //
    // if (!isConnected) {
    //   return null;
    // }

    final response =
        await http.get(Uri.parse(_baseUrl + endUrl), headers: getHeaders());

    Helpers.printLog(
        screenName: 'Remote_Service_simple_get',
        message: "response = ${response.body}");
    debugPrint('request_url = ${_baseUrl + endUrl}');
    debugPrint('request_headers = ${getHeaders().toString()}');
    var responseCode = response.statusCode;
    if (Helpers.isResponseSuccessful(responseCode)) {
      return CommonResModel(statusCode: responseCode, response: response.body);
    } else {
      return null;
    }
  }
}
