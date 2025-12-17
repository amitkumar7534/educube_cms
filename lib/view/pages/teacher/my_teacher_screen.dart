import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:educube1/view/widgets/common_scaffold.dart';
import 'package:educube1/view/widgets/common_tile.dart';

import '../../../controller/teacher/teacher_controller.dart';
import '../../../model/class_teacher_response.dart'; // LstSwTeacherDetail
import '../../../model/teacher_response.dart';       // TeacherDetail

class MyTeachersScreen extends StatefulWidget {
  const MyTeachersScreen({super.key});

  @override
  State<MyTeachersScreen> createState() => _MyTeachersScreenState();
}

class _MyTeachersScreenState extends State<MyTeachersScreen>
    with SingleTickerProviderStateMixin {
  final teacherController = Get.find<TeacherController>();
  late final TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);

    // If your controller doesn't auto-load, uncomment:
    // Future.microtask(() {
    //   teacherController.getClassTeachers();
    //   teacherController.getTeachers();
    // });
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: 'My Teachers',
      showBack: true,
      onBack: () {
        if (Get.key.currentState?.canPop() ?? false) Get.back();
      },
      body: DefaultTabController(
        length: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
             CommonTile(),

            // Tabs
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFFB0BEC5), width: 0.7),
                ),
              ),
              child: _Tabs(controller: _tab),
            ),

            // Tab content
            Expanded(
              child: TabBarView(
                controller: _tab,
                children: [
                  // -------- Class Teacher (LstSwTeacherDetail) --------

                  // -------- Subject Teachers (TeacherDetail) ----------
                  Obx(() {
                    final items = teacherController.teacherDetails.toList();
                    final loading =
                        (teacherController as dynamic)
                            .isLoadingTeachers
                            ?.value ??
                            teacherController.isLoading.value;

                    if (loading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (items.isEmpty) {
                      return const _EmptyState('No class teacher found');
                    }
                    return _TeacherDetailList(teachers: items);
                  }),


                  Obx(() {
                    final items =
                    teacherController.classTeacherDetails.toList();
                    final loading =
                        (teacherController as dynamic)
                            .isLoadingClassTeachers
                            ?.value ??
                            teacherController.isLoading.value;

                    if (loading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (items.isEmpty) {
                      return const _EmptyState('No subject teachers found');
                    }
                    return _ClassTeacherList(teachers: items);
                  }),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ===================== Segmented TabBar ===================== */

class _Tabs extends StatelessWidget {
  const _Tabs({required this.controller});
  final TabController controller;

  @override
  Widget build(BuildContext context) {
    const blue = Color(0xFF0D47A1);
    const lightGroup = Color(0xFFEAF2FF);
    return Container(
      decoration: BoxDecoration(
        color: lightGroup,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TabBar(
        controller: controller,
        dividerColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: const EdgeInsets.all(4),
        labelPadding: EdgeInsets.zero,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        labelColor: Colors.white,
        unselectedLabelColor: blue,
        labelStyle:
        const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
        unselectedLabelStyle:
        const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
        indicator:
        BoxDecoration(color: blue, borderRadius: BorderRadius.circular(8)),
        tabs: const [
          Tab(text: 'Class Teacher'),
          Tab(text: 'Subject Teachers'),
        ],
      ),
    );
  }
}

/* ===================== Lists & Cards ===================== */

class _ClassTeacherList extends StatelessWidget {
  const _ClassTeacherList({required this.teachers});
  final List<LstSwTeacherDetail> teachers;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      itemCount: teachers.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, i) => _ClassTeacherCard(teacher: teachers[i]),
    );
  }
}

class _ClassTeacherCard extends StatelessWidget {
  const _ClassTeacherCard({required this.teacher});
  final LstSwTeacherDetail teacher;

  @override
  Widget build(BuildContext context) {
    final subject = (teacher.subject)!.trim();
    final subtitle = subject.isNotEmpty
        ? subject
        : [teacher.employeeName, teacher.section]
        .where((e) => e!.trim().isNotEmpty)
        .join(' • ');

    return _CardShell(
      leading: const _Avatar(),
      title: teacher.employeeName.toString(),
      subtitle: subtitle,
    );
  }
}

class _TeacherDetailList extends StatelessWidget {
  const _TeacherDetailList({required this.teachers});
  final List<TeacherDetail> teachers;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      itemCount: teachers.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, i) => _TeacherDetailCard(teacher: teachers[i]),
    );
  }
}

class _TeacherDetailCard extends StatelessWidget {
  const _TeacherDetailCard({required this.teacher});
  final TeacherDetail teacher;

  @override
  Widget build(BuildContext context) {
    final cls = (teacher.className)!.trim();
    final sec = (teacher.section)!.trim();
    final subtitle = [
      if (cls.isNotEmpty) cls,
      if (sec.isNotEmpty) 'Sec $sec',
    ].join(' • ');

    return _CardShell(
      leading: const _Avatar(),
      title: teacher.classTeacherName.toString(),
      subtitle: subtitle.isNotEmpty ? subtitle : (teacher.employeeStatus)!.trim(),
    );
  }
}

/* ===================== Shared UI bits ===================== */

class _CardShell extends StatelessWidget {
  const _CardShell({
    required this.leading,
    required this.title,
    required this.subtitle,
  });

  final Widget leading;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Color(0x1A000000), blurRadius: 12, offset: Offset(0, 4)),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        leading: leading,
        title: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w800, color: Colors.black),
        ),
        subtitle: Visibility(
          visible: !subtitle.contains('Sec'),
          child: Text(
            subtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF37474F)),
          ),
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar();

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(10.0);
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: radius,
        border: Border.all(color: Colors.white, width: 3),
        color: const Color(0xFFE0E0E0),
      ),
      child: const Center(
        child: Icon(Icons.person, color: Color(0xFF9E9E9E), size: 26),
      ),
    );
  }
}

/* ===================== Helper Widget ===================== */

class _EmptyState extends StatelessWidget {
  const _EmptyState(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text,
          style: const TextStyle(
              color: Color(0xFF607D8B), fontWeight: FontWeight.w600)),
    );
  }
}
