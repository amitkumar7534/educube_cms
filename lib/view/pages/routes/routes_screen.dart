

import 'package:educube1/controller/routes/routes_controller.dart';
import 'package:educube1/utils/extensions/extension.dart';
import 'package:educube1/view/widgets/common_card.dart';
import 'package:educube1/view/widgets/common_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../const/app_colors.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_drawer.dart';
import '../../widgets/common_tile.dart';

class RoutesScreen extends StatefulWidget {
   const RoutesScreen({super.key});

  @override
  State<RoutesScreen> createState() => _RoutesScreenState();
}

class _RoutesScreenState extends State<RoutesScreen> {
final routeController = Get.find<RoutesController>();

// @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//     routeController.
//   }


  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
        title: 'route'.tr,
        showBack: true, onBack: () { Navigator.pop(context); },

        body: Column(
          children: [
            CommonTile(),
            CommonCard(
              borderRadius: 8.0,
              margin: const EdgeInsets.only(top: 10, left: 16, right: 16),
              height: 450,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.color71,
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(8.0),
                            topLeft: Radius.circular(8.0))),
                    height: 50,
                    child: Center(
                        child: Text(
                      'Route from House to School',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontSize: 14.fontMultiplier, color: Colors.white),
                    )),
                  ),
                  Expanded(
                    child:

                    // Obx(() =>
                      GetBuilder<RoutesController>(
                       builder: (controller) {
                         return GoogleMap(
                            onMapCreated: routeController.onMapCreated,
                              markers: routeController.markers.toSet(),
                              // onMapCreated: (controller) {
                              //   setState(() {
                              //     _controller = controller;
                              //   });
                              // },
                            // initialCameraPosition:CameraPosition(
                            //   target: routeController.routeCoordinates.first,
                            //   zoom: 14.0
                            // ) ,
                              initialCameraPosition:  CameraPosition(
                              //  target: LatLng(30.707600, 76.715126),
                              //   target:LatLng(30.7333,76.7794),


                                  target:
                                LatLng(routeController.routeLat.value,routeController.routeLng.value),

                                zoom: 14.0,
                              ),

                            polylines:routeController.polylines,

                          );
                       }
                     ),
                    ),
                 // ),
                ],
              ),
            ),
          ],
        ));
  }
}
