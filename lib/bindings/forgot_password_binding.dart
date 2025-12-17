import 'package:educube1/controller/forgot_password/fogot_password_controller.dart';
import 'package:get/get.dart';

class ForgotPasswordBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ForgotPasswordController());
    // TODO: implement dependencies
  }

}