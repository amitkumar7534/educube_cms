import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../const/app_images.dart';
import '../../../route/app_routes.dart';
import '../../../utils/prefrence_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      PreferenceManager.user != null
          ?  Get.offAllNamed(AppRoutes.routeHome)
          :  Get.offAllNamed(AppRoutes.routeLogin);
      // Get.offAllNamed(AppRoutes.routeLogin);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF7FF), // Light background
      body:MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeBottom: true,
        removeLeft: true,
        removeRight: true,
        child: SizedBox.expand(
            child: Image.asset(
              'assets/icons/ic_splash.png',
              fit: BoxFit.fill,
            ),
        ),
/*
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),

            // CMS Logo
            Image.asset(
              'assets/icons/cms_logo_full.png',
              width: 100,
            ),

            const SizedBox(height: 40),

            // Main Children Image
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Image.asset(
                'assets/icons/cms_kids_group.png', // your full kids-in-boxes image
                fit: BoxFit.contain,
              ),
            ),

            const Spacer(),

            // Educube Logo
            Image.asset(
              'assets/icons/_logo.png',
              width: 130,
            ),

            const SizedBox(height: 10),

            // Footer Text
            const Text(
              "Product developed by Globals",
              style: TextStyle(fontSize: 13, color: Colors.black54),
            ),
            const Text(
              "Made with ❤️ in India",
              style: TextStyle(fontSize: 12, color: Colors.black45),
            ),

            const SizedBox(height: 20),
          ],
        ),
*/
      ),
    );
  }
}
