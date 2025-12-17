import 'package:flutter/material.dart';

import '../../const/app_colors.dart';

class CommonCard extends StatelessWidget {
  CommonCard(
      {super.key, this.height, this.borderRadius, this.child,
        this.color,this.margin,this.padding,this.width});

  double? height;
  double? width;
  double? borderRadius;
  Color? color;
  Widget? child;
  EdgeInsets? margin;
  EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding:padding ,
      margin:margin ?? EdgeInsets.symmetric(horizontal: 16),
      height: height,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 1.0,

          )
        ],
          color: color ?? Colors.white,
          border: Border.all(color:AppColors.colorBlue.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(borderRadius ?? 4.0)),
      child: child,
    );
  }
}
