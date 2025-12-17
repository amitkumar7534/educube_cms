import 'package:educube1/controller/home/home_controller.dart';
import 'package:educube1/controller/profile/profile_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
    // TODO: implement dependencies
  }

}