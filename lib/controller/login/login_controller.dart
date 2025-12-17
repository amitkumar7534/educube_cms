import 'package:educube1/model/user_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import '../../model/login_content_res_model.dart';
import '../../network/get_requests.dart';
import '../../network/post_requests.dart';
import '../../route/app_routes.dart';

import '../../utils/app_alerts.dart';
import '../../utils/prefrence_manager.dart';

class LoginController extends GetxController {
  var loginContent = Rx<LoginContentDetail?>(null);

  RxBool inValidCredentials = false.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final mobileController = TextEditingController();
  var message = "".obs;
  final formKey = GlobalKey<FormState>();
  static const platform = MethodChannel("https://globalsinc.com/");
  RxBool isLoading = false.obs;
  RxBool isContent = false.obs;

  @override
  void onInit() {
    getLoginContent();
    // TODO: implement onInit
    super.onInit();
  }

  void login() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> requestBody = {
        'Username': emailController.text.toString().trim(),
        'Password': passwordController.text.toString().trim(),
        "DeviceId": "TESTDEMO"

      };

      try {
        isLoading.value = true;
        var response = await PostRequests.loginUser(requestBody);
        Logger().d(">>>>>>>>>${response?.loginResponse?.userDetails ?? ""}");
        Logger().d("token>>>>>${response?.loginResponse?.tokenDetails?.token ?? ""}");
        final token = response?.loginResponse?.tokenDetails?.token;
        if (response != null) {
          if (response.loginResponse?.status == true) {
            saveDataToPref(response.loginResponse?.userDetails,token!);
            PreferenceManager.save2Pref("school_id", response.loginResponse?.userDetails?.schoolId);
            PreferenceManager.save2Pref("user_id", response.loginResponse?.userDetails?.uId);
            PreferenceManager.save2Pref("role_id", response.loginResponse?.userDetails?.roleId);
            var uid = response.loginResponse?.userDetails?.uId;
            PostRequests.saveFcmToken(uid);
            Get.toNamed(AppRoutes.routeHome);
          } else {
            inValidCredentials.value = true;
            message.value = response.loginResponse!.message;
            Logger().d(">>>>>>>>>>>${response.loginResponse?.message}");
            AppAlerts.error( message: response.loginResponse!.message.toString());
          }
        } else {
          Get.snackbar('error'.tr, 'message_server_error'.tr);
        }
      } finally {
        isLoading.value = false;
      }
    }
  }



  void loginUsingSSO(Map<String, dynamic> requestBody) async {
    FocusManager.instance.primaryFocus?.unfocus();

      try {
        isLoading.value = true;
        var response = await PostRequests.loginUserUsingSSO(requestBody);
        Logger().d(">>>>>>>>>${response?.loginResponse?.userDetails ?? ""}");
        Logger().d("token>>>>>${response?.loginResponse?.tokenDetails?.token ?? ""}");
        final token = response?.loginResponse?.tokenDetails?.token;
        if (response != null) {
          if (response.loginResponse?.status == true) {
            saveDataToPref(response.loginResponse?.userDetails,token!);
            PreferenceManager.save2Pref("school_id", response.loginResponse?.userDetails?.schoolId);
            PreferenceManager.save2Pref("user_id", response.loginResponse?.userDetails?.uId);
            PreferenceManager.save2Pref("role_id", response.loginResponse?.userDetails?.roleId);
            var uid = response.loginResponse?.userDetails?.uId;
            PostRequests.saveFcmToken(uid);
            Get.toNamed(AppRoutes.routeHome);
          } else {
            signOutGoogle();

            inValidCredentials.value = true;
            message.value = response.loginResponse!.message;
            Logger().d(">>>>>>>>>>>${response.loginResponse?.message}");
            AppAlerts.error( message: response.loginResponse!.message.toString());
          }
        } else {
          signOutGoogle();
          Get.snackbar('error'.tr, 'message_server_error'.tr);
        }
      } finally {
        isLoading.value = false;
      }
  }




  void verifyOtp(String otp) async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> requestBody = {
        'User_id': PreferenceManager.getPref("user_id"),
        'OTPNumber': otp,
        "DeviceId": "WDQWDWQ"
      };

      try {
        isLoading.value = true;
        var response = await PostRequests.verifyOtp(requestBody);
        Logger().d(">>>>>>>>>${response?.loginResponse?.userDetails ?? ""}");
        Logger().d("token>>>>>${response?.loginResponse?.tokenDetails?.token ?? ""}");
        final token = response?.loginResponse?.tokenDetails?.token;
        if (response != null) {
          if (response.loginResponse?.status == true) {
            saveDataToPref(response.loginResponse?.userDetails,token!);
            PreferenceManager.save2Pref("school_id", response.loginResponse?.userDetails?.schoolId);
            PreferenceManager.save2Pref("user_id", response.loginResponse?.userDetails?.uId);
            PreferenceManager.save2Pref("role_id", response.loginResponse?.userDetails?.roleId);
            var uid = response.loginResponse?.userDetails?.uId;
            PostRequests.saveFcmToken(uid);
            Get.toNamed(AppRoutes.routeHome);
          } else {
            inValidCredentials.value = true;
            message.value = response.loginResponse!.message;
            Logger().d(">>>>>>>>>>>${response.loginResponse?.message}");
            AppAlerts.error( message: response.loginResponse!.message.toString());
          }
        } else {
          Get.snackbar('error'.tr, 'message_server_error'.tr);
        }
      } finally {
        isLoading.value = false;
      }
    }
  }


  Future<void> signOutGoogle() async {
    try {
      final googleSignIn = GoogleSignIn();
      await googleSignIn.signOut(); // Signs out the Google user

      // Optional: If you are using Firebase Authentication
      await FirebaseAuth.instance.signOut(); // Signs out the Firebase user

      // Navigate back to the login screen or perform other post-logout actions
      // For example: Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
    } catch (e) {
      print('Error signing out of Google: $e');
      // Handle the error appropriately, e.g., show a snackbar
    }
  }





  void loginUsingMobile() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> requestBody = {
        'MobileNumber': mobileController.text.toString().trim(),
      };

      try {
        isLoading.value = true;
        var response = await PostRequests.loginUsingMobile(requestBody);

        if (response != null) {
          if (response.mobileResponse?.status == true && response.mobileResponse?.message != "Mobile Number Not Found") {
            PreferenceManager.save2Pref("user_id", response.mobileResponse?.objMobileAuthResponse?.userId.toString());

            PreferenceManager.save2Pref("otp", response.mobileResponse?.objMobileAuthResponse?.otpNumber.toString());

            Get.toNamed(AppRoutes.routeVerify);
          } else {
            inValidCredentials.value = true;
            message.value = response.mobileResponse!.message!;
            Logger().d(">>>>>>>>>>>${response.mobileResponse?.message}");
            Get.snackbar('Alert'.tr, response.mobileResponse!.message!.tr);

            AppAlerts.error( message: response.mobileResponse!.message.toString());
          }
        } else {
          Get.snackbar('error'.tr, 'message_server_error'.tr);
        }
      } finally {
        isLoading.value = false;
      }
    }
  }


  void saveDataToPref(UserDetails? user , String token) {
    PreferenceManager.user = user;
    PreferenceManager.userPassword = passwordController.text.toString();
    PreferenceManager.userToken = token;
  }

  getLoginContent() async {
    try {
      isContent.value = true;
      var apiResponse = await GetRequests.loginContent();
      if (apiResponse?.loginContentResponse?.status == true) {
        loginContent.value =
            apiResponse?.loginContentResponse?.loginContentDetail;
      }
    } finally {
      isContent.value = false;
    }
  }
}
