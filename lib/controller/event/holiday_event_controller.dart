import 'dart:developer';

import 'package:educube1/model/session_details_res_model.dart';
import 'package:educube1/route/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../const/app_colors.dart';
import '../../model/holiday_event_model.dart';
import '../../network/post_requests.dart';
import '../../utils/prefrence_manager.dart';

enum EventType { NA, Holiday, Event }

class HolidayEventController extends GetxController {
  RxString currentDate = ''.obs;

  CalendarBuilders calendarBuilders = CalendarBuilders();
  var userId = Rx<String?>(null);
  var schoolId = Rx<String?>(null);
  var roleId = Rx<String?>(null);
  var currentYear = Rx<String?>(null);
  RxBool isLoading = false.obs;

  var holidays = <DateTime>[].obs;
  var events = <DateTime>[].obs;
  var allHolidayEvents = <HolidayEventDetail>[].obs;
  var currentData = "".obs;
  var holidayDetails = <HolidayEventDetail>[].obs;
  var eventDetails = <HolidayEventDetail>[].obs;

  var holidayValue = 0.0.obs;
  var eventValue = 0.0.obs;
  var emptyValue = '-'.obs;

  final Rx<EventType> currentEventType = Rx<EventType>(EventType.NA);
  Rx<DateTime> selectedDate = Rx<DateTime>(DateTime.now());
  CalendarFormat calendarFormat = CalendarFormat.month;
  Rx<DateTime> focusedDay = DateTime.now().obs;

  final Rx<int> _totalHolidaysCount = RxInt(0);
  final Rx<int> _totalEventsCount = RxInt(0);
  final Rx<int> _currentMonthHolidaysCount = RxInt(0);
  final Rx<int> _currentMonthEventsCount = RxInt(0);
  final Rx<double> _holidayPercent = RxDouble(0.0);

  int get totalHolidaysCount => _totalHolidaysCount.value;
  int get totalEventsCount => _totalEventsCount.value;
  int get currentMonthHolidaysCount => _currentMonthHolidaysCount.value;
  int get currentMonthEventsCount => _currentMonthEventsCount.value;
  double get holidayPercent => _holidayPercent.value;

  var _sessionId = '';

  DateTime? selectedDay;

  void selectDate(DateTime date) {
    selectedDate.value = date;
  }

