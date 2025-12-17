import 'package:educube1/const/app_colors.dart';
import 'package:educube1/const/app_icons.dart';
import 'package:educube1/model/TermsModel.dart';
import 'package:educube1/utils/extensions/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/performance/performance_controller.dart';
import '../../../route/app_routes.dart';
import '../../widgets/common_scaffold.dart';
import '../../widgets/common_tile.dart';

class PerformanceListScreen extends StatefulWidget {
  const PerformanceListScreen({super.key});

  @override
  State<PerformanceListScreen> createState() => _PerformanceListScreenState();
}

class _PerformanceListScreenState extends State<PerformanceListScreen> {
  final _performanceController = Get.find<PerformanceController>();

  @override
  void initState() {
    super.initState();
    _performanceController.getTerms();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
        showBack: true, onBack: () { Navigator.pop(context); },

        title: 'Performance',
      body: GetX<PerformanceController>(
        builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            children: [

              CommonTile(),

              controller.list.isNotEmpty ?
              ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                  itemBuilder: (context, index) => _card(controller.list[index],
                      (value){
                    controller.getPerformance(value);
                    Get.toNamed(AppRoutes.routePerformanceSingle);
                      }
                  ),
                  separatorBuilder: (context, index) => const SizedBox(height: 20,),
                  itemCount: controller.list.length
              ) : const Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('No Record found')],
              )

              ,
            ],
          );
        }
      )
    );
  }

  Widget _card(TermsModel data,Function(String) onTap){
    return Column(
      children: [
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.colorLightBlue,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Image.asset(AppIcons.terms, height: 22, width: 22,),
            ),

            Text(data.termValue?? '',style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: 14.fontMultiplier, color: AppColors.colorTextPrimary),),
            const Spacer(),
            InkWell(
              onTap: ()=> onTap(data.termId?? ''),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.colorBlue,
                  borderRadius:BorderRadius.circular(6)
                ),
                child: Text(
                  'View',style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: 12.fontMultiplier, color: AppColors.white),
                ),
              ),
            )
          ],
        ),
         const Divider(
          color: AppColors.colorA9,
           thickness: 1.0,
        )
      ],
    );
  }

}
