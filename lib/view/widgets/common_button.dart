

import 'package:educube1/utils/extensions/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../config/size_config.dart';
import '../../const/app_colors.dart';


class CommonButton extends StatelessWidget {
  String text;
  Color? backgroundColor;
  Color? textColor;
  VoidCallback onPressed;
  RxBool? isEnable = false.obs;
  double? borderRadius;
  double? elevation;
  EdgeInsets? margin;
  EdgeInsets? padding;
  bool fillWidth;


  double? height;
  double? width;
  TextStyle? textStyle;
  double? borderWidth;
  RxBool? isLoading;
  Color? borderColor;
  double? fontSize;
  FontWeight? fontWeight;





  CommonButton({Key? key,
    required this.text,
    this.textColor,
    this.backgroundColor,
    required this.onPressed,
    this.isEnable,
    this.borderRadius,
    this.elevation,
    this.margin,
    this.height,
    this.width,
    this.textStyle,
    this.borderWidth,
    this.isLoading,
    this.borderColor,
    this.fontSize,
    this.fontWeight,
    this.fillWidth = true,
    this.padding

  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
    (isLoading?.value??false) ?
     Center(
        child: SizedBox(
          height: 50,
          width: 51,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: SizedBox(
                height: 48,
                child: CircularProgressIndicator(color: AppColors.btColor)),
          ),
        )):
    Container(
      margin: margin ??   const EdgeInsets.only(left: 16.0,right: 16,bottom:  8.0 ,top:  8.0),
      height: height ?? 50,
      width: fillWidth ?
      width ?? SizeConfig.widthMultiplier *100 : null,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ??10.0),

      ),
      child: ElevatedButton(

        onPressed: isEnable?.value ?? RxBool(true).value
            ? onPressed
            : null,
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(elevation??0),
padding: MaterialStateProperty.all(padding),
            backgroundColor: MaterialStateProperty.all(
                isEnable?.value ?? RxBool(true).value
                    ? backgroundColor ?? AppColors.btColor
                    : backgroundColor ??
                    AppColors.colorTextPrimary.withOpacity(0.7)),

            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    borderRadius ?? 10),
                side: BorderSide(color: borderColor??Colors.transparent, width:borderWidth??0)
            ))),
        child: Center(
          child: Text(
            text.tr,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textStyle ??
                Theme
                    .of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(color: textColor ?? Colors.white, fontWeight:fontWeight ??
                    // FontWeight.w600
                    FontWeight.w700

                    ,fontSize: fontSize ??
                        // 14.fontMultiplier
                        24.fontMultiplier

                ),
          ),
        ),
      ),
    ),
    );
  }
}
