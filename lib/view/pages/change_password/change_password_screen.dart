import 'package:educube1/utils/extensions/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../const/app_colors.dart';
import '../../../const/app_images.dart';
import '../../../controller/change_password/change_pasword_controller.dart';
import '../../../utils/prefrence_manager.dart';
import '../../../utils/validations.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_input_field.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final changePasswordController = Get.find<ChangePasswordController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.kPrimaryColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: changePasswordController.formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Image.asset(AppImages.imgLogin, height: 180, width: 199),
                ),
                Center(
                  child: Text(
                    'Change Password'.tr,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontSize: 24.fontMultiplier,
                        fontWeight: FontWeight.w500,
                        color: AppColors.btColor),
                  ),
                ),
                const SizedBox(height: 8.0),
                Center(
                  child: Text(
                    'Enter the new Password you want to\nset for ${PreferenceManager.getPref("username")}'.tr,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontSize: 14.fontMultiplier,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, top: 16, right: 18, bottom: 0),
                  child: Text(
                    'Old Password'.tr,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontSize: 14.fontMultiplier),
                  ),
                ),
                CommonInputField(
                    inputFormatter: [
                      FilteringTextInputFormatter.deny(
                          RegExp(r'\s'))
                    ],
                    isObscure: true,
                    validator: Validations.checkOldPasswordValidations,
                    controller: changePasswordController.oldPasswordController,
                    hint: 'Enter your old password'),
                Obx(
                      () => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22.0, vertical: 4.0),
                    child: Visibility(
                        visible:
                        changePasswordController.inValidCredentials.value,
                        child: Text(
                          changePasswordController.message.value,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                              fontSize: 12.fontMultiplier, color: Colors.red,fontWeight: FontWeight.w300),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, top: 16, right: 18, bottom: 0),
                  child: Text(
                    'New Password'.tr,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontSize: 14.fontMultiplier),
                  ),
                ),
                CommonInputField(
                    inputFormatter: [
                      FilteringTextInputFormatter.deny(
                          RegExp(r'\s'))
                    ],
                    isObscure: true,
                    validator: Validations.checkResetPasswordValidations,
                    controller: changePasswordController.newPasswordController,
                    hint: 'Enter your new password'),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, top: 16, right: 18, bottom: 0),
                  child: Text(
                    'Re Enter New Password'.tr,
                    style: Theme.of(context)
                         .textTheme
                        .headlineMedium
                        ?.copyWith(fontSize: 14.fontMultiplier),
                  ),
                ),
                CommonInputField(
                    inputFormatter: [
                      FilteringTextInputFormatter.deny(
                          RegExp(r'\s'))
                    ],
                    isObscure: true,
                    validator: (value) {
                      return Validations.checkConfirmPasswordValidations(value,
                          changePasswordController.newPasswordController.text);
                    },
                    controller:
                        changePasswordController.reEnterPasswordController,
                    hint: 'Re enter your new password'),


                const SizedBox(height: 30),


                CommonButton(
                    isLoading: changePasswordController.isLoading,
                    text: 'Submit',
                    onPressed: () {
                      changePasswordController.changePassword();
                    })
              ],
            ),
          ),
        ));
  }
}
