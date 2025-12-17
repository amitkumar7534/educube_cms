import 'package:educube1/utils/extensions/extension.dart';
import 'package:educube1/view/widgets/common_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../const/app_colors.dart';
import '../../../controller/event/holiday_event_controller.dart';
import '../../widgets/common_scaffold.dart';
import '../../widgets/common_tile.dart';

class HolidayEventScreen extends StatefulWidget {
  const HolidayEventScreen({super.key});

  @override
  State<HolidayEventScreen> createState() => _HolidayEventScreenState();
}

List<Map<String,dynamic>> _list = [
  {
    'color': AppColors.colorRedHoliday,
    'value': 'Holiday'
  },
  {
    'color': AppColors.colorBlue,
    'value': 'Events'
  },
  {
    'color': AppColors.colorPresent,
    'value': 'Multi-day'
  },
  {
    'color': AppColors.colorAbsent,
    'value': 'Past Event'
  },
];

class _HolidayEventScreenState extends State<HolidayEventScreen> {
  final holidayEventController = Get.find<HolidayEventController>();

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    await Future.delayed(const Duration(milliseconds: 500));
    holidayEventController.getData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => holidayEventController.showExitAlert(),
      child: CommonScaffold(
        showBack: true,
        onBack: () { Navigator.pop(context); },
        title: 'Events & Holidays',
        body: ListView(
          children: [
            CommonTile(),
            CommonCard(
              margin: const EdgeInsets.all(16),
              borderRadius: 8.0,
              child: GetBuilder<HolidayEventController>(builder: (controller) {
                return TableCalendar(
                  weekendDays: const [DateTime.sunday],
                  availableGestures: AvailableGestures.none,
                  onFormatChanged: (format) {
                    holidayEventController.setCalendarFormat(format);
                  },
                  onPageChanged: (focusedDay) {
                    holidayEventController.setFocusedDay(focusedDay);
                  },
                  calendarFormat: holidayEventController.calendarFormat,
                  focusedDay: holidayEventController.focusedDay.value,
                  calendarBuilders: CalendarBuilders(
                    defaultBuilder: (context, day, focusedDay) {
                      // Check for holidays
                      if (holidayEventController.isHoliday(day)) {
                        return Center(
                          child: Text(
                            '${day.day}',
                            style: const TextStyle(color: AppColors.colorRedHoliday),
                          ),
                        );
                      }

                      // Check for events
                      if (holidayEventController.isEvent(day)) {
                        return Center(
                          child: Text(
                            '${day.day}',
                            style: const TextStyle(color: AppColors.colorBlue),
                          ),
                        );
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
                              holidayEventController.previousMonthHolidayEvents();
                            },
                            child: Icon(
                              Icons.keyboard_arrow_left_rounded,
                              color: AppColors.colorBlackText,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 16),
                          InkWell(
                            onTap: () {
                              holidayEventController.nextMonthHolidayEvents();

                              print(
                                  "${holidayEventController.focusedDay}>>>>>>>>>>>>>>>>");

                              print(
                                  "${DateFormat("dd/MM/yyyy").format(holidayEventController.focusedDay.value).contains(holidayEventController.currentData.value)}value>>>");
                              print(
                                  "${DateFormat("yyyy").format(holidayEventController.focusedDay.value)}>>>>>>dateFormat");
                            },
                            child: Icon(
                              Icons.keyboard_arrow_right_rounded,
                              color: AppColors.colorBlackText,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
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



            // Current Month Events List
            Obx(() {
              final currentItems = holidayEventController.getCurrentMonthItems();

              if (currentItems.isEmpty) {
                return CommonCard(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Text(
                      'No events or holidays this month',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14.fontMultiplier,
                        color: AppColors.colorTextPrimary.withOpacity(0.7),
                      ),
                    ),
                  ),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: currentItems.length,
                itemBuilder: (context, index) {
                  final item = currentItems[index];
                  return _buildEventHolidayCard(context, item);
                },
              );
            }),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildEventHolidayCard(BuildContext context, item) {
    return CommonCard(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Date indicator
          Container(
            width: 60,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: item.isHoliday ? AppColors.colorRedHoliday : AppColors.colorBlue,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              children: [
                Text(
                  item.startDateTime != null
                      ? DateFormat('dd').format(item.startDateTime!)
                      : '--',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  item.startDateTime != null
                      ? DateFormat('MMM').format(item.startDateTime!)
                      : '---',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          // Event details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.reason ?? 'Unknown Event',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 16.fontMultiplier,
                    fontWeight: FontWeight.w600,
                    color: AppColors.colorTextPrimary
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: item.isHoliday
                            ? AppColors.colorRedHoliday.withOpacity(0.1)
                            : AppColors.colorBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        item.type ?? 'Event',
                        style: TextStyle(
                          color: item.isHoliday ? AppColors.colorRedHoliday : AppColors.colorBlue,
                          fontSize: 12.fontMultiplier,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                if (item.startdate != item.enddate) ...[
                  const SizedBox(height: 4),
                  Text(
                    '${item.startdate} - ${item.enddate}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 12.fontMultiplier,
                      color: AppColors.colorTextPrimary.withOpacity(0.7),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}