import 'package:flutter/material.dart';
import 'package:get/get.dart';




class AppAlerts {
  AppAlerts._();

  static success({required String message}) {
    Get.closeAllSnackbars();
    Get.snackbar(
      'success'.tr,
      message,
        colorText: Colors.white,
        backgroundColor: Colors.black.withOpacity(0.3)
    );
  }

  static error({required String message}) {
    try{
      Get.closeAllSnackbars();
    }catch(e){

    }
    //
    Get.snackbar(
      ''.tr,
      message,
        colorText: Colors.white,
        backgroundColor: Colors.black.withOpacity(0.3)
    );
  }

  static alert({required String message}) {
    Get.closeAllSnackbars();
    Get.snackbar(
      ''.tr,
      message,
        colorText: Colors.red,
      backgroundColor: Colors.black.withOpacity(0.3)
    );
  }

  static custom({required String title, required String message}) {
    Get.closeAllSnackbars();
    Get.snackbar(
      title.tr,
      message,
        colorText: Colors.white,
        backgroundColor: Colors.black.withOpacity(0.3)
    );
  }
}
