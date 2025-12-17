import 'package:educube1/model/user_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../const/app_images.dart';
import '../../model/academic_year_response_model.dart';
import '../../model/common_model.dart';
import '../../model/footer_res_model.dart';
import '../../model/login_content_res_model.dart';
import '../../model/profile_res_model.dart';
import '../../model/sibling_res_model.dart';
import '../../network/get_requests.dart';
import '../../network/post_requests.dart';
import '../../route/app_routes.dart';

import '../../utils/prefrence_manager.dart';
import '../../view/dialogs/common_alert_dialog.dart';

class HomeController extends GetxController {
  static HomeController get find => Get.find<HomeController>();
  var isContent = false.obs;
  final box = GetStorage();
  var footerContent = Rx<HeaderFooterDetail?>(null);
  var userName = Rx<String?>(null);
  var userSection = Rx<String?>(null);
  var userClass = Rx<String?>(null);
  var baseUrl = Rx<String?>(null);
  var userImage = Rx<String?>(null);
  var userId = Rx<String?>(null);
  var schoolId = Rx<String?>(null);
  var roleId = Rx<String?>(null);
  double containerWidth = 100.0;
  RxBool toggleValue = false.obs;
  var academicYear = <LstObjAcademicYearDetail>[].obs;
  var siblingsData = <Lstsibling>[].obs;
  var selectedYear = ''.obs;
  RxBool on = false.obs;
  String deviceId = '';
  var userProfile = Rx<ProfileResponse?>(null);

  final RxString _userNameValue = RxString('');
  final RxString _userClassValue = RxString('');

  String get userNameValue => _userNameValue.value;

  String get userClassValue => _userClassValue.value;

  final RxString selectedValue = "".obs;

  void setSelectedValue(String value) {
    selectedValue.value = value;
    EasyLoading.show(dismissOnTap: true);
    // GetStorage().write('selectedValue', value);
    getProfile(value.split('-').first);
  }

  @override
  void onInit() {
    _initPackageInfo();
    getUserDetails();
    getProfile("2025");
    getSiblingDetail("2025");
    getAcademicYear();
    _loadToggleState();
    getFooterContent();
    // selectedValue.value = GetStorage().read('selectedValue') ?? '';
    // TODO: implement onInit
    super.onInit();
  }

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();

