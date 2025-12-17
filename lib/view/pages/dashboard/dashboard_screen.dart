import 'package:educube1/const/app_images.dart';
import 'package:educube1/controller/dashboard/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../const/app_colors.dart';



class DashBoardScreen extends StatelessWidget {
   DashBoardScreen({super.key});
final dashboardController = Get.find<DashBoardController>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(

      onWillPop: () => dashboardController.showExitAlert(),
      child: Scaffold(
        bottomNavigationBar: Obx(
              () => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items:  [
              BottomNavigationBarItem(
                label: "",
                icon: Image.asset(AppImages.imgHome,height: 24),
                activeIcon:  Image.asset(AppImages.imgHome,height: 24),

              ),
              BottomNavigationBarItem(
                label: "",
                  icon: Image.asset(AppImages.imgProfile,height: 24,),
                  activeIcon: Image.asset(AppImages.imgProfile,height: 24,),
                 ),

            ],
            currentIndex: dashboardController.dashboardSelectedTab.value,
            onTap: dashboardController.changeBottomNavBarItem,
            unselectedItemColor: Colors.white,
            selectedItemColor: Colors.blue,
            elevation: 5,
            backgroundColor: AppColors.kPrimaryColor,
          ),
        ),
        body: Obx(() => dashboardController.pages
            .elementAt(dashboardController.dashboardSelectedTab.value)),

      ),
    );
  }
}
