

import 'dart:async';

import 'package:educube1/controller/fees/fees_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebViewScreen extends StatefulWidget {
  WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {

  final feesController = Get.put(FeesController());


  @override
  void initState() {
    feesController.webUrlLink.value;
    feesController.webViewController.reload();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: FeesController(),
      builder: (FeesController controller) {
        return Scaffold(
            appBar: AppBar(
              // actions: [
              //   IconButton(onPressed:
              //       (){
              //     print("realod");
              //     setState(() {
              //           () => feesController.webViewController..reload();
              //     });
              //    // feesController.webViewController.reload();
              //   }, icon: Icon(Icons.refresh))
              // ],
              leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back, color: Colors.black),
              ),
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Obx(
                () => WebViewWidget(

                    controller: controller.webViewController
                      ..setJavaScriptMode(JavaScriptMode.unrestricted)
                      ..loadRequest(
                          Uri.parse('${controller.webUrlLink.value}'))),
              ),
            ));
      },
    );
  }
}
