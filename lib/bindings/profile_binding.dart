import 'package:educube1/controller/profile/profile_controller.dart';
import 'package:get/get.dart';

class ProfileBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
    // TODO: implement dependencies
  }

}