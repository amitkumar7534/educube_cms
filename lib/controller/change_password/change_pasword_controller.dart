
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../network/post_requests.dart';
import '../../route/app_routes.dart';
import '../../utils/prefrence_manager.dart';


class ChangePasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  var userId = Rx<String?>(null);
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final reEnterPasswordController = TextEditingController();
  RxBool inValidCredentials = false.obs;
  RxBool isLoading = false.obs;
  var message = "".obs;

  @override
  void onInit() {
    super.onInit();
    userId.value = PreferenceManager.user?.uId;
  }

  void changePassword() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> requestBody = {
        "user_id": PreferenceManager.getPref("user_id"),
        "old_password": oldPasswordController.text.toString(),
        "new_password": newPasswordController.text.toString()
      };

      try {
        isLoading.value = true;
        var response = await PostRequests.resetPassword(requestBody);
        if (response != null) {
          if (response.changePasswordResponse?.status == true) {
         //   AppAlerts.success( message:response.changePasswordResponse!.message.toString());
            PreferenceManager.removeUserData();
            // ForgotPasswordDialog.showDialog(message:response.changePasswordResponse!.message.toString() );
            Get.offAllNamed(AppRoutes.routeLogin);
          } else {
            inValidCredentials.value = true;
            message.value = response.changePasswordResponse!.message.toString();
           // AppAlerts.error( message:response.changePasswordResponse!.message.toString());
          }
        } else {
          Get.snackbar('error'.tr, 'message_server_error'.tr);
        }
      } finally {
        isLoading.value = false;
      }
    }
  }
}
