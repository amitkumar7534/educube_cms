import 'dart:convert';

import 'package:educube1/const/app_images.dart';
import 'package:educube1/model/common_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get/get_rx/get_rx.dart';
import 'package:logger/logger.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../model/TermsModel.dart';
import '../../model/profile_res_model.dart';
import '../../model/user_details.dart';
import '../../network/post_requests.dart';
import '../../utils/prefrence_manager.dart';

class PerformanceController extends GetxController {
  RxInt selectedIndex = 0.obs;
  final RxList<TermsModel> _list = RxList();

  List<TermsModel> get list => _list;
  var userId = Rx<String?>(null);
  var userData = Rx<UserDetails?>(null);
  var profileData = Rx<ProfileResponse?>(null);
  var currentYear = Rx<String?>(null);
  var isLoading = false.obs;
  var data = "".obs;
  Rx<WebViewController?> webCtrl = Rx(null);

  setIndex(int index) {
    selectedIndex.value = index;
  }

  RxList unitList = <CommonModel>[
    CommonModel(
        title: 'Math', icon: AppImages.imgMath, subtitle: 'Good 95/100'),
    CommonModel(
        title: 'English', icon: AppImages.imgEng, subtitle: 'Average 75/100'),
    CommonModel(
        title: 'Science', icon: AppImages.imgScience, subtitle: 'Poor 52/100'),
    CommonModel(
        title: 'Hindi', icon: AppImages.imgHindi, subtitle: 'Good 82/100'),
    CommonModel(
        title: 'Sports', icon: AppImages.imgSports, subtitle: 'Good 92/100'),
    CommonModel(
        title: 'Music', icon: AppImages.imgMusic, subtitle: 'Good 80/100'),
  ].obs;

  // launchWeb({String? nullValue}) {
  //   // if (webCtrl.value == null) {
  //     webCtrl.value =
  //   // }
  //
  //   const dummyHtml = """
  //   <!DOCTYPE html>
  //    <html>
  //   <head>
  //     <meta name="viewport" content="width=device-width, initial-scale=1.0">
  //     <style>
  //       body {
  //         font-size: 20px; /* Change this to adjust the font size */
  //       }
  //     </style>
  //   </head>
  //   <body>
  //   <p> Loading ....</p>
  //   </body>
  //   </html>
  //   """;
  //
  //   final String htmlContent = nullValue == null ? data.value : dummyHtml;
  //   webCtrl.value?.reload();
  //   webCtrl.value?.loadRequest(Uri.dataFromString(
  //     htmlContent,
  //     mimeType: 'text/html',
  //     encoding: Encoding.getByName('utf-8'),
  //   ));
  //
  //   update();
  // }

  _getUserDetails() {
    userId.value = PreferenceManager.user?.uId;
    currentYear.value = PreferenceManager.user?.currentAcademicYear;
    userData.value = PreferenceManager.user;
    profileData.value = PreferenceManager.profile;

    Logger().d(PreferenceManager.user?.toJson());
    // Logger().d(PreferenceManager.profile?.toJson());
  }

  void getTerms() async {
    await Future.delayed(const Duration(milliseconds: 500));
    EasyLoading.show(dismissOnTap: true);
    _getUserDetails();
    try {
      final map = {"user_id": userId.value, "academic_year": currentYear.value};
      Logger().d(map);
      final response = await PostRequests.getPerformanceTerms(map);
      if (response != null) {
        _list.value = response;
        refresh();
      } else {}
    } catch (e) {

      Logger().d(e);
    }
    EasyLoading.show(dismissOnTap: false);
  }

  //   curl -X POST --header 'Content-Type: application/json' --header 'Accept: application/msword' -d '{ \
  //   "user_id": "191306", \
  //   "academic_year": "2023", \
  //   "term_id": "5368" \
  // }' 'https://cms.educube.net/Educube_Api/api/Performance/Get'

  getPerformance(String termId) async {
    data.value = '';
    webCtrl.value = null;
    // launchWeb(nullValue: '');
    Map<String, dynamic> requestBody = {
      // "user_id": "191306", "academic_year": "2023", "term_id": "5368"
      // "user_id": "191306", "academic_year": "2023", "term_id": "5368"
      "user_id": userId.value,
      "academic_year": currentYear.value,
      // "term_id": "5368",
      "term_id": termId,
    };
    Logger().d(requestBody);
    try {
      isLoading.value = true;

      final url = 'https://cms.educube.net/Educube_Api/api/Performance/Get';
      http.Response response =
          await http.post(Uri.parse(url), body: requestBody);
      print("scascascs" + response.body);
      data.value = response.body;
      Logger().d(data.value);
      webCtrl.value = null;
      // launchWeb();

      /* var response = await PostRequests.getPerformance(requestBody);
    if (response != null) {
      print("wqdwqdwd ${response}");
      data.value=response.toString();
    }*/
    } finally {
      isLoading.value = false;
    }
  }
}
