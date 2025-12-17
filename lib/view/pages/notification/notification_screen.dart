import 'package:educube1/utils/extensions/extension.dart';
import 'package:educube1/view/pages/notification/component/notification_cart.dart';
import 'package:educube1/view/widgets/common_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../const/app_colors.dart';
import '../../../controller/notification/notification_controller.dart';

import '../../widgets/common_scaffold.dart';
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final notificationController = Get.find<NotificationController>();

  @override
  void initState() {
    super.initState();

    notificationController.onCreate();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => notificationController.showExitAlert(),
      child: AnnotatedRegion(
        value: SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: AppColors.kPrimaryColor,
            systemNavigationBarColor: Colors.transparent),
        child: CommonScaffold(
          showBack: true, onBack: () { Navigator.pop(context); },

          title: 'message'.tr,
          body: ListView(
            children: [
              CommonTile(),
              Obx(
                    () => notificationController.userNotification.isEmpty
                    ? notificationController.isLoading.value ? const Center(
                    child: SizedBox(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator())) :  Center(
                  child: Padding(padding: EdgeInsets.symmetric(vertical: 50),
                    child: Text(
                      'No Record Found',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                          fontSize: 16.fontMultiplier),
                    ),
                  ),
                )


                    : ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    itemBuilder: (context, index) {
                      return NotificationCart(
                        currentIndex: index,
                        selectedIndex: notificationController.statusIndex,
                        onTap: notificationController.setSelectedIndex,
                        notificationDetail:
                        notificationController.userNotification[index],
                        notificationDate: index == 0 ||
                            notificationController
                                .userNotification[index]
                                .addedDate !=
                                notificationController
                                    .userNotification[index - 1]
                                    .addedDate
                            ? Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding:
                          const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                              border: Border.symmetric(
                                  horizontal: BorderSide(
                                      color: AppColors
                                          .colorTextPrimary
                                          .withOpacity(0.2)))),
                          child: Center(
                              child: Text(
                                DateFormat("MMM dd, yyyy").format(
                                    DateFormat('dd/MM/yyyy').parse(
                                      notificationController
                                          .userNotification[index].addedDate
                                          .toString(),
                                    )),
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                    fontSize: 16.fontMultiplier),
                              )),
                        )
                            : const SizedBox.shrink(),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 16);
                    },
                    itemCount:
                    notificationController.userNotification.length),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
