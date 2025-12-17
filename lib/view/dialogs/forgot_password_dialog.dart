import 'package:educube1/utils/extensions/extension.dart';
import 'package:educube1/view/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../route/app_routes.dart';

class ForgotPasswordDialog {
  static showDialog({String? message}) {
    return Get.dialog(
        barrierDismissible: false,
        Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
          backgroundColor: Colors.transparent,
          child: ForgotContent(
            message: message,
          ),
        ));
  }
}

class ForgotContent extends StatelessWidget {
  ForgotContent({super.key, this.message});

  String? message;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.black.withOpacity(0.2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 18.0, top: 50, right: 18, bottom: 24),
            child: Text(
              message ?? 'enter_verification_code'.tr,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: 18.fontMultiplier,
                  color: Colors.white,
                  height: 1.6),
            ),
          ),
          CommonButton(
              margin: const EdgeInsets.only(
                  left: 32, right: 32, bottom: 50, top: 16),
              text: 'OK',
              onPressed: () {
                Get.offAllNamed(AppRoutes.routeLogin);
              })
        ],
      ),
    );
  }
}
