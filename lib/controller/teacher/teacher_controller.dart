import 'package:educube1/model/class_teacher_response.dart';
import 'package:educube1/model/teacher_response.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../model/common_model.dart';
import '../../model/notification_res_model.dart';
import '../../network/post_requests.dart';
import '../../route/app_routes.dart';
import '../../utils/prefrence_manager.dart';

class TeacherController extends GetxController {
  var userId = Rx<String?>(null);
  var academicYear = Rx<String?>(null);
  // var userName = ''.obs;
  // var userLastName = ''.obs;
  // var userClass = ''.obs;
  // var userSection = ''.obs;
  String deviceId = '';
  RxInt statusIndex =  (-1).obs;
  var schoolId = Rx<String?>(null);

  var teacherDetails = <TeacherDetail>[].obs;
  var classTeacherDetails = <LstSwTeacherDetail>[].obs;
  RxBool isLoading = false.obs;
  RxBool isNotification = false.obs;

  @override
  void onInit() {
    // getArguments();
    onCreate();
    super.onInit();
  }

  onCreate(){
    getUserDetails();
    getTeachers();
    getClassTeachers();
  }
  setSelectedIndex(int index){
    statusIndex.value = index;
  }
  setIndex(int index){
    statusIndex.value != statusIndex.value;
  }


  getUserDetails() {
    // userLastName.value = PreferenceManager.user!.uName!;
    schoolId.value = PreferenceManager.user?.schoolId;
    userId.value = PreferenceManager.user?.uId;
    academicYear.value = PreferenceManager.user?.currentAcademicYear;
  }






  final isLoadingClassTeachers = false.obs;
  final isLoadingTeachers      = false.obs; // for subject/all teachers list

  Future<void> getTeachers() async {
    final requestBody = {
      "school_id": PreferenceManager.getPref("school_id"),
      "academic_year": academicYear.value,
      "institution_id": PreferenceManager.getPref("institution_id"),
      "class_id":  PreferenceManager.getPref("class_id"),
      "user_id":  PreferenceManager.getPref("user_id"),

    };
    try {
      isLoadingTeachers.value = true;
      final response = await PostRequests.getTeachers(requestBody);

      if (response != null) {
        print(">>>>>>>>qwdeqweq${response != null}");

        teacherDetails.assignAll(response.teacherDetailsResponse?.lstTeacherDetails ?? []);
      }
    } finally {
      isLoadingTeachers.value = false;
    }
  }

  Future<void> getClassTeachers() async {
    final requestBody = {
      "school_id": PreferenceManager.getPref("school_id"),
      "academic_year": academicYear.value,
      "institution_id": PreferenceManager.getPref("institution_id"),
      "class_id":  PreferenceManager.getPref("class_id"),
      "section_id": PreferenceManager.getPref("section_id"),
    };
    try {
      isLoadingClassTeachers.value = true;
      final response = await PostRequests.getClassTeacher(requestBody);
      if (response != null) {
        classTeacherDetails.assignAll(response.classTeacherResponse?.lstSwTeacherDetails ?? []);
      }
    } finally {
      isLoadingClassTeachers.value = false;
    }
  }

  showExitAlert() {
    Get.toNamed(AppRoutes.routeProfile);

  }
}
