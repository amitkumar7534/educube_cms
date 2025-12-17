import 'package:educube1/controller/fees/fees_controller.dart';
import 'package:educube1/controller/teacher/teacher_controller.dart';
import 'package:get/get.dart';

class TeacherBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => TeacherController());
    // TODO: implement dependencies
  }

}