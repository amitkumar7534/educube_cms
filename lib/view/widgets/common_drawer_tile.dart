import 'package:educube1/model/common_model.dart';
import 'package:educube1/utils/extensions/extension.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../const/app_colors.dart';
import '../../utils/app_alerts.dart';

class CommonDrawerTile extends StatelessWidget {
  CommonDrawerTile(
      {super.key,
      required this.profileList,
      required this.onTap,
      required this.selectedIndex,
      required this.currentIndex,
        this.verticalPadding = 0
      });

  CommonModel profileList;
  int currentIndex;
  RxInt selectedIndex;
  Function(int index) onTap;
  double verticalPadding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // AppAlerts.error(message: 'Internet is not connected');
        // AppAlerts.alert(message: 'Internet is not connected');
        // Logger().d('clicked menu');
        onTap(currentIndex);
      },
      child: Obx(
        () => Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          margin: const EdgeInsets.only(left: 16),
          decoration: BoxDecoration(
              color: currentIndex == selectedIndex.value
                  ? Colors.white
                  : AppColors.kPrimaryColor,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8.0),
                  topLeft: Radius.circular(8.0))),
          height: 45,
          child: Row(
            children: [
              SizedBox(
                height: 25,
                width: 25,




              child: Image.asset(
                    currentIndex == selectedIndex.value
                        ? profileList.selectedIcon.toString()
                        : profileList.icon.toString(),
                    height: 16),
              ),
              const SizedBox(width: 16),
              Text(
                profileList.title.toString(),
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontSize: 14.fontMultiplier,
                    color: currentIndex == selectedIndex.value
                        ? AppColors.colorBlue
                        : AppColors.colorTextPrimary),
              )
            ],
          ),
        ),
      ),
    );
  }
}
