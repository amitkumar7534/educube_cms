import 'package:educube1/controller/make_payment/make_payment_controller.dart';
import 'package:get/get.dart';

class MakePaymentBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => MakePaymentController());
    // TODO: implement dependencies
  }

}