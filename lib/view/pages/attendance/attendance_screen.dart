import 'package:educube1/controller/attendance/attendance_controller.dart';
import 'package:educube1/utils/extensions/extension.dart';
import 'package:educube1/view/widgets/common_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../const/app_colors.dart';
import '../../widgets/common_scaffold.dart';
import '../../widgets/common_tile.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

List<Map<String,dynamic>> _list = [
  {
    'color': AppColors.colorPresent,
    'value': 'Present'
  },
  {
    'color': AppColors.colorAbsent,
    'value': 'Absent'
  },
  {
    'color': AppColors.colorRedHoliday,
    'value': 'Holiday'
  },
  {
    'color': AppColors.colorBlue,
    'value': 'Present Day'
  },
];

class _AttendanceScreenState extends State<AttendanceScreen> {
  final attendanceController = Get.find<AttendanceController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    await Future.delayed(const Duration(milliseconds: 500));
    attendanceController.getData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => attendanceController.showExitAlert(),
      child: CommonScaffold(
        showBack: true, onBack: () { Navigator.pop(context); },

        title: 'attendance',
        body: ListView(
          children: [
            CommonTile(),
            CommonCard(
              color: AppColors.colorBlue,
              borderRadius: 8.0,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'today_attendance'.tr,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontSize: 16.fontMultiplier,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,   // 👈 changed to white
                    ),
                  ),
                  CommonCard(
                    color: AppColors.kPrimaryColor,
                    margin: EdgeInsets.zero,
                    height: 32,
                    width: 120,
                    child: Center(
                        child: Obx(
                      () => Text(
                        attendanceController.isPresent.value.name,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                                fontSize: 14.fontMultiplier,
                                color: attendanceController.isPresent.value ==
                                        PresentStatus.Present
                                    ? AppColors.colorPresent
                                    : attendanceController.isPresent.value ==
                                            PresentStatus.Absent
                                        ? AppColors.colorAbsent
                                        : attendanceController
                                                    .isPresent.value ==
                                                PresentStatus.Holiday
                                            ? AppColors.colorRedHoliday
                                            : AppColors.colorBlue,
                                fontWeight: FontWeight.w400),
                      ),
                    )),
                  ),
                ],
              ),
            ),
            CommonCard(
              margin: const EdgeInsets.all(16),
              borderRadius: 8.0,
              child: GetBuilder<AttendanceController>(builder: (controller) {
                return TableCalendar(
                  weekendDays: const [DateTime.sunday],
                  availableGestures: AvailableGestures.none,
                  onFormatChanged: (format) {
                    attendanceController.setCalendarFormat(format);
                  },
                  onPageChanged: (focusedDay) {
                    attendanceController.setFocusedDay(focusedDay);
                  },
                  calendarFormat: attendanceController.calendarFormat,
                  focusedDay: attendanceController.focusedDay.value,
                  calendarBuilders: CalendarBuilders(
                    defaultBuilder: (context, day, focusedDay) {
                      for (DateTime present in attendanceController.present) {
                        if (day.year == present.year &&
                            day.month == present.month) {
                          if (day.day == present.day) {
                            return Center(
                              child: Text(
                                '${day.day}',
                                style: const TextStyle(color: AppColors.colorPresent),
                              ),
                            );
                          }
                        }
                      }

                      for (DateTime absent in attendanceController.absent) {
                        if (day.year == absent.year &&
                            day.month == absent.month) {
                          if (day.day == absent.day) {
                            return Center(
                              child: Text(
                                '${day.day}',
                                style: const TextStyle(color: AppColors.colorAbsent),
                              ),
                            );
                          }
                        }
                      }

                      for (DateTime absent
                          in attendanceController.holidaysDates) {
                        if (day.year == absent.year &&
                            day.month == absent.month) {
                          if (day.day == absent.day) {
                            return Center(
                              child: Text(
                                '${day.day}',
                                style:
                                    const TextStyle(color: AppColors.colorRedHoliday),
                              ),
                            );
                          }
                        }
                      }
                      return null;
                    },
                  ),
                  calendarStyle: CalendarStyle(
                    weekendTextStyle: TextStyle(
                        color: AppColors.colorRed,
                        fontSize: 14.fontMultiplier,
                        fontFamily: 'Poppins',fontWeight: FontWeight.w600),
                    defaultTextStyle: TextStyle(
                        color: AppColors.colorTextPrimary,
                        fontSize: 14.fontMultiplier,
                        fontFamily: 'Poppins',fontWeight: FontWeight.w600),
                    holidayTextStyle: TextStyle(
                        fontSize: 14.fontMultiplier, color: Colors.red,fontWeight: FontWeight.w600),
                    outsideDaysVisible: false,
                    todayTextStyle: TextStyle(
                      color: AppColors.colorBlue,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                    todayDecoration: BoxDecoration(
                        color: AppColors.kPrimaryColor, shape: BoxShape.circle),
                    markerSize: 30,
                    isTodayHighlighted: true,
                  ),
                  daysOfWeekVisible: true,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  daysOfWeekStyle: DaysOfWeekStyle(
                      weekendStyle: TextStyle(
                          // color: AppColors.colorRed,
                          color: AppColors.colorRedHoliday,
                          fontSize: 14.fontMultiplier,fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins'),
                      weekdayStyle: TextStyle(
                          color: AppColors.colorTextPrimary.withOpacity(0.5),
                          fontWeight: FontWeight.w400)),
                  sixWeekMonthsEnforced: false,
                  headerStyle: HeaderStyle(
                    headerPadding: const EdgeInsets.only(left: 10, top: 8),
                      titleTextStyle: TextStyle(
                          fontSize: 16.fontMultiplier,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                          color: AppColors.colorBlackText

                      ),
                      leftChevronPadding: const EdgeInsets.only(left: 0),
                      rightChevronPadding:
                          const EdgeInsets.only(right: 8, top: 8, bottom: 16),
                      leftChevronMargin: EdgeInsets.zero,
                      rightChevronMargin: EdgeInsets.zero,
                      formatButtonVisible: false,
                      rightChevronVisible: true,
                      rightChevronIcon: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              // attendanceController.previousPage();
                              attendanceController.previousMonthAttendance();
                            },
                            child: Icon(
                              // Icons.keyboard_arrow_up_rounded,
                              Icons.keyboard_arrow_left_rounded,
                              color: AppColors.colorBlackText,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 16),
                          InkWell(
                            onTap: () {
                              // attendanceController.nextPage();
                              attendanceController.nextMonthAttendance();

                              print(
                                  "${attendanceController.focusedDay}>>>>>>>>>>>>>>>>");

                              print(
                                  "${DateFormat("dd/MM/yyyy").format(attendanceController.focusedDay.value).contains(attendanceController.currentData.value)}value>>>");
                              print(
                                  "${DateFormat("yyyy").format(attendanceController.focusedDay.value)}>>>>>>dateFormat");
                            },
                            child: Icon(
                              // Icons.keyboard_arrow_down_rounded,
                              Icons.keyboard_arrow_right_rounded,
                              color: AppColors.colorBlackText,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                      // leftChevronIcon: const SizedBox(),
                      leftChevronVisible: false,
                      titleCentered: false
                  ),
                  headerVisible: true,
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                );
              }),
            ),


            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Wrap(
                  direction: Axis.horizontal,
                  spacing: 14,
                  children: _list.map((i) => Row(children: [
                    Container(
                      margin: const EdgeInsets.only(right: 7),
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: i['color'],
                        borderRadius: BorderRadius.circular(8)
                      ),
                    ),
                    Text(
                      i['value'],
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontSize: 12.fontMultiplier),
                    )
                  ],)

                  ).toList(),
                ),
              ],
            ),

            SizedBox(height: 30,),

            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                DateFormat.yMMMM().format(attendanceController.focusedDay.value),
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontSize: 18.fontMultiplier,fontWeight: FontWeight.w800),
              ),
            ),


            CommonCard(
                margin: const EdgeInsets.only(
                    top: 16, left: 16, right: 16, bottom: 24),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: GetBuilder<AttendanceController>(builder: (controller) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      Column(
                        children: [
                          Obx(
                            () => attendanceController.hasRecord
                                ? CircularPercentIndicator(
                                    radius: 48.0,
                                    lineWidth: 10.0,
                                    percent: attendanceController.presentPercent

                                    // double.parse('${attendanceController.presentCount}')
                                    // attendanceController.presentValue.value
                                    ,
                                    center: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Obx(() => Text(
                                              '${attendanceController.presentCount}/${attendanceController.workingDaysCount}'
                                              // attendanceController.present.isEmpty
                                              //     ? '-'
                                              //     : '${attendanceController.present.length.toString()}/${attendanceController.attendance.length}'

                                              ,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineMedium
                                                  ?.copyWith(
                                                      fontSize:
                                                          16.fontMultiplier,
                                                      fontWeight:
                                                          FontWeight.w800),
                                            )),
                                        Text(
                                          "Days\nPresent",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium
                                              ?.copyWith(
                                                  fontSize: 12.fontMultiplier),
                                        ),
                                      ],
                                    ),
                                    backgroundColor:
                                        AppColors.colorBlue.withOpacity(0.2),
                                    progressColor: AppColors.colorBlue,
                                  )
                                : Container(
                                    height: 90,
                                    width: 90,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            width: 8.0,
                                            color: AppColors.colorBlue
                                                .withOpacity(0.2))),
                                    child: GetBuilder<AttendanceController>(
                                        builder: (controller) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(height: 8.0),
                                          Text(
                                            "_",
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium
                                                ?.copyWith(
                                                    fontSize:
                                                        12.fontMultiplier),
                                          ),
                                          Text(
                                            "Days\nPresent",
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium
                                                ?.copyWith(
                                                    fontSize:
                                                        12.fontMultiplier),
                                          ),
                                        ],
                                      );
                                    }),
                                    // color: Colors.pink,
                                  ),
                          ),
                      ]),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(
                              () => attendanceController.hasRecord
                                  ? RichText(
                                      text: TextSpan(children: [
                                      TextSpan(
                                        text: 'Total Working Days',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium
                                            ?.copyWith(
                                                fontSize: 12.fontMultiplier,fontWeight: FontWeight.w600),
                                      ),
                                      TextSpan(
                                          text:
                                              '\n${attendanceController.workingDaysCount}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall
                                              ?.copyWith(
                                                  fontSize: 12.fontMultiplier)),
                                    ]))
                                  : RichText(
                                      text: TextSpan(children: [
                                      TextSpan(
                                        text: 'Total Working Days',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium
                                            ?.copyWith(
                                                fontSize: 12.fontMultiplier),
                                      ),
                                      TextSpan(
                                          text: '\n_',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall
                                              ?.copyWith(
                                                  fontSize: 12.fontMultiplier)),
                                    ])),
                            ),
                            const SizedBox(height: 8.0),
                            Obx(
                              () => attendanceController.hasRecord
                                  ? RichText(
                                      text: TextSpan(children: [
                                      TextSpan(
                                        text: 'Holidays',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium
                                            ?.copyWith(
                                                fontSize: 12.fontMultiplier,fontWeight: FontWeight.w600),
                                      ),
                                      TextSpan(
                                          text:
                                              '\n${attendanceController.holidaysCount}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall
                                              ?.copyWith(
                                                  fontSize: 12.fontMultiplier)),
                                    ]))
                                  : RichText(
                                      text: TextSpan(children: [
                                      TextSpan(
                                        text: 'Holidays',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium
                                            ?.copyWith(
                                                fontSize: 12.fontMultiplier),
                                      ),
                                      TextSpan(
                                          text: '\n_',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall
                                              ?.copyWith(
                                                  fontSize: 12.fontMultiplier)),
                                    ])),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                })),
          ],
        ),
      ),
    );
  }
}
