import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/web.dart';
import '../../model/timetable_res_model.dart';
import '../../network/post_requests.dart';
import '../../utils/prefrence_manager.dart';

class TimeTableController extends GetxController {
  RxString currentDate = ''.obs;
  var userId = Rx<String?>(null);
  var schoolId = Rx<String?>(null);
  var roleId = Rx<String?>(null);
  var currentYear = Rx<String?>(null);
  var studentName = Rx<String?>(null);
  var className = Rx<String?>(null);
  var section = Rx<String?>(null);

  RxBool isLoading = false.obs;

  var timeTableList = <TimeTableMaster>[].obs;
  var filteredTimeTable = <TimeTableMaster>[].obs;

  // Current selected day
  Rx<DateTime> selectedDate = Rx<DateTime>(DateTime.now());

  // Week days
  final List<String> weekDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  // Current day index
  var currentDayIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // Set current day
    final today = DateTime.now();
    currentDayIndex.value = (today.weekday - 1).clamp(0, 5); // Monday = 0, Saturday = 5
    selectedDate.value = today;
  }

  getData() async {
    getUserDetails();
    await getTimeTable();
  }

  void getUserDetails() {
    schoolId.value = PreferenceManager.user?.schoolId;
    roleId.value = PreferenceManager.user?.roleId;
    userId.value = PreferenceManager.user?.uId;
    currentYear.value = PreferenceManager.user?.currentAcademicYear;


  }

  Future<void> getTimeTable() async {
    Map<String, dynamic> requestBody = {
     /* "user_id": PreferenceManager.getPref("user_id"),
      "school_id": PreferenceManager.getPref("school_id"),
      "academic_year": currentYear.value,
      "standard_id": PreferenceManager.getPref("class_id"),
      "section_id": PreferenceManager.getPref("section_id"),*/
      "school_id": "88",
      "academic_year": "2025",
      "standard_id": "5834",
      "section_id": "12683",
      "user_id": "569192"
    };

    try {
      isLoading.value = true;
      var response = await PostRequests.getTimeTable(requestBody);

      Logger().d('TimeTable Request: $requestBody');
      Logger().d('TimeTable Response: ${response?.toJson()}');

      if (response != null) {
        final timetableList = response.timeTableResponse ?? [];

        // Filter only active and non-deleted lectures
        /*timeTableList.assignAll(
            timetableList.where((lecture) =>
            lecture.isactive == true &&
                lecture.isdeleted == false
            ).toList()
        );
*/
        // Sort by start time
        _sortTimeTableByTime();

        // Filter for current day
        filterTimeTableByDay(weekDays[currentDayIndex.value]);

      } else {
        Logger().d('TimeTable API failed or returned null');
      }
    } catch (e) {
      Logger().d('TimeTable Error: $e');
      isLoading.value = false;
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  void filterTimeTableByDay(String weekDay) {
    if (timeTableList.isEmpty) {
      filteredTimeTable.clear();
      return;
    }

    filteredTimeTable.assignAll(
        timeTableList.where((lecture) =>
        lecture.weekDay?.toLowerCase() == weekDay.toLowerCase()
        ).toList()
    );

    // Sort filtered list by time
    _sortFilteredTimeTableByTime();

    update();
  }

  void _sortTimeTableByTime() {
    timeTableList.sort((a, b) {
      return (a.startTime ?? '').compareTo(b.startTime ?? '');
    });
  }

  void _sortFilteredTimeTableByTime() {
    filteredTimeTable.sort((a, b) {
      return (a.startTime ?? '').compareTo(b.startTime ?? '');
    });
  }

  void previousDay() {
    if (currentDayIndex.value > 0) {
      currentDayIndex.value--;
      filterTimeTableByDay(weekDays[currentDayIndex.value]);
      update();
    }
  }

  void nextDay() {
    if (currentDayIndex.value < weekDays.length - 1) {
      currentDayIndex.value++;
      filterTimeTableByDay(weekDays[currentDayIndex.value]);
      update();
    }
  }

  String getCurrentDay() {
    return weekDays[currentDayIndex.value];
  }

  String getClassWithSection() {
    return 'Class ${className.value}-${section.value}';
  }

  bool isBreak(TimeTableMaster lecture) {
    return lecture.lectureName?.toLowerCase().contains('break') ?? false;
  }

  void updateCurrentDate() {
    var now = DateTime.now();
    var formatter = DateFormat('dd/MMMM/yyyy');
    currentDate.value = formatter.format(now);
  }

  // Get lectures count for current day
  int get currentDayLecturesCount => filteredTimeTable.length;

  // Check if there are lectures for current day
  bool get hasLectures => filteredTimeTable.isNotEmpty;

  // Get day name from index
  String getDayName(int index) {
    if (index >= 0 && index < weekDays.length) {
      return weekDays[index];
    }
    return 'Monday';
  }
}