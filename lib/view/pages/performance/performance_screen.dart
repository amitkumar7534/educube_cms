import 'dart:convert';

import 'package:educube1/controller/performance/performance_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../widgets/backBtn.dart';
import '../../widgets/common_scaffold.dart';

class PerformanceScreen extends StatefulWidget {
  PerformanceScreen({super.key});

  @override
  State<PerformanceScreen> createState() => _PerformanceScreenState();
}

class _PerformanceScreenState extends State<PerformanceScreen> {
  final performanceController = Get.find<PerformanceController>();
  var responseData = "";

  // @override
  // void initState() {
  //   super.initState();
  //   performanceController.launchWeb();
  // }

  WebViewController _controller(String value){
  final ctrl =  WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..clearCache()
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      );

  ctrl.loadRequest(Uri.dataFromString(
    value,
    mimeType: 'text/html',
    encoding: Encoding.getByName('utf-8'),
  ));

  return ctrl;

  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: 'performance'.tr,
      showBack: true, onBack: () { Navigator.pop(context); },

      body: Column(
        children: [
          BackBtn(),
          Expanded(
            child: Obx(() => SizedBox(
                child: WebViewWidget(
                    controller: _controller(performanceController.data.value),
                  gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                    Factory<VerticalDragGestureRecognizer>(
                          () => VerticalDragGestureRecognizer(),
                    ),
                    Factory<ScaleGestureRecognizer>(
                          () => ScaleGestureRecognizer(),
                    ),
                  },
                ))),
          ),
        ],
      ),

      // ListView(
      //   children: [
      //     Obx(
      //       () => Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child:
      //
      //
      //       //           HtmlWidget(
      //       //             // the first parameter (`html`) is required
      //       // //             '''
      //       // // <h3>Heading</h3>
      //       // // <p>
      //       // //   A paragraph with <strong>strong</strong>, <em>emphasized</em>
      //       // //   and <span style="color: red">colored</span> text.
      //       // // </p>
      //       // // ''',
      //       //               performanceController.data.value,
      //       //
      //       //             // all other parameters are optional, a few notable params:
      //       //
      //       //             // specify custom styling for an element
      //       //             // see supported inline styling below
      //       //             customStylesBuilder: (element) {
      //       //               if (element.classes.contains('foo')) {
      //       //                 return {'color': 'red'};
      //       //               }
      //       //
      //       //               return null;
      //       //             },
      //       //
      //       //             // customWidgetBuilder: (element) {
      //       //             //   if (element.attributes['foo'] == 'bar') {
      //       //             //     // render a custom block widget that takes the full width
      //       //             //     return FooBarWidget();
      //       //             //   }
      //       //             //
      //       //             //   if (element.attributes['fizz'] == 'buzz') {
      //       //             //     // render a custom widget inline with surrounding text
      //       //             //     return InlineCustomWidget(
      //       //             //       child: FizzBuzzWidget(),
      //       //             //     )
      //       //             //   }
      //       //             //
      //       //             //   return null;
      //       //             // },
      //       //             //
      //       //             // // this callback will be triggered when user taps a link
      //       //             // onTapUrl: (url) => print('tapped $url'),
      //       //
      //       //             // select the render mode for HTML body
      //       //             // by default, a simple `Column` is rendered
      //       //             // consider using `ListView` or `SliverList` for better performance
      //       //             renderMode: RenderMode.column,
      //       //
      //       //             // set the default styling for text
      //       //             textStyle: TextStyle(fontSize: 14),
      //       //           ),
      //
      //
      //
      //         HtmlWidget(
      //             textStyle: TextStyle(
      //               fontSize: 12.fontMultiplier,
      //               color: Colors.black87,
      //               inherit: false,
      //             ),
      //             renderMode: RenderMode.column,
      //             onErrorBuilder: (context, element, error) => SizedBox(),
      //             performanceController.data.value),
      //
      //       ),
      //     ),
      //   ],
      // )
    );
  }
}
