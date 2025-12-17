import 'package:educube1/controller/fees/fees_controller.dart';
import 'package:get/get.dart';

class FeesBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => FeesController());
    // TODO: implement dependencies
  }

}