import 'package:educube1/controller/change_password/change_pasword_controller.dart';
import 'package:get/get.dart';

class ChangePasswordBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ChangePasswordController());
    // TODO: implement dependencies
  }

}