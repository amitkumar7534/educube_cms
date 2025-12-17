import 'package:educube1/utils/extensions/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';

import '../../const/app_colors.dart';
import '../../const/app_images.dart';
import '../../controller/profile/profile_controller.dart';
import '../../route/app_routes.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  CommonAppBar({
    Key? key,
    required this.title,
    this.centerTitle,
    this.systemUiOverlayStyle,
    this.backgroundColor,
    this.titleTextStyle,
    this.leading,
    this.actions,
    this.height,
    this.isDashboard = false,
    this.showBack = false,
    this.onBack,
  }) : super(key: key);

  final String title;
  final bool? centerTitle;

  final SystemUiOverlayStyle? systemUiOverlayStyle;
  final Color? backgroundColor;
  final TextStyle? titleTextStyle;
  final Widget? leading;
  final List<Widget>? actions;

  final profileController = Get.find<ProfileController>();
  final double? height;

  final bool isDashboard;
  final bool showBack;
  final VoidCallback? onBack;

  @override
  Size get preferredSize => Size.fromHeight(height ?? kToolbarHeight);

  Widget _buildLeading(BuildContext context) {
    if (leading != null) return leading!;

    if (showBack) {
      return IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, size: 20),
        color: AppColors.colorBlue,
        onPressed: onBack ?? () => Get.back<void>(),
      );
    }

    if (isDashboard) {
      return Builder(
        builder: (context) => IconButton(
          icon: Image.asset(AppImages.imgDrawer, height: 20, width: 20),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      );
    }

    return const SizedBox(width: 8);
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle = titleTextStyle ??
        Theme.of(context)
            .textTheme
            .headlineMedium
            ?.copyWith(fontSize: 24.fontMultiplier, color: AppColors.colorBlue);

    // Fallback if title is empty
    final displayText = (title.trim().isEmpty)
        ? "BWSSB Sameeksha App"
        : title.tr;

    return Container(
      color: backgroundColor ?? AppColors.kPrimaryColor,
      padding: const EdgeInsets.only(left: 4, right: 8, bottom: 6),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            _buildLeading(context),
            const SizedBox(width: 6),
            Expanded(
              child: Align(
                alignment: (centerTitle ?? false)
                    ? Alignment.center
                    : Alignment.centerLeft,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final textPainter = TextPainter(
                      text: TextSpan(text: displayText, style: titleStyle),
                      maxLines: 1,
                      textDirection: TextDirection.ltr,
                    )..layout(maxWidth: constraints.maxWidth);

                    final isOverflowing =
                        textPainter.didExceedMaxLines; // check if text fits

                    if (isOverflowing) {
                      return SizedBox(
                        height: 25,
                        child: Marquee(
                          text: displayText,
                          style: titleStyle,
                          blankSpace: 40,
                          velocity: 30,
                          pauseAfterRound: const Duration(seconds: 1),
                        ),
                      );
                    } else {
                      return Text(
                        displayText,
                        style: titleStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      );
                    }
                  },
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0, left: 8),
                  child: GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.routeNotification),
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: AppColors.colorD9,
                          child: Image.asset(AppImages.imgNotification, height: 20),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: showBack,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 8),
                    child: GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.routeProfile),
                      child: Container(
                        height: 30,
                        width: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          shape: BoxShape.circle,
                        ),
                        child: Obx(
                              () => ClipRRect(
                            borderRadius: BorderRadius.circular(100.0),
                            child: (profileController.userProfile.value?.imagePath ?? '')
                                .isNotEmpty
                                ? Image.network(
                                '${profileController.userProfile.value?.imagePath}')
                                : Image.asset(AppImages.imgUserImage),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                ...(actions ?? const []),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