  Future<void> _getHolidayEvents() async {
    final selectedMonth = focusedDay.value;
    final currentTime = DateTime.now();
    final monthYr = "${selectedMonth.month}-${selectedMonth.year}";

    Logger().d('Current month +$monthYr');

    Map<String, dynamic> requestBody = {
      "school_id": PreferenceManager.getPref("school_id"),
      "academic_year": currentYear.value,
      "date": monthYr,
    };

    try {
      isLoading.value = true;
      var response = await PostRequests.getEvents(requestBody);
      Logger().d(requestBody);
      Logger().d(response?.toJson());

      if (response != null) {
        final holidayEventList = response.holidayEventResponse!.lstHolidayEvent ?? [];

        // Check current day status if viewing current month
        if (selectedMonth.year == currentTime.year && selectedMonth.month == currentTime.month) {
          final todayEvents = holidayEventList.where((element) {
            final eventDate = element.startDateTime;
            return eventDate != null &&
                eventDate.year == currentTime.year &&
                eventDate.month == currentTime.month &&
                eventDate.day == currentTime.day;
          }).toList();

          if (todayEvents.isNotEmpty) {
            final todayEvent = todayEvents.first;
            if (todayEvent.isHoliday) {
              currentEventType.value = EventType.Holiday;
            } else if (todayEvent.isEvent) {
              currentEventType.value = EventType.Event;
            }
          } else {
            currentEventType.value = EventType.NA;
          }
        }

        holidays.clear();
        events.clear();
        holidayDetails.clear();
        eventDetails.clear();

        // Process holidays and events
        for (var i = 0; i < holidayEventList.length; i++) {
          final item = holidayEventList[i];
          currentData.value = item.startdate ?? '';

          if (item.isHoliday) {
            final holidayDate = item.startDateTime;
            if (holidayDate != null) {
              final hIndex = holidays.indexWhere((element) =>
              element.year == holidayDate.year &&
                  element.month == holidayDate.month &&
                  element.day == holidayDate.day
              );
              if (hIndex < 0) {
                holidays.add(holidayDate);
                holidayDetails.add(item);
              }
            }
          } else if (item.isEvent) {
            final eventDate = item.startDateTime;
            if (eventDate != null) {
              final eIndex = events.indexWhere((element) =>
              element.year == eventDate.year &&
                  element.month == eventDate.month &&
                  element.day == eventDate.day
              );
              if (eIndex < 0) {
                events.add(eventDate);
                eventDetails.add(item);
              }
            }
          }
        }

        allHolidayEvents.assignAll(holidayEventList);

        // Calculate percentages and statistics
        final totalItems = holidayEventList.length;
        if (totalItems > 0) {
          holidayValue.value = (holidayDetails.length / totalItems) * 100 / 100;
          eventValue.value = (eventDetails.length / totalItems) * 100 / 100;
        }

        final isCurrentMonth = selectedMonth.month == currentTime.month &&
            selectedMonth.year == currentTime.year;

        _totalHolidaysCount.value = holidayDetails.length;
        _totalEventsCount.value = eventDetails.length;

        // Calculate current month counts
        final currentMonthHolidays = holidayDetails.where((element) {
          final date = element.startDateTime;
          return date != null &&
              date.month == selectedMonth.month &&
              date.year == selectedMonth.year;
        }).toList();

        final currentMonthEvents = eventDetails.where((element) {
          final date = element.startDateTime;
          return date != null &&
              date.month == selectedMonth.month &&
              date.year == selectedMonth.year;
        }).toList();

        _currentMonthHolidaysCount.value = currentMonthHolidays.length;
        _currentMonthEventsCount.value = currentMonthEvents.length;

        Logger().d('_currentMonthHolidaysCount ::: $currentMonthHolidaysCount   ||    holidayEventList ::${holidayEventList.length}');
      }
    } finally {
      isLoading.value = false;
    }

    holidays.refresh();
    events.refresh();
    holidayDetails.refresh();
    eventDetails.refresh();

    update();
    return;
  }

  DateTime get _selectedDateTime => DateTime(focusedDay.value.year, focusedDay.value.month);

  bool get hasRecord =>
      holidays.indexWhere((element) =>
      element.month == _selectedDateTime.month &&
          element.year == _selectedDateTime.year) > -1 ||
          events.indexWhere((element) =>
          element.month == _selectedDateTime.month &&
              element.year == _selectedDateTime.year) > -1;

  DateTime strToDate(String dateString) {
    // Handle format "06-Apr-2025"
    try {
      final parts = dateString.split('-');
      if (parts.length == 3) {
        final day = int.parse(parts[0]);
        final year = int.parse(parts[2]);
        final monthStr = parts[1].toLowerCase();

        final monthMap = {
          'jan': 1, 'feb': 2, 'mar': 3, 'apr': 4,
          'may': 5, 'jun': 6, 'jul': 7, 'aug': 8,
          'sep': 9, 'oct': 10, 'nov': 11, 'dec': 12
        };

        final month = monthMap[monthStr] ?? 1;
        return DateTime(year, month, day);
      }

      // Fallback to original format "dd/MM/yyyy"
      List<String> dateParts = dateString.split('/');
      int day = int.parse(dateParts[0]);
      int month = int.parse(dateParts[1]);
      int year = int.parse(dateParts[2]);
      return DateTime(year, month, day);
    } catch (e) {
      Logger().e('Error parsing date: $dateString, Error: $e');
      return DateTime.now();
    }
  }

  List<DateTime> sundayList(DateTime date) {
    final end = DateTime(date.year, date.month + 1, 0);
    final start = DateTime(date.year, date.month, 1);
    final daysToGenerate = end.difference(start).inDays;
    final daysList = List.generate(daysToGenerate,
            (i) => DateTime(start.year, start.month, start.day + (i)));
    return daysList.where((day) => day.weekday == DateTime.sunday).toList();
  }

