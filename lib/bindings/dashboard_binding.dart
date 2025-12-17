import 'package:educube1/controller/dashboard/dashboard_controller.dart';
import 'package:get/get.dart';

import '../controller/profile/profile_controller.dart';

class DashBoardBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => DashBoardController());
    Get.lazyPut(()=>ProfileController());
    // TODO: implement dependencies
  }

}