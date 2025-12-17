import 'package:educube1/utils/prefrence_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../controller/login/login_controller.dart';
import '../../../route/app_routes.dart';
import '../../../utils/validations.dart';
import '../../../view/widgets/common_input_field.dart';
import '../../../view/widgets/common_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String selectedLoginType = 'Username';
  bool _isPasswordVisible = false;
  final loginController = Get.find<LoginController>();


  final TextEditingController mobileController = TextEditingController();

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
              key: loginController.formKey,
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset('assets/icons/cms_logo.png', height: 30),
                  ),
                  const SizedBox(height: 30),
                  Image.asset('assets/icons/_logo.png', height: 50),
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
                          'Login',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF004A9F),
                          ),
                        ),
                        const SizedBox(height: 20),

                        Wrap(
                          alignment: WrapAlignment.spaceEvenly,
                          children: ['Username', 'OTP', 'SSO'].map((type) {
                            return Container(
                              constraints: const BoxConstraints(minWidth: 60),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Radio<String>(
                                    value: type,
                                    groupValue: selectedLoginType,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedLoginType = value!;
                                      });
                                    },
                                    activeColor: Colors.black,
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  Text(
                                    type,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),

                        const SizedBox(height: 10),

                        if (selectedLoginType == 'Username') ...[
                          CommonInputField(
                            controller: loginController.emailController,
                            hint: 'Enter Username',
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Username is required';
                              }
                              return null;
                            },
                          ),
                          CommonInputField(
                            controller: loginController.passwordController,
                            hint: 'Enter Password',
                            isObscure: true,
                            /*suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                color: Colors.grey[600],
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),*/
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              }
                              return null;
                            },
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Get.toNamed(AppRoutes.routeForgotPassword);
                              },
                              child: const Text(
                                'Forgot Password',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ] else if (selectedLoginType == 'OTP') ...[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Text(

                                'Enter Your Registered Mobile Number',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              CommonInputField(
                                controller: loginController.mobileController,
                                hint: 'Enter mobile number',
                                inputType: TextInputType.number,
                                maxLength: 10,
                                validator: (value) {
                                  if (value == null || value.length != 10) {
                                    return 'Enter valid 10-digit mobile number';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 70),
                            ],
                          ),
                        ] else if (selectedLoginType == 'SSO') ...[
                          const SizedBox(height: 40),
                          ElevatedButton.icon(
                            onPressed: () async {
                              PreferenceManager.save2Pref("login_type","sso");

                              final userCred = await signInWithGoogle();
                              if (userCred != null) {
                                print("Signed in as: ${userCred.user?.displayName}");
                              }                            },
                            icon: const Icon(Icons.login_outlined, size: 20),
                            label: const Text(
                              'Login with Google',
                              style: TextStyle(fontSize: 16),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black87,
                              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide(color: Colors.grey[300]!),
                              ),
                              elevation: 2,
                            ),
                          ),
                          const SizedBox(height: 120),
                        ],

                        if (selectedLoginType != 'SSO')
                          CommonButton(
                            text: _getButtonText(),
                            isLoading: loginController.isLoading,
                            onPressed: () {
                              if (selectedLoginType == 'Username') {
                                PreferenceManager.save2Pref("login_type","username");
                                loginController.login();
                              } else if (selectedLoginType == 'OTP') {
                                PreferenceManager.save2Pref("login_type","mobile");

                                loginController.loginUsingMobile();
                              }
                            },
                          ),


/*
                        CommonButton(
                          text: _getButtonText(),
                          isLoading: loginController.isLoading,
                          onPressed: () {
                            if (selectedLoginType == 'Username') {
                                loginController.login();
                            } else if (selectedLoginType == 'OTP') {

                              loginController.loginUsingMobile();

                            } else {
                              
                              print("SSO button clicked");
                            }
                          },
                        ),
*/
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
      ),
    );
  }

  String _getButtonText() {
    switch (selectedLoginType) {
      case 'OTP':
        return 'Send OTP';
      case 'SSO':
        return 'Continue with SSO';
      default:
        return 'Login';
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      print("Google sign-in canceled by user.");
      return null;
    }
    // Print basic profile info
    print("Google User:");
    print("Name: ${googleUser.displayName}");


    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Print tokens
    print("Access Token: ${googleAuth.accessToken}");
    print("ID Token: ${googleAuth.idToken}");

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    // Print Firebase user info after sign-in
    print("Firebase User:");
    print("UID: ${userCredential.user?.uid}");
    print("Email: ${userCredential.user?.email}");
    print("Display Name: ${userCredential.user?.displayName}");


    Map<String, dynamic> requestBody = {
      'email': userCredential.user?.email.toString(),
      'name': userCredential.user?.displayName.toString(),
      'picture': userCredential.user?.photoURL.toString(),
      'googleRefreshToken': userCredential.credential?.accessToken.toString(),
      'googleTokenExpiry': "",
      'googleToken': userCredential.credential?.accessToken.toString(),
      'googleId': userCredential.user?.uid.toString(),
      'deviceId': "qwerty",
    };

    loginController.loginUsingSSO(requestBody);

    return userCredential;
  }

}