  getCurrentHolidayEvents() {
    setFocusedDay(DateTime.now());
    _loadHolidayEvents();
  }

  previousMonthHolidayEvents() async {
    setFocusedDay(
        DateTime(focusedDay.value.year, focusedDay.value.month - 1, 1));
    _loadHolidayEvents();
  }

  nextMonthHolidayEvents() {
    setFocusedDay(DateTime(focusedDay.value.year, focusedDay.value.month + 1, 1));
    _loadHolidayEvents();
  }

  _loadHolidayEvents() async {
    try {
      await getSessionDetails();
      await _getHolidayEvents();
    } catch (e) {
      Logger().e('Error loading holiday events: $e');
    }
  }

  int _getLastDateOfMnth(DateTime dateTime) =>
      DateTime(dateTime.year, dateTime.month + 1, 0).day;

  @override
  void onInit() {
    super.onInit();
  }

  getData() async {
    getUserDetails();
    try {
      await getSessionDetails();
      getCurrentHolidayEvents();
    } catch (e) {
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
        await getMonth(response.attendanceSessionResponse?.lstAttendanceSessionDetail
            ?.first.attendanceSessionId);
        print(
            '${response.attendanceSessionResponse?.lstAttendanceSessionDetail?.first.attendanceSessionId}>>>sessionId');
      }
      return;
    } catch (e) {
      print('${schoolId.value}${currentYear.value}${roleId.value}>>>sessionId');
      isLoading.value = false;
      rethrow;
    }
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
        _sessionId = sessionId ?? '';
        print(
            '$sessionId session id ${response.monthResponse?.lstMonthDetail?.first.monthId.toString()}>>>monthId');
      }
      return;
    } catch (e) {
      print('${schoolId.value}${currentYear.value}${roleId.value}>>>id');
      isLoading.value = false;
    }
  }

  // Helper methods for checking event types on specific dates
  bool isHoliday(DateTime day) {
    return holidays.any((holiday) =>
    holiday.year == day.year &&
        holiday.month == day.month &&
        holiday.day == day.day);
  }

  bool isEvent(DateTime day) {
    return events.any((event) =>
    event.year == day.year &&
        event.month == day.month &&
        event.day == day.day);
  }

  List<HolidayEventDetail> getEventsForDay(DateTime day) {
    return allHolidayEvents.where((event) {
      final eventDate = event.startDateTime;
      return eventDate != null &&
          eventDate.year == day.year &&
          eventDate.month == day.month &&
          eventDate.day == day.day;
    }).toList();
  }

  List<HolidayEventDetail> getCurrentMonthItems() {
    final currentMonth = focusedDay.value;
    return allHolidayEvents.where((event) {
      final eventDate = event.startDateTime;
      return eventDate != null &&
          eventDate.month == currentMonth.month &&
          eventDate.year == currentMonth.year;
    }).toList()..sort((a, b) {
      final aDate = a.startDateTime;
      final bDate = b.startDateTime;
      if (aDate == null && bDate == null) return 0;
      if (aDate == null) return 1;
      if (bDate == null) return -1;
      return aDate.compareTo(bDate);
    });
  }

  String getFormattedDate(DateTime date) {
    return DateFormat.yMMMM().format(date);
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

  void saveDataToPref(AttendanceSessionResponse? user) {
    PreferenceManager.attendance = user;
  }

  // Additional utility methods
  List<HolidayEventDetail> getUpcomingEvents() {
    final now = DateTime.now();
    return allHolidayEvents.where((event) {
      final eventDate = event.startDateTime;
      return eventDate != null && eventDate.isAfter(now);
    }).toList()..sort((a, b) {
      final aDate = a.startDateTime;
      final bDate = b.startDateTime;
      if (aDate == null && bDate == null) return 0;
      if (aDate == null) return 1;
      if (bDate == null) return -1;
      return aDate.compareTo(bDate);
    });
  }

  List<HolidayEventDetail> searchEvents(String query) {
    if (query.isEmpty) return allHolidayEvents.toList();

    return allHolidayEvents.where((event) =>
    event.reason?.toLowerCase().contains(query.toLowerCase()) == true).toList();
  }
}