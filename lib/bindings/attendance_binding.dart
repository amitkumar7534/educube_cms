import 'package:get/get.dart';


import '../controller/attendance/attendance_controller.dart';

class AttendanceBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => AttendanceController());
    // TODO: implement dependencies
  }

}