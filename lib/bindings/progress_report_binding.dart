import 'package:educube1/controller/progress/progress_report_controller.dart';
import 'package:get/get.dart';

class ProgressReportBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ProgressReportController());
    // TODO: implement dependencies
  }

}