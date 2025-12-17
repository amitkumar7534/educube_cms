import 'package:educube1/controller/performance/performance_controller.dart';
import 'package:get/get.dart';

class PerformanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PerformanceController());
    // TODO: implement dependencies
  }

}