

import 'package:educube1/utils/extensions/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../const/app_colors.dart';
import '../widgets/common_button.dart';




class CommonAlertDialog {
  CommonAlertDialog._();

  static showDialog({
    String? title,
    required String message,
    String? negativeText,
    required String positiveText,
    bool? isShowNegButton,
    VoidCallback? negativeBtCallback,
    bool? barrierDismissible,
    BuildContext? builder,
    required VoidCallback positiveBtCallback,
  }) {
    Get.dialog(


        Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: CommonDialogContent(
            title: title,
            message: message,

            negativeText: negativeText,
            positiveText: positiveText,
            isShowNegButton: isShowNegButton,
            positiveBtCallback: positiveBtCallback,
            negativeBtCallback: negativeBtCallback,

          ),
        ),

        barrierDismissible:barrierDismissible ??true);
  }
}

class CommonDialogContent extends StatelessWidget {
  CommonDialogContent({
    Key? key,
    this.title,
    required this.message,
    this.negativeText,
    required this.positiveText,
    this.isShowNegButton,
    required this.positiveBtCallback,
    this.negativeBtCallback,
    this.positiveTextColor,
    this.negativeTextColor,
  }) : super(key: key);

  String? title;
  String message;
  String? negativeText;
  String positiveText;
  Color? positiveTextColor;
  Color? negativeTextColor;
  bool? isShowNegButton;
  VoidCallback positiveBtCallback;
  VoidCallback? negativeBtCallback;

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0)
      ),
      padding: const EdgeInsets.only(left: 16,right: 16, top: 18,bottom: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            (title ?? "alert").tr,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: 24.fontMultiplier,
                color: AppColors.btColor),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              message.tr,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: 14.fontMultiplier,
                  color: AppColors.colorTextPrimary),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            // mainAxisSize: MainAxisSize.max,
            children: [
              Visibility(
                visible: negativeText!=null,
                child: Expanded(
                    child: CommonButton(
                      fontWeight: FontWeight.w500,
                      height: 40,
                      margin: EdgeInsets.zero,

                      fontSize: 12.fontMultiplier,
                      text: (negativeText ?? "").tr,
                      onPressed: negativeBtCallback ?? () {},

                      textColor: negativeTextColor??Colors.white,
                      elevation: 0,
                      borderRadius: 10,

                    )),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                  child: CommonButton(
                    fontWeight: FontWeight.w500,
                    height: 40,
                    margin: EdgeInsets.zero,
                    fontSize: 12.fontMultiplier,
                    text: positiveText.tr,
                    textColor: positiveTextColor??Colors.white,
                    onPressed: positiveBtCallback,
                    elevation: 0,
                    borderRadius: 10,

                  ))
            ],
          )
        ],
      ),
    );
  }
}
