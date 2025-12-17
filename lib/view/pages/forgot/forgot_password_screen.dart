import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../controller/forgot_password/fogot_password_controller.dart';
import '../../../route/app_routes.dart';
import '../../../utils/validations.dart';
import '../../../view/widgets/common_input_field.dart';
import '../../../view/widgets/common_button.dart';

class ForgotPassWordScreen extends StatefulWidget {
  @override
  _ForgotPassWordScreenState createState() => _ForgotPassWordScreenState();
}

class _ForgotPassWordScreenState extends State<ForgotPassWordScreen> {
  final forgotPasswordController = Get.find<ForgotPasswordController>();

  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: const Color(0xFFE6F0FA),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Form(
              key: forgotPasswordController.formKey,
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset('assets/icons/cms_logo.png', height: 30),
                  ),
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.arrow_back, color: Colors.blue),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const SizedBox(height: 50),

                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Forgot Password',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF004A9F),
                          ),
                        ),
                        const SizedBox(height: 20),


                        const SizedBox(height: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Text(

                                'Enter the username associated with your account.',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              CommonInputField(
                                controller: forgotPasswordController.forgotPasswordController,
                                hint: 'Enter Username',
                                inputType: TextInputType.text,
                                validator: (value) {
                                  if (value == null) {
                                    return 'Enter Username';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 40),
                            ],
                          ),
                        CommonButton(
                          text: 'Reset Password',
                          isLoading: forgotPasswordController.isLoading,

                          onPressed: () {
                            forgotPasswordController.forgotPassword();

                          },
                        ),
                        ] ,


                    ),
                  ),

                  const SizedBox(height: 100),
                  Text(
                    'Product developed by Globals',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Made with ❤️ in India',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


}


/*
import 'package:educube1/controller/forgot_password/fogot_password_controller.dart';
import 'package:educube1/utils/extensions/extension.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../const/app_colors.dart';
import '../../../const/app_images.dart';

import '../../../utils/validations.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_input_field.dart';

class ForgotPassWordScreen extends StatelessWidget {
  ForgotPassWordScreen({super.key});

  final forgotPasswordController = Get.find<ForgotPasswordController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: forgotPasswordController.formKey,
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
              'forgot_password'.tr,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontSize: 24.fontMultiplier,
                  fontWeight: FontWeight.w500,
                  color: AppColors.btColor),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Enter Registered Username associated with\n your account'.tr,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontSize: 14.fontMultiplier, fontWeight: FontWeight.w400),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 18.0, top: 16, right: 18, bottom: 8),
            child: Text(
              'Username'.tr,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontSize: 14.fontMultiplier),
            ),
          ),
          CommonInputField(

              validator: Validations.checkUsernameId,
              controller: forgotPasswordController.forgotPasswordController,
              hint: 'Enter Your Username'),
          Obx(
            () => Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Visibility(
                  visible: forgotPasswordController.inValidCredentials.value,
                  child: Text(
                    forgotPasswordController.message.value,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontSize: 12.fontMultiplier, color: Colors.red),
                  )),
            ),
          ),
          CommonButton(
            isLoading:forgotPasswordController.isLoading ,
              text: 'Reset Password',
              onPressed: () {
                forgotPasswordController.forgotPassword();
              })
        ],
      ),
    ));
  }
}
*/
