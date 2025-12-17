import 'package:educube1/controller/login/login_controller.dart';
import 'package:get/get.dart';

class VerifyBinding extends Bindings {
  @override
  void dependencies() {Get.lazyPut(() => LoginController());
    // TODO: implement dependencies
  }

}