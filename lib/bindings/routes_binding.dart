import 'package:educube1/controller/routes/routes_controller.dart';
import 'package:get/get.dart';

class RoutesBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => RoutesController());
    // TODO: implement dependencies
  }
}