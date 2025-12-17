import 'dart:developer';

import 'package:educube1/model/session_details_res_model.dart';
import 'package:educube1/route/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:logger/web.dart';
// import 'package:show_loader_dialog/show_loader_dialog.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../const/app_colors.dart';
import '../../model/attendance_res_model.dart';
import '../../network/post_requests.dart';
import '../../utils/prefrence_manager.dart';

enum PresentStatus {NA,Present,Absent,Holiday}
class AttendanceController extends GetxController {
  RxString currentDate = ''.obs;

  CalendarBuilders calendarBuilders = CalendarBuilders();
  var userId = Rx<String?>(null);
  var schoolId = Rx<String?>(null);
  var roleId = Rx<String?>(null);
  var currentYear = Rx<String?>(null);
  RxBool isLoading = false.obs;
  var present = <DateTime>[].obs;
  var absent = <DateTime>[].obs;
  var holidaysDates = <DateTime>[].obs;
  var allHolidays = <DateTime>[].obs;
  var attendance = <AttendanceDetail>[].obs;
  var currentData = "".obs;
  var holidays = <HolidayDetail>[].obs;
  var presentValue = 0.0.obs;
  var emptyValue = '-'.obs;
  // var isPresent = "NA".obs;
  final Rx<PresentStatus> isPresent = Rx<PresentStatus>(PresentStatus.NA);
  Rx<DateTime> selectedDate = Rx<DateTime>(DateTime.now());
  CalendarFormat calendarFormat = CalendarFormat.month;
  Rx<DateTime> focusedDay = DateTime.now().obs;

  final Rx<int> _workingDaysCount = RxInt(0);
  final Rx<int> _holidaysDaysCount = RxInt(0);
  final Rx<int> _presentDaysCount = RxInt(0);
  final Rx<double> _presentPercent = RxDouble(0.0);
  int get workingDaysCount => _workingDaysCount.value;
  int get holidaysCount=> _holidaysDaysCount.value;
  int get presentCount=> _presentDaysCount.value;
  double get presentPercent=> _presentPercent.value;

  var _sessionId = '';

  // DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  void selectDate(DateTime date) {
    selectedDate.value = date;
  }



  Future<void> _getAttendance() async{

    final selectedMonth = focusedDay.value;
    final currentTime = DateTime.now();
    final monthYr = "${selectedMonth.month}-${selectedMonth.year}";

    //   Logger().d(response?.toJson());
    Logger().d('Current month +$monthYr');

    Map<String, dynamic> requestBody = {
      "user_id": PreferenceManager.getPref("user_id"),
      "academic_year": currentYear.value,
      "month_year": monthYr,
      // "session_id": PreferenceManager.attendanceKeyUser
      "session_id": _sessionId
    };
    try {
      isLoading.value = true;
      var response = await PostRequests.getAttendance(requestBody);
      Logger().d(requestBody);
      Logger().d(response?.toJson());
      if (response != null) {
        final attendanceList = response.attendanceResponse!.attendanceDetails ?? [];
        final holidaysList = response.attendanceResponse?.holidayDetails ?? [];

        if(selectedMonth.year == currentTime.year && selectedMonth.month == currentTime.month){
         final indx =  attendanceList.indexWhere((element) => element.date != null ? strToDate(element.date!).day == currentTime.day: false);
         if(indx > -1  ){
           final _isPresent = attendanceList[indx].isPresent ?? false;
           if(_isPresent){
             isPresent.value = PresentStatus.Present ;
           }else{
             isPresent.value = PresentStatus.Absent;
           }
         }else{
           if(holidaysList.indexWhere((element) => element.dateDay != null && element.dateDay ==currentTime.day) > -1){
             isPresent.value = PresentStatus.Holiday;
           }
         }
        }

        present.clear();
        absent.clear();
        holidaysDates.clear();


        for (var i = 0;
        i < response.attendanceResponse!.attendanceDetails!.length;
        i++) {
          currentData.value = response
              .attendanceResponse!.attendanceDetails!.first.date
              .toString();
          if (response.attendanceResponse!.attendanceDetails![i].isPresent ==
              true) {
            final presentDate = strToDate(response.attendanceResponse!.attendanceDetails![i].date!);
            final pIndex = present.indexWhere((element) => element == presentDate);
            if(pIndex < 0){
              present.add(presentDate);
            }

          } else if (response
              .attendanceResponse!.attendanceDetails![i].isPresent ==
              false) {
            final absentDate = strToDate(response.attendanceResponse!.attendanceDetails![i].date!);
            final pIndex = absent.indexWhere((element) => element == absentDate);
            if(pIndex < 0) {
              absent.add(absentDate);
            }
          }
          // else if (response.attendanceResponse!.attendanceDetails!.last.isPresent == true
          // ) {
          //   isPresent.value = response
          //       .attendanceResponse!.attendanceDetails!.last.date
          //       .toString();
          // }
        }

        for (var i = 0;
        i < response.attendanceResponse!.holidayDetails!.length;
        i++) {
          final hDate = DateTime(
            selectedMonth.year,
            selectedMonth.month,
              response.attendanceResponse!.holidayDetails![i].dateDay!
          );


          // strToDate(response.attendanceResponse!.attendanceDetails![i].date!);
          final pIndex = holidaysDates.indexWhere((element) => element == hDate);
          if(pIndex < 0) {holidaysDates.add(hDate);}

        }

        attendance.assignAll(response.attendanceResponse?.attendanceDetails ?? []);
        presentValue.value = ((double.parse(present.length.toString()) /
            double.parse(attendance.length.toString())) *
            100) /
            100;

        holidays.assignAll(holidaysList);

        final isCurrentMonth = selectedMonth.month == currentTime.month && selectedMonth.year == currentTime.year;


        _holidaysDaysCount.value = holidays.length;
        _workingDaysCount.value =

        _getLastDateOfMnth(selectedMonth) - holidaysCount;

        Logger().d('_workingDaysCount ::: $workingDaysCount   ||    attendanceList ::${attendanceList.length}');
        _presentDaysCount.value = attendanceList.where((element) => element.isPresent ?? false).toList().length;
        _presentPercent.value = workingDaysCount > 0 ? presentCount/workingDaysCount : 0.0;
         // update();
      }
    } finally {
      isLoading.value = false;
    }

    holidaysDates.refresh();
    present.refresh();
    absent.refresh();

    update();


    return;
  }

  DateTime get _selectedDateTime => DateTime(focusedDay.value.year,focusedDay.value.month);

  bool get hasRecord =>
      present.indexWhere((element) => element.month == _selectedDateTime.month && element.year == _selectedDateTime.year ) > -1 ||
          holidaysDates.indexWhere((element) => element.month == _selectedDateTime.month && element.year == _selectedDateTime.year) > -1 ||
          absent.indexWhere((element) => element.month == _selectedDateTime.month && element.year == _selectedDateTime.year) > -1 ;





  // {
  //   final selectedMonth = ;
  //   final pIndex = ;
  //   final aIndex = absent.indexWhere((element) => element == selectedMonth);
  //   final hIndex = holidaysDates.indexWhere((element) => element == selectedMonth);
  //   return pIndex > -1 || aIndex > -1 || hIndex > -1;
  // }

  DateTime strToDate(String dateString){
    List<String> dateParts = dateString.split('/');
    int day = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int year = int.parse(dateParts[2]);
     return DateTime(year, month, day);
  }

  List<DateTime> sundayList(DateTime date){
    final end = DateTime(date.year, date.month + 1, 0);
    final start = DateTime(date.year, date.month, 1);
    final daysToGenerate = end.difference(start).inDays;
    final daysList =  List.generate(daysToGenerate, (i) => DateTime(start.year, start.month, start.day + (i)));
    return daysList.where((day) => day.weekday == DateTime.sunday).toList();
  }

  getCurrentAttendance() {
    setFocusedDay(DateTime.now());
    _loadAttendance();
  }

  previousMonthAttendance() async{
    setFocusedDay(
        DateTime(focusedDay.value.year, focusedDay.value.month - 1, 1));
    _loadAttendance();
  }

  nextMonthAttendance() {
    setFocusedDay(DateTime(focusedDay.value.year, focusedDay.value.month + 1, 1));
    _loadAttendance();
  }

  _loadAttendance()  async{
    // CommonDialog.showLoader(true);
    try{
      await getSessionDetails();
      await _getAttendance();
    }catch(e){

    }
    // CommonDialog.showLoader(false);
  }



  int  _getLastDateOfMnth(DateTime dateTime) => DateTime(dateTime.year, dateTime.month + 1, 0).day;





  @override
  void onInit() {

    // previousPage();
    // nextPage();
    // getAttendanceDetails();
    // getUserDetails();
    // updateCurrentDate();
    // log("${currentDate.value}...currentDate");


    super.onInit();
  }

  getData() async{
    getUserDetails();
    try{
      await getSessionDetails();
      getCurrentAttendance();
    }catch(e){
      print('--------setFocusedDayerror... ${e}');
    }
  }




  void updateCurrentDate() {
    var now = DateTime.now();
    var formatter = DateFormat('dd/MMMM/yyyy');
    currentDate.value = formatter.format(now);
  }

  getUserDetails() {
    schoolId.value = PreferenceManager.user?.schoolId;
    roleId.value = PreferenceManager.user?.roleId;
    userId.value = PreferenceManager.user?.uId;
    currentYear.value = PreferenceManager.user?.currentAcademicYear;
  }

  Future<void> getSessionDetails() async {
    Map<String, dynamic> requestBody = {
      "school_id": schoolId.value,
      "academic_year": currentYear.value,
      "role_id": roleId.value
    };

    try {
      isLoading.value = true;
      var response = await PostRequests.getSessionDetails(requestBody);
      if (response != null) {


       // saveDataToPref(response.attendanceSessionResponse?.lstAttendanceSessionDetail.);
        await getMonth(response.attendanceSessionResponse?.lstAttendanceSessionDetail
            ?.first.attendanceSessionId);
        print(
            '${response.attendanceSessionResponse?.lstAttendanceSessionDetail?.first.attendanceSessionId}>>>sessionId');
      }
      return ;
    }catch(e){
      print('${schoolId.value}${currentYear.value}${roleId.value}>>>sessionId');
      isLoading.value = false;
      rethrow;
    }
    // finally {
    //   print('${schoolId.value}${currentYear.value}${roleId.value}>>>sessionId');
    //   isLoading.value = false;
    //   throw Exception('');
    // }
  }

  Future<void> getMonth(String? sessionId) async {
    Map<String, dynamic> requestBody = {
      "school_id": schoolId.value,
      "academic_year": currentYear.value,
      "role_id": roleId.value
    };

    try {
      isLoading.value = true;
      var response = await PostRequests.userMonth(requestBody);
      if (response != null) {

        // getAttendanceDetails(sessionId,
        //     response.monthResponse?.lstMonthDetail?.first.monthId.toString());

        _sessionId = sessionId ?? '';
        print(
            '$sessionId session id ${response.monthResponse?.lstMonthDetail?.first.monthId.toString()}>>>monthId');
      }
      return ;
    } catch(e){
      print('${schoolId.value}${currentYear.value}${roleId.value}>>>id');
      isLoading.value = false;
    }

    // finally {
    //   print('${schoolId.value}${currentYear.value}${roleId.value}>>>id');
    //   isLoading.value = false;
    // }
  }


  showExitAlert() {
    Get.toNamed(AppRoutes.routeProfile);
  }

  void setCalendarFormat(CalendarFormat format) {
    calendarFormat = format;
    update();
  }

  void setFocusedDay(DateTime day) {
    print('--------setFocusedDay ${day.month}');

    focusedDay.value = day;

    update();
  }

  void setSelectedDay(DateTime? day) {
    selectedDay = day;
    update();
  }

  // void nextPage() {
  //   setFocusedDay(DateTime(focusedDay.value.year, focusedDay.value.month + 1, 1));
  //   getSessionDetails();
  //   getAttendanceDetails(PreferenceManager.attendanceKeyUser, "${focusedDay.value.month}-${focusedDay.value.year}");
  // }
  //
  // void previousPage() {
  //   setFocusedDay(
  //       DateTime(focusedDay.value.year, focusedDay.value.month - 1, 1));
  //   getAttendanceDetails(PreferenceManager.attendanceKeyUser, "${focusedDay.value.month}-${focusedDay.value.year}");
  // }


  void saveDataToPref(AttendanceSessionResponse? user) {
    PreferenceManager.attendance = user;

  }
}
