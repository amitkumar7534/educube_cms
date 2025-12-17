import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../const/app_formatters.dart';

class Validations {
  Validations._();



  static String? checkEmptyFiledValidations(String? value) {
    var enteredValue = value?.trim() ?? '';
    if (enteredValue.isEmpty) {
      return "message_filed_required".tr;
    } else {
      return null;
    }
  }


  static String? checkUsernameId(String? value) {
    var enteredValue = value?.trim() ?? '';
    if (enteredValue.isEmpty) {
      return " Please enter your username".tr;
    }

    else {
      return null;
    }
  }
  static String? checkUsernameValidations(String? value) {
    var enteredValue = value?.trim() ?? '';
    if (enteredValue.isEmpty) {
      return " Please enter your username".tr;
    }

    else {
      return null;
    }
  }




  static String? checkPasswordValidations(String? value) {
    var enteredValue = value?.trim() ?? '';
    if (enteredValue.isEmpty) {
      return "Please enter your password".tr;
    }  else {
      return null;
    }
  }
  static String? checkOldPasswordValidations(String? value) {
    var enteredValue = value?.trim() ?? '';
    if (enteredValue.isEmpty) {
      return "Please enter your old password".tr;
    } else {
      return null;
    }
  }

  static String? checkResetPasswordValidations(String? value) {
    var enteredValue = value?.trim() ?? '';
    if (enteredValue.isEmpty) {
      return "message_enter_password".tr;
    } else if (!AppFormatters.validPasswordExp.hasMatch(enteredValue)) {
      return 'message_password_helper'.tr;
    }
    else {
      return null;
    }
  }


  static String? checkConfirmPasswordValidations(String? value,
      String? password) {
    var enteredValue = value?.trim() ?? '';
    if (enteredValue.isEmpty) {
      return "Please enter your re-entered password".tr;
    }
    else if (enteredValue != password) {
      return 'message_password_must_be_same'.tr;
    }
    else {
      return null;
    }
  }
}
