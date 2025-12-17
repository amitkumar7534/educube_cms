import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../controller/login/login_controller.dart';
import '../../../route/app_routes.dart';
import '../../../utils/app_alerts.dart';
import '../../../utils/prefrence_manager.dart';
import '../../../utils/validations.dart';
import '../../../view/widgets/common_input_field.dart';
import '../../../view/widgets/common_button.dart';

class VerifyOtp extends StatefulWidget {
  @override
  _VerifyOtpState createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  final int otpLength = 6;

  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;
  final loginController = Get.find<LoginController>();


  final TextEditingController mobileController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controllers = List.generate(otpLength, (_) => TextEditingController());
    focusNodes = List.generate(otpLength, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.length == 1 && index < otpLength - 1) {
      FocusScope.of(context).requestFocus(focusNodes[index + 1]);
    }
    if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(focusNodes[index - 1]);
    }
  }

  String getOtp() {
    return controllers.map((c) => c.text).join();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: const Color(0xFFE6F0FA),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              children: [
                const SizedBox(height: 40),

                /// Top CMS logo
                Align(
                  alignment: Alignment.centerRight,
                  child: Image.asset('assets/icons/cms_logo.png', height: 30),
                ),
                const SizedBox(height: 30),

                /// Educube logo
                Image.asset('assets/icons/_logo.png', height: 50),
                const SizedBox(height: 50),

                /// OTP Box
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
                      const Text(
                        'Verify OTP',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF004A9F),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Enter the verification code sent to your registered number.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),

                      Text(
                        'OTP- ${PreferenceManager.getPref('otp')}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 25),

                      /// OTP Boxes
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(otpLength, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: SizedBox(
                          width: 40,
                          height: 50,
                          child: TextField(
                            controller: controllers[index],
                            focusNode: focusNodes[index],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,

                            maxLength: 1,
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color:Colors.black),
                            decoration: InputDecoration(
                              counterText: '',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            onChanged: (value) => _onChanged(value, index),
                          ),
                        ),
                      );
                    }),
                  ),

                      const SizedBox(height: 20),

                      /// Resend text
                      Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: () {
                            // Resend logic
                          },
                          child: const Text(
                            "Didn't receive a code? Send again.",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      /// Verify and Login Button
                      SizedBox(
                        width: double.infinity,
                        child: CommonButton(
                          isLoading: loginController.isLoading,

                          onPressed: () {
                            if(getOtp().length<6){
                              AppAlerts.error( message: "Please enter valid otp");

                            }else{
                            String otp = getOtp();
                            loginController.verifyOtp(otp);
                            }
                            }, text: 'Verify and Login',
                         /* style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF004A9F),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Verify and Login',
                            style: TextStyle(fontSize: 16),
                          ),*/
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 60),
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
    );
  }

  Widget _buildOtpBox(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Text(
          '', // Placeholder, integrate with OTP controller later
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }




}
