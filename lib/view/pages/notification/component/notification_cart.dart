import 'package:educube1/utils/extensions/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../const/app_colors.dart';
import '../../../../model/notification_res_model.dart';

class NotificationCart extends StatelessWidget {
  NotificationCart(
      {super.key,
      required this.currentIndex,
      required this.selectedIndex,
      required this.onTap,
      required this.notificationDetail,
      this.notificationDate});

  RxInt selectedIndex;
  int currentIndex=-1;
  NotificationDetail notificationDetail;
  Function(int index) onTap;

  Widget? notificationDate;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      notificationDate ?? const SizedBox.shrink(),
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: Colors.white,
            border:
                Border.all(color: AppColors.colorTextPrimary.withOpacity(0.2))),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notificationDetail.messageSubject.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontSize: 14.fontMultiplier),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        "${DateFormat("MMM dd, yyyy").format(DateFormat('dd/MM/yyyy').parse(notificationDetail.addedDate.toString()))} | "
                        "${notificationDetail.fromUserName}",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                                fontSize: 12.fontMultiplier,
                                color: AppColors.colorTextPrimary
                                    .withOpacity(0.4)),
                      )
                    ],
                  )),
                  Obx(() =>

                      Visibility(
                        visible: currentIndex != selectedIndex.value,
                        child: GestureDetector(
                          onTap: () {
                            onTap(currentIndex);
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                color: AppColors.colorBlue),
                            child: Text(
                              "View",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                      color: Colors.white,
                                      fontSize: 12.fontMultiplier),
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            ),
            Obx(() => currentIndex == selectedIndex.value
                ? notificationDetail.messageBody == null
                    ? const SizedBox.shrink()
                    : Html(
                        data: notificationDetail.messageBody.toString(),
                      )
                : const SizedBox.shrink()),
            Obx(() =>  Visibility(
              visible: currentIndex == selectedIndex.value,
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                          onTap: () {
                            onTap(-1);

                          },
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Icon(
                              Icons.keyboard_arrow_up,
                              size: 25,
                              color: Colors.black87,
                            ),
                          )),
                    ),
                )
             )
          ],
        ),
      ),
    ]);
  }
}
