import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../network/post_requests.dart';

import '../../view/dialogs/forgot_password_dialog.dart';

class ForgotPasswordController extends GetxController{
  final forgotPasswordController = TextEditingController();
  var message = "".obs;
  final formKey = GlobalKey<FormState>();
  RxBool inValidCredentials = false.obs;
  RxBool isLoading = false.obs;
  void forgotPassword() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> requestBody = {
        'Username': forgotPasswordController.text.toString().trim(),

      };

      try {
        isLoading.value = true;
        var response = await PostRequests.forgotPassword(requestBody);
        if (response != null) {
          if (response.forgotPasswordResponse?.status == true) {
            ForgotPasswordDialog.showDialog();
          } else {
            inValidCredentials.value = true;
            message.value = response.forgotPasswordResponse!.message;
            print(response.forgotPasswordResponse?.message);
            Get.snackbar('Alert'.tr, response.forgotPasswordResponse!.message.toString().tr);

            //AppAlerts.error(notification: response.notification);
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