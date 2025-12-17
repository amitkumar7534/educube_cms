import 'package:educube1/utils/extensions/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../const/app_colors.dart';

class PerformanceCart extends StatelessWidget {
  PerformanceCart(
      {super.key,
      required this.currentIndex,
      required this.selectedIndex,
      required this.onTap,
      this.message});

  RxInt selectedIndex;
  int currentIndex;
  Function(int index) onTap;
  String? message;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onTap(currentIndex);
        },
        child: Obx(
          () => Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color:
                   //   currentIndex == selectedIndex.value ?
                      Colors.grey.withOpacity(0.3),
                         // : Colors.transparent,
                      blurRadius: 2.0)
                ],
                border: Border.all(
                    color: currentIndex == selectedIndex.value
                        ? AppColors.colorLightBlue
                        : AppColors.colorTextPrimary.withOpacity(0.1)),
                color: currentIndex == selectedIndex.value
                    ? AppColors.colorLightBlue
                    : Colors.white,
                borderRadius: BorderRadius.circular(4.0)),
            child: Center(
              child: Text(
                message ?? '',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: 12.fontMultiplier,
                    color: currentIndex == selectedIndex.value
                        ? AppColors.colorBlue
                        : AppColors.colorTextPrimary),
              ),
            ),
          ),
        ));
  }
}
