import 'package:educube1/utils/extensions/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../const/app_colors.dart';
import '../../const/app_images.dart';
import '../../controller/profile/profile_controller.dart';

class CommonDrawer extends StatelessWidget {
  CommonDrawer({super.key});

  final profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 280,
      backgroundColor: AppColors.kPrimaryColor, // outer grey
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
          child: Stack(
            children: [
              // Card panel with gradient & rounded corners
              Container(
                margin: const EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFFEFF6FF), // light ice blue
                      const Color(0xFFDCEBFA), // a bit deeper
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.06),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 18),
                    // Avatar
                    Obx(() {
                      final img = profileController.userProfile.value?.imagePath ?? '';
                      return CircleAvatar(
                        radius: 32,
                        backgroundColor: Colors.white,
                        child: ClipOval(
                          child: img.isNotEmpty
                              ? Image.network(img, width: 58, height: 58, fit: BoxFit.cover)
                              : Image.asset(AppImages.imgUserImage, width: 58, height: 58, fit: BoxFit.cover),
                        ),
                      );
                    }),
                    const SizedBox(height: 12),

                    // Menu (scroll if needed)
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.fromLTRB(14, 6, 14, 0),
                        children: [
                          _drawerItem(
                            icon: Icons.home_max_outlined,
                            label: 'Home',
                            onTap: () => profileController.setDrawerIndex(0),
                          ),
                          const _DottedDivider(),
                          _drawerItem(
                            icon: Icons.fact_check_outlined,
                            label: 'Attendance',
                            onTap: () => profileController.setDrawerIndex(1),
                          ),
                          const _DottedDivider(),
                          _drawerItem(
                            icon: Icons.mail_outline,
                            label: 'Message',
                            onTap: () => profileController.setDrawerIndex(2),
                          ),
                          const _DottedDivider(),
                          _drawerItem(
                            icon: Icons.bar_chart_outlined,
                            label: 'Performance',
                            onTap: () => profileController.setDrawerIndex(3),
                          ),
                          const _DottedDivider(),
                          _drawerItem(
                            icon: Icons.school_outlined,
                            label: 'My Teacher',
                            onTap: () => profileController.setDrawerIndex(4),
                          ),
                          const _DottedDivider(),
                          _drawerItem(
                            icon: Icons.receipt_long_outlined,
                            label: 'Fees',
                            onTap: () => profileController.setDrawerIndex(5),
                          ),
                          const _DottedDivider(),
                          _drawerItem(
                            icon: Icons.alt_route_outlined,
                            label: 'Route',
                            onTap: () => profileController.setDrawerIndex(6),
                          ),
                          const _DottedDivider(),
                          _drawerItem(
                            icon: Icons.event_available_outlined,
                            label: 'Events & Holiday',
                            onTap: () => profileController.setDrawerIndex(7),
                          ),
                          const _DottedDivider(),
                          _drawerItem(
                            icon: Icons.table_chart_outlined,
                            label: 'My Class Timetable',
                            onTap: () => profileController.setDrawerIndex(8),
                          ),
                          const _DottedDivider(),
                          _drawerItem(
                            icon: Icons.lock_outline,
                            label: 'Change Password',
                            onTap: () => profileController.setDrawerIndex(9),
                          ),
                          const SizedBox(height: 36),

                          // Logout button
                          SizedBox(
                            height: 46,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFF4D4D),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () => profileController.logoutUser(),
                              icon: const Icon(Icons.power_settings_new_rounded, size: 20, color: Colors.white),
                              label: Text(
                                'Logout',
                                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  fontSize: 12.fontMultiplier,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Footer
                          Center(
                            child: Text(
                              'Powered by educube',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontSize: 10.fontMultiplier,
                                color: AppColors.colorTextPrimary.withOpacity(.8),
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Small side knob (right-center)
             /* Positioned.fill(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: const Color(0xFFBFE0FF),
                      border: Border.all(color: Colors.white, width: 2),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawerItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(icon, color: AppColors.colorTextPrimary.withOpacity(.9), size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: Get.textTheme.headlineMedium?.copyWith(
                  fontSize: 12.fontMultiplier,
                  color: AppColors.colorTextPrimary.withOpacity(.95),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Thin dotted line like the mock
class _DottedDivider extends StatelessWidget {
  const _DottedDivider();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 12,
      child: CustomPaint(
        painter: _DashPainter(
          color: AppColors.colorTextPrimary.withOpacity(.25),
          dashWidth: 4,
          gap: 4,
          strokeWidth: 1,
        ),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _DashPainter extends CustomPainter {
  _DashPainter({
    required this.color,
    required this.dashWidth,
    required this.gap,
    required this.strokeWidth,
  });

  final Color color;
  final double dashWidth;
  final double gap;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth;

    double x = 0;
    final y = size.height / 2;
    while (x < size.width) {
      canvas.drawLine(Offset(x, y), Offset(x + dashWidth, y), paint);
      x += dashWidth + gap;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}



/*
import 'package:educube1/utils/extensions/extension.dart';
import 'package:educube1/view/widgets/common_drawer_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../const/app_colors.dart';
import '../../const/app_images.dart';
import '../../controller/profile/profile_controller.dart';
import '../../utils/prefrence_manager.dart';

class CommonDrawer extends StatelessWidget {
  CommonDrawer({super.key});

  final profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      width: 280,
      backgroundColor: Colors.white,
      child: Column(
        children: [
          // Header Section
          Container(
            height: 160,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[50],
              border: Border(
                bottom: BorderSide(color: Colors.grey[200]!, width: 1),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Profile Image
                Obx(() => Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[300],
                  ),
                  child: profileController.userProfile.value?.imagePath == null
                      ? CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    child: Icon(
                      Icons.person,
                      size: 30,
                      color: Colors.grey[600],
                    ),
                  )
                      : CircleAvatar(
                    backgroundImage: NetworkImage(
                      "${profileController.userProfile.value?.imagePath.toString()}",
                    ),
                  ),
                )),
                const SizedBox(height: 8),
                // User Name
                Obx(() => Visibility(
                  visible: false,
                  child: Text(
                    profileController.userProfile.value?.firstName == null
                        ? 'User Name'
                        : '${profileController.userProfile.value?.firstName} ${profileController.userProfile.value?.lastName}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                )),
              ],
            ),
          ),

          // Menu Items
          Expanded(
            child: Obx(() => ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: profileController.profileList.length,
              itemBuilder: (context, index) {
                Widget menuItem = 2 == profileController.profileList[index].id! ||
                    6 == profileController.profileList[index].id!
                    ? ModernDrawerTile(
                  onTap: profileController.setDrawerIndex,
                  selectedIndex: profileController.drawerIndex,
                  currentIndex: index,
                  profileList: profileController.profileList[index],
                )
                    : PreferenceManager.profile?.roleName?.toLowerCase() == 'student'
                    ? ModernDrawerTile(
                  onTap: profileController.setDrawerIndex,
                  selectedIndex: profileController.drawerIndex,
                  currentIndex: index,
                  profileList: profileController.profileList[index],
                )
                    : const SizedBox.shrink();

                // Add divider after each menu item except the last one
                return Column(
                  children: [
                    menuItem,
                    if (index < profileController.profileList.length - 1)
                      Divider(
                        height: 1,
                        thickness: 0.5,
                        color: Colors.grey[300],
                        indent: 16,
                        endIndent: 16,
                      ),
                  ],
                );
              },
            )),
          ),

          // Logout Button
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                // Add logout functionality here
                profileController.logoutUser();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD32F2F),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Logout',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          // Footer Content
          Obx(() => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              profileController.footerContent.value?.footerContent == null
                  ? ''
                  : '${profileController.footerContent.value?.footerContent}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          )),
        ],
      ),
    );
  }
}

// Custom Drawer Tile Widget
class ModernDrawerTile extends StatelessWidget {
  final Function(int) onTap;
  final RxInt selectedIndex;
  final int currentIndex;
  final dynamic profileList; // Replace with your actual ProfileList type

  const ModernDrawerTile({
    super.key,
    required this.onTap,
    required this.selectedIndex,
    required this.currentIndex,
    required this.profileList,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: selectedIndex.value == currentIndex
            ? Colors.blue[50]
            : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        border: selectedIndex.value == currentIndex
            ? Border.all(color: Colors.blue[100]!, width: 1)
            : null,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        title: Text(
          profileList.title ?? '', // Adjust based on your ProfileList model
          style: TextStyle(
            fontSize: 14,
            fontWeight: selectedIndex.value == currentIndex
                ? FontWeight.w600
                : FontWeight.w400,
            color: selectedIndex.value == currentIndex
                ? Colors.blue[700]
                : Colors.grey[700],
          ),
        ),
        onTap: () => onTap(currentIndex),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    ));
  }
}*/
