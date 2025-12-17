import 'package:educube1/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackBtn extends StatelessWidget {
  const BackBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Stack(
            children: [
              const Padding(
                  padding:  EdgeInsets.all(5),
                  child:  Icon(Icons.arrow_back, size: 25,color: AppColors.colorBlackText,)),
              Positioned.fill(child: InkWell(
                onTap: ()=> Get.back(),
              ))
            ],
          ),
        ));
  }
}
