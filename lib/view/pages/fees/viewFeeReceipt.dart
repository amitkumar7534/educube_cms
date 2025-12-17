import 'package:educube1/controller/fees/fees_controller.dart';
import 'package:educube1/utils/extensions/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';

import '../../../const/app_colors.dart';
import '../../widgets/backBtn.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_drawer.dart';
import '../../widgets/common_tile.dart';

class ViewFeeReceipt extends StatefulWidget {
  const ViewFeeReceipt({super.key});

  @override
  State<ViewFeeReceipt> createState() => _ViewFeeReceiptState();
}

class _ViewFeeReceiptState extends State<ViewFeeReceipt> {
  final feeCtrl = Get.find<FeesController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      drawer: CommonDrawer(),
      appBar: CommonAppBar(
        title: 'fees',
      ),
      body: SafeArea(
        top: false,left: false, right: false,
        child: Column(
          children: [
            BackBtn(),
            CommonTile(),
            const Divider(color: AppColors.colorA9, height: 30,),
            Text('Fee Receipt'),
            const Divider(color: AppColors.colorA9, height: 30,),
            Expanded(child:
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Obx(
                ()=> HtmlWidget(
                  feeCtrl.receiptData,
                    textStyle: TextStyle(
                      fontSize: 12.fontMultiplier,
                      color: Colors.black87,
                      inherit: false,
                    ),
                    renderMode: RenderMode.column,
                    onErrorBuilder: (context, element, error) => const SizedBox.shrink(),
                    ),
              ),
            )
            )
          ],
        ),
      ),
    );
  }
}
