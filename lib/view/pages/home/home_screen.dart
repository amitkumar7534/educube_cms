import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:educube1/const/app_colors.dart';
import 'package:educube1/controller/profile/profile_controller.dart';
import 'package:educube1/utils/prefrence_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:upgrader/upgrader.dart';

import '../../../route/app_routes.dart';
import '../../widgets/common_scaffold.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      child: WillPopScope(
        onWillPop: () => profileController.showExitAlert(),
        child: AnnotatedRegion(
          value: SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: AppColors.kPrimaryColor,
            systemNavigationBarColor: Colors.transparent,
          ),
          child: CommonScaffold(
            title: 'Home'.tr,
            isVisible: false,
            body: Obx(
                  () => profileController.userProfile.value == null
                  ? const Center(
                child: SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(strokeWidth: 2.0),
                ),
              )
                  : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Text("Academic Year:",
                              style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 18, color: AppColors.colorBlue)),
                        ),
                        Expanded(
                          flex: 5,
                          child: Obx(
                                () => DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    isExpanded: true,
                                    isDense: true,
                                    buttonStyleData: ButtonStyleData(
                                      padding: EdgeInsets.symmetric(horizontal: 8, ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.white,
                                      ),

                                    ),
                                    hint: Text(
                                      profileController.selectedYear.value.isEmpty
                                          ? '2025-2026'
                                          : profileController.selectedYear.value,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(fontSize: 16),
                                    ),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(fontSize: 16),
                                    items: profileController.academicYear
                                        .map(
                                          (item) => DropdownMenuItem(
                                        value: item.yearValue,
                                        child: Text(item.yearValue.toString(),
                                            style: const TextStyle(fontSize: 12)),
                                      ),
                                    )
                                        .toList(),
                                    value: profileController
                                        .selectedValue.value.isEmpty
                                        ? null
                                        : profileController.selectedValue.value,
                                    onChanged: (val) =>
                                        profileController.setSelectedValue(val!),
                                    dropdownStyleData: DropdownStyleData(
                                      decoration: BoxDecoration(
                                        color: Colors.white, // ← dropdown background color
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    iconStyleData: IconStyleData(
                                      icon: Icon(Icons.keyboard_arrow_down, color: AppColors.colorBlackText,)
                                    ),
                                  ),
                                ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 30),
                    ListView.separated(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      itemCount: profileController.siblingsData.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final student = profileController.siblingsData[index];
                        return InkWell(
                          onTap: () async {

                            PreferenceManager.save2Pref("school_id", student.schoolId);
                            PreferenceManager.save2Pref("user_id", student.userId);
                            PreferenceManager.save2Pref("user_name", student.userName);
                            PreferenceManager.save2Pref("username", student.fullName);
                            PreferenceManager.save2Pref("role_id", student.roleId);
                            PreferenceManager.save2Pref("institution_id", student.institutionId);
                            PreferenceManager.save2Pref("class_id", student.classId);
                            PreferenceManager.save2Pref("section_id", student.sectionId);


                            await Get.toNamed(AppRoutes.routeProfile);
                            // profileController.getProfile("2025");
                            print("Tapped on ${student.fullName}");

                          },
                          borderRadius: BorderRadius.circular(16), // ripple effect
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                // Profile image
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    student.studentImage ?? '', // Replace with actual image field
                                    height: 48,
                                    width: 48,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => Container(
                                      height: 48,
                                      width: 48,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Icon(Icons.person, color: Colors.grey[600]),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),

                                // Info
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        student.fullName.toString(),
                                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                                      ),
                                      const SizedBox(height: 3),
                                      Text('Class ${student.className}', style: const TextStyle(fontSize: 12)),
                                      Text(student.grNumber.toString(), style: const TextStyle(fontSize: 12)),
                                      const SizedBox(height: 3),
                                      Text(
                                        student.campusName.toString(),
                                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.colorBlue),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(height: 20),
                    )
                    // const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
