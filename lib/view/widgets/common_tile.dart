import 'package:educube1/const/app_colors.dart';
import 'package:educube1/utils/extensions/extension.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';

import '../../controller/profile/profile_controller.dart';

class CommonTile extends StatelessWidget {
  CommonTile({super.key,this.visible});

  final profileController = Get.find<ProfileController>();
bool? visible;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: visible ?? false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(Icons.keyboard_backspace_outlined,
                    color: AppColors.colorTextPrimary)),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16.0, top: 16, bottom: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,

            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Obx(
                  () => FittedBox(
                    alignment: Alignment.centerLeft,
                    fit: BoxFit.scaleDown,
                    child: Text(profileController.userNameValue
                      // profileController.userName.value == null  ? '':
                      // profileController.userName.value.toString()
                      ,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontSize: 18.fontMultiplier,
                          fontWeight: FontWeight.w600,
                          color: AppColors.colorBlue,   // 👈 changed to white
                        )
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10,),
              Expanded(
                child: FittedBox(
                  alignment: Alignment.centerRight,
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Class ${profileController.userClassValue}',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontSize: 18.fontMultiplier,
                        fontWeight: FontWeight.w400,
                        color: AppColors.colorTextPrimary,   // 👈 changed to white
                      )
                  ),
                ),
              )


            ],
          ),
        ),
      ],
    );
  }
}
