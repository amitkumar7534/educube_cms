import 'package:get/get.dart';

class LocalString extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'continue_login': 'Login to continue to use this app',
          'enter_name': 'Enter Your Username',
          'user_name': 'UserName',
          'password': 'Password',
          'invalid_credentials': 'Invalid Credentials',
          'forgot_password': 'Forgot Password',
          'login': 'Login',
          'enter_register_email':
              'Enter Registered Email-ID associated with your account',
          'email_id': 'Email-ID',
          'verification': 'Verification',
          'enter_verification_code':
              'Password Reset link has been sent to your registered email-id',
          'enter_email': 'Enter Your Email - Id',
          'send_otp': 'Send OTP',
          'profile': 'Profile',
          'message_enter_password': 'Please enter your new password',
          'message_enter_valid_password': 'Please enter a valid password',
          'message_password_helper':
              'Password must contain at least 8 characters, including uppercase letters, lowercase letters, symbols(#@\$%) and numbers',
          'message_password_must_be_same':
              'New password and re-entered password mismatch',
          'alert': 'Alert',
          'more': 'more',
          'dismiss': "Dismiss",
          'exit': "Exit",
          'message_exit_app': "Are you sure you want to exit the app?",
          'message_server_error':'Server Error',
          'message':'Message',
          'performance':'Performance',
          'view_port':'View Port',
          'progress_report':'Progress Report',
          'fees':'Fees',
          'pay_now':'Pay Now',
          'attendance':'Attendance',
          'today_attendance':"Today's Attendance",
          'route':'Route',

        }
      };
}
