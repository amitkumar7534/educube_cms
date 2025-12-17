import 'package:educube1/controller/event/holiday_event_controller.dart';
import 'package:educube1/controller/routes/routes_controller.dart';
import 'package:get/get.dart';

class EventBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => HolidayEventController());
    // TODO: implement dependencies
  }
}