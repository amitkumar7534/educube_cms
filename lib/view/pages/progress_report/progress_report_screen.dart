import 'package:educube1/const/app_colors.dart';
import 'package:educube1/view/widgets/common_app_bar.dart';
import 'package:educube1/view/widgets/common_drawer.dart';
import 'package:educube1/view/widgets/common_tile.dart';
import 'package:flutter/material.dart';

class ProgressReportScreen extends StatelessWidget {
  const ProgressReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CommonDrawer(),
      backgroundColor: AppColors.kPrimaryColor,
      appBar: CommonAppBar(
        title: 'progress_report',
      ),
      body: ListView(
        children: [
          CommonTile(visible: true),
        ],
      ),
    );
  }
}
