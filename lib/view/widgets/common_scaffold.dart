import 'package:educube1/view/widgets/common_app_bar.dart';
import 'package:educube1/view/widgets/common_drawer.dart';
import 'package:flutter/material.dart';
import '../../const/app_colors.dart';

class CommonScaffold extends StatelessWidget {
  const CommonScaffold({
    super.key,
    this.body,
    this.title,
    this.isVisible = true,   // keeps old param: shows drawer when true
    this.showBack = false,   // NEW: show back button instead of drawer
    this.onBack,             // NEW: custom back handler
    this.showLogo = true,    // optional
  });

  final Widget? body;
  final String? title;
  final bool isVisible;  // acts as "showDrawer"
  final bool showBack;
  final VoidCallback? onBack;
  final bool showLogo;

  @override
  Widget build(BuildContext context) {
    final useDrawer = isVisible && !showBack;

    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      drawer: useDrawer ?  CommonDrawer() : null,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            if (showLogo)
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16) +
                      const EdgeInsets.symmetric(vertical: 10),
                  child: Image.asset(
                    'assets/icons/cms_logo.png',
                    width: 80,
                    height: 35,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            CommonAppBar(
              title: title ?? '',
              isDashboard: useDrawer, // shows drawer icon when true
              showBack: showBack,     // <-- requires your updated CommonAppBar
              onBack: onBack,
            ),
            Expanded(child: body ?? const SizedBox()),
          ],
        ),
      ),
    );
  }
}
