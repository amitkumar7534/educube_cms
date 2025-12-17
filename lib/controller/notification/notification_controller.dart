import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../model/common_model.dart';
import '../../model/notification_res_model.dart';
import '../../network/post_requests.dart';
import '../../route/app_routes.dart';
import '../../utils/prefrence_manager.dart';

class NotificationController extends GetxController {
  var userId = Rx<String?>(null);
  var academicYear = Rx<String?>(null);
  // var userName = ''.obs;
  // var userLastName = ''.obs;
  // var userClass = ''.obs;
  // var userSection = ''.obs;
  String deviceId = '';
  RxInt statusIndex =  (-1).obs;
  var schoolId = Rx<String?>(null);

  var userNotification = <NotificationDetail>[].obs;
  RxBool isLoading = false.obs;
  RxBool isNotification = false.obs;

  @override
  void onInit() {
    // getArguments();
    super.onInit();
  }

  onCreate(){
    getUserDetails();
    getNotifications();
  }
setSelectedIndex(int index){
    statusIndex.value = index;
}
  setIndex(int index){
    statusIndex.value != statusIndex.value;
  }
  // getArguments() {
  //   Map<String, dynamic>? data = Get.arguments;
  //   if (data != null) {
  //     userName.value = data['user_name'];
  //     userClass.value = data['user_class'];
  //     userSection.value = data['user_section'];
  //     print(
  //         "${userName.value}>>${userClass.value}>>>>${userSection.value}>>>>UserData");
  //   }
  // }

  getUserDetails() {
    // userLastName.value = PreferenceManager.user!.uName!;
    schoolId.value = PreferenceManager.user?.schoolId;
    userId.value = PreferenceManager.user?.uId;
    academicYear.value = PreferenceManager.user?.currentAcademicYear;
  }

  getNotifications() async {
    Map<String, dynamic> requestBody = {
      "school_id": PreferenceManager.getPref("school_id"),
      "academic_year": academicYear.value,
      "user_id":  PreferenceManager.getPref("user_id"),
      "login_role_name": "Student"
    };

    try {
      isLoading.value = true;
      var response = await PostRequests.userNotification(requestBody);
      if (response != null) {
        // for (var i = 0;
        //     i < response.notificationResponse!.notificationDetails!.length;
        //     i++) {
        //   userNotification.add(CommonModel(
        //       title: response
        //           .notificationResponse!.notificationDetails![i].addedDate
        //           .toString(),
        //   subtitle:response
        //       .notificationResponse!.notificationDetails![i].messageSubject
        //       .toString(),
        //     message: response
        //         .notificationResponse!.notificationDetails![i].messageBody
        //         .toString(),
        //
        //
        //   ));
        //
        // }
        userNotification.assignAll(
            response.notificationResponse?.notificationDetails ?? []);
        isLoading.value = false;
      }
    }catch(e){
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }
  showExitAlert() {
    Get.toNamed(AppRoutes.routeProfile);

  }
}
