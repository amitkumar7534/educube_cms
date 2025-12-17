import 'package:educube1/view/pages/profile/profile_screen.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../view/dialogs/common_alert_dialog.dart';
import '../../view/pages/home/home_screen.dart';

class DashBoardController extends GetxController{
  var dashboardSelectedTab = 1.obs;
  void changeBottomNavBarItem(int index) {

    dashboardSelectedTab.value = index;

  }
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
  var pages = [
    HomeScreen(),
    // HomeScreen(),
    HomeScreen()
  ];

}