    _packageInfo = info;
    print("${_packageInfo.packageName}_packageInfo>>>>");
  }

  RxBool isLoading = false.obs;

  showExitAlert() {
    CommonAlertDialog.showDialog(
        message: 'message_exit_app'.tr,
        positiveText: 'dismiss'.tr,
        negativeText: 'exit'.tr,
        negativeBtCallback: () {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        },
        positiveBtCallback: () {
          Get.back();
        });
  }

  Future<void> _loadToggleState() async {
    await box.initStorage;
    bool savedState = box.read('toggleState');
    toggleValue.value = savedState ?? false;
  }

  Future<void> _saveToggleState(bool state) async {
    await box.write('toggleState', state);
    toggleValue.value = state;
  }

  void toggleState() {
    _saveToggleState(!toggleValue.value);
    notificationToggle(toggleValue.value);
  }

  // Future<void> getDeviceId() async {
  //   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  //   if (Platform.isAndroid) {
  //     AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  //
  //       deviceId = androidInfo.toString();
  //
  //
  //   } else if (Platform.isAndroid) {
  //     IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
  //
  //       deviceId = iosInfo.toString();
  //
  //   }
  // }

  notificationToggle(bool status) async {
    try {
      var deviceId = await PostRequests.getDeviceId();
      Map<String, dynamic> requestBody = {
        "user_id": userId.value,
        "device_id": deviceId,
        "status": status
      };
      var response = await PostRequests.notificationToggle(requestBody);
    } catch (e) {
      print('errorr .......+${e}');
    }
  }

  getAcademicYear() async {
    var apiResponse = await GetRequests.fetchAcademicYear(schoolId.value);
    if (apiResponse != null) {
      for (var i = 0;
      i <
          apiResponse
              .academicYearResponse!.lstObjAcademicYearDetails!.length;
      i++) {
        if (apiResponse.academicYearResponse!.lstObjAcademicYearDetails![i]
            .isSelected ==
            true) {
          selectedYear.value = apiResponse
              .academicYearResponse!.lstObjAcademicYearDetails![i].yearValue
              .toString();
        }
        // selectedValue.value = apiResponse
        //     .academicYearResponse!.lstObjAcademicYearDetails![i].yearValue!;
        academicYear.add(
            apiResponse.academicYearResponse!.lstObjAcademicYearDetails![i]);
      }
      print('${selectedYear.value}selectedYear.value');
      //academicYear.assignAll(apiResponse.academicYearResponse?.lstObjAcademicYearDetails ??[]);
    }
  }

  getUserDetails() {
    // selectedValue.value = PreferenceManager.prefKeyAcademicYear;
    userName.value = PreferenceManager.profile?.firstName;
    userImage.value = PreferenceManager.user?.logoPath;
    schoolId.value = PreferenceManager.user?.schoolId;
    roleId.value = PreferenceManager.user?.roleId;
    userId.value = PreferenceManager.user?.uId;
    userSection.value = PreferenceManager.profile?.section;
    userClass.value = PreferenceManager.profile?.standard;
    baseUrl.value = PreferenceManager.user?.baseUrl;
    print("${PreferenceManager.user?.uName} ${userName.value}user>>>>");
  }

  void logoutUser() {
    PreferenceManager.removeUserData();
    Get.offAllNamed(AppRoutes.routeLogin);
  }

  RxInt drawerIndex = (-1).obs;

  setDrawerIndex(int index) {
    drawerIndex.value = index;
    Get.back();
    index == 0
        ? Get.toNamed(AppRoutes.routeAttendance)
        : index == 1
        ? Get.toNamed(AppRoutes.routeNotification, arguments: {
      'user_name': PreferenceManager.profile?.firstName,
      'user_class': PreferenceManager.profile?.standard,
      'user_section': PreferenceManager.profile?.section
    })
        : index == 2
        ? Get.toNamed(AppRoutes.routePerformance)
        : index == 3
        ? Get.toNamed(AppRoutes.routeFees)
        : index == 4
        ? Get.toNamed(AppRoutes.routeRoutesScreen)
        : logoutUser();
  }

  RxList profileList = <CommonModel>[
    CommonModel(
        id: 1,
        title: 'Attendance',
        onTap: () {},
        icon: AppImages.imgAttendance,
        selectedIcon: AppImages.imgAttendanceFilled),
    CommonModel(
        id: 2,
        title: 'Message',
        icon: AppImages.imgMessage,
        selectedIcon: AppImages.imgMessageFilled),
    CommonModel(
        id: 3,
        title: 'Performance',
        onTap: () {},
        icon: AppImages.imgPerformance,
        selectedIcon: AppImages.imgPerformanceFilled),
    CommonModel(
        id: 4,
        title: 'Fees',
        onTap: () {},
        icon: AppImages.imgFees,
        selectedIcon: AppImages.imgFeesFilled),
    CommonModel(
        id: 5,
        title: 'Route',
        onTap: () {},
        icon: AppImages.imgRoute,
        selectedIcon: AppImages.imgRoute),
    CommonModel(
        id: 6,
        title: 'Logout',
        // onTap: () {
        //   PreferenceManager.removeUserData();
        //   Get.offAllNamed(AppRoutes.routeLogin);
        // },
        icon: AppImages.imgLogout,
        selectedIcon: AppImages.imgLogout),
  ].obs;

  //

  //

  void getProfile(String year) async {
    Map<String, dynamic> requestBody = {
      "school_id": schoolId.value,
      "academic_year": year,
      "user_id": userId.value,
      "role_id": roleId.value
    };

    Logger().d(requestBody);

    try {
      isLoading.value = true;
      var response = await PostRequests.userProfile(requestBody);

      Logger().d(response?.profileResponse?.toJson());
      if (response != null) {
        userProfile.value = response.profileResponse;
        PreferenceManager.profile = response.profileResponse;
        var userData = UserDetails.fromJson(PreferenceManager.user!.toJson());
        userData.currentAcademicYear = year;
        PreferenceManager.user = userData;
        Logger().d(response.profileResponse!.toJson());
        var _userProfile = userProfile.value;
        if (_userProfile != null) {
          _userClassValue.value =
          _userProfile.standard != null && _userProfile.section != null
              ? '${_userProfile.standard}' + '  ${_userProfile.section}'
              : '-';
          _userNameValue.value = _userProfile.firstName != null ||
              _userProfile.lastName != null
              ? '${_userProfile.firstName ?? ''} ${_userProfile.lastName ?? ''}'
              : '-';
        }

        EasyLoading.show(dismissOnTap: false);
        //getStandardId(year);
      }
    } finally {
      isLoading.value = false;
    }
  }



  void getSiblingDetail(String year) async {
    Map<String, dynamic> requestBody = {
      "academic_year": year,
      "user_id": userId.value,
    };

    Logger().d(requestBody);

    try {
      isLoading.value = true;
      var response = await PostRequests.getSessionDetails(requestBody);

      Logger().d(response?.attendanceSessionResponse?.toJson());
      if (response != null) {
        siblingsData.value = response.attendanceSessionResponse!.lstAttendanceSessionDetail!.cast<Lstsibling>();
        Logger().d(response.attendanceSessionResponse!.toJson());

        EasyLoading.show(dismissOnTap: false);
        //getStandardId(year);
      }
    } finally {
      isLoading.value = false;
    }
  }


  getFooterContent() async {
    Map<String, dynamic> requestBody = {"base_url": baseUrl.value};
    Logger().d(requestBody);
    try {
      isContent.value = true;
      var apiResponse = await PostRequests.footerContent(requestBody);
      if (apiResponse?.headerFooterResponse?.status == true) {
        footerContent.value =
            apiResponse?.headerFooterResponse?.headerFooterDetail;
      }
    } finally {
      isContent.value = false;
    }
  }
// void getStandardId(String year) async {
//   Map<String, dynamic> requestBody = {
//     "school_id": schoolId.value,
//     "academic_year": year,
//   };
//
//   try {
//     isLoading.value = true;
//     var response = await PostRequests.userStandard(requestBody);
//     if (response != null) {
//     AppAlerts.success(message: response.standardResponse!.message.toString());
//     getSessionId( response.standardResponse?.lstStandardDetail?.first.standardId.toString(),year);
//     }
//   } finally {
//     isLoading.value = false;
//   }
// }
// void getSessionId(String? stId,String year) async {
//   Map<String, dynamic> requestBody = {
//     "school_id": schoolId.value,
//     "academic_year": year,
//     "standard_id": stId,
//     "user_id":  userId.value
//   };
//
//   try {
//     isLoading.value = true;
//     var response = await PostRequests.userProfile(requestBody);
//     if (response != null) {
//       userProfile.value = response.profileResponse;
//       PreferenceManager.profile = response.profileResponse;
//       CommonDialog.showLoader(false);
//     }
//   } finally {
//     isLoading.value = false;
//   }
// }
}
