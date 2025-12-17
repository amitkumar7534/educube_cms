import 'package:educube1/controller/login/login_controller.dart';
import 'package:educube1/controller/timetable/timetable_controller.dart';
import 'package:get/get.dart';

class TimetableBinding extends Bindings {
  @override
  void dependencies() {Get.lazyPut(() => TimeTableController());
    // TODO: implement dependencies
  }

}