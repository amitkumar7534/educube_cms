import 'package:educube1/controller/timetable/timetable_controller.dart';
import 'package:educube1/utils/extensions/extension.dart';
import 'package:educube1/view/widgets/common_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../const/app_colors.dart';
import '../../widgets/common_scaffold.dart';
import '../../widgets/common_tile.dart';

class TimeTableScreen extends StatefulWidget {
  const TimeTableScreen({super.key});

  @override
  State<TimeTableScreen> createState() => _TimeTableScreenState();
}

class _TimeTableScreenState extends State<TimeTableScreen> {
  final timeTableController = Get.find<TimeTableController>();

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    await Future.delayed(const Duration(milliseconds: 500));
    timeTableController.getData();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      showBack: true,
      onBack: () {
        Navigator.pop(context);
      },
      title: 'timetable',
      body: Obx(() {
        if (timeTableController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView(
          children: [
            CommonTile(),


            // Day Selector
            CommonCard(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              borderRadius: 8.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      timeTableController.previousDay();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.colorBlue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.keyboard_arrow_left_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
                  Obx(() => Text(
                    timeTableController.getCurrentDay(),
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(
                      fontSize: 18.fontMultiplier,
                      fontWeight: FontWeight.w600,
                      color: AppColors.colorBlue,
                    ),
                  )),
                  const SizedBox(width: 24),
                  InkWell(
                    onTap: () {
                      timeTableController.nextDay();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.colorBlue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.keyboard_arrow_right_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Timetable List
            Obx(() {
              if (timeTableController.filteredTimeTable.isEmpty) {
                return Container(
                  margin: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.event_busy,
                        size: 64,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No classes scheduled for ${timeTableController.getCurrentDay()}',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                          fontSize: 14.fontMultiplier,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: timeTableController.filteredTimeTable.length,
                itemBuilder: (context, index) {
                  final lecture = timeTableController.filteredTimeTable[index];
                  final isBreak = timeTableController.isBreak(lecture);

                  return CommonCard(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    borderRadius: 12.0,
                    color: isBreak
                        ? AppColors.colorPresent.withOpacity(0.9)
                        : Colors.white,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lecture.lectureName ?? 'Unknown',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                  fontSize: 16.fontMultiplier,
                                  fontWeight: FontWeight.w600,
                                  color: isBreak
                                      ? Colors.white
                                      : AppColors.colorBlue,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${lecture.startTime ?? ''} - ${lecture.endTime ?? ''}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                  fontSize: 14.fontMultiplier,
                                  color: isBreak
                                      ? Colors.white
                                      : AppColors.colorTextPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isBreak
                                ? Colors.white.withOpacity(0.3)
                                : AppColors.colorBlue,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            isBreak ? 'BREAK' : 'CLASS',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                              fontSize: 12.fontMultiplier,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),

            const SizedBox(height: 24),
          ],
        );
      }),
    );
  }
}