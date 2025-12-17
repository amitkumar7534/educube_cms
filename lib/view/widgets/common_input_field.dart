import 'package:educube1/utils/extensions/extension.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'package:get/get.dart';
import '../../const/app_colors.dart';

class CommonInputField extends StatelessWidget {
  String hint;
  Function(String)? onChanged;
  Function(String)? onFieldSubmitted;
  String? Function(String?)? validator;
  TextEditingController controller;
  TextInputType? inputType;
  double? marginLeft;
  double? marginRight;
  double? marginTop;
  double? marginBottom;
  Widget? leading;
  Widget? trailing;
  int? maxLength;
  List<TextInputFormatter>? inputFormatter;
  TextCapitalization? textCapitalization;
  String? errorText;
  bool? isEnable;
  RxBool? isShowTrailing;
  Color? fillColor;
  Color? borderColor;
  bool? isObscure;
  int? maxLines;
  FocusNode? focusNode;
  bool? autoFocus;
  TextInputAction? textInputAction;

  var inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: AppColors.colorD9));

  var errorInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.red));

  CommonInputField(
      {Key? key,
        required this.controller,
        required this.hint,
        this.onChanged,
        this.validator,
        this.inputType,
        this.inputFormatter,
        this.marginLeft,
        this.marginRight,
        this.marginTop,
        this.marginBottom,
        this.leading,
        this.trailing,
        this.textCapitalization,
        this.errorText,
        this.isEnable,
        this.isObscure,
        this.isShowTrailing,
        this.fillColor,
        this.borderColor,
        this.maxLines,
        this.focusNode,
        this.onFieldSubmitted,
        this.autoFocus,
        this.maxLength,
        this.textInputAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: marginLeft ?? 0,
          right: marginRight ?? 0,
          top: marginTop ?? 8,
          bottom: marginBottom ?? 0),
      child: TextFormField(
        obscureText: isObscure ?? false,
        maxLength: maxLength,
        enabled: isEnable ?? true,
        controller: controller,
        focusNode: focusNode,
        autofocus: autoFocus ?? false,
        style: Theme.of(context).textTheme.copyWith(
            headlineSmall: TextStyle(fontSize: 14, color: Colors.black)
        ).headlineSmall

        // Theme.of(context)
        //     .textTheme
        //     .headline5
        //     ?.copyWith(fontSize: 14, color: Colors.black)


        ,
        keyboardType: inputType,
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        cursorColor: AppColors.kPrimaryColor,
        maxLines: maxLines ?? 1,

        textInputAction: textInputAction,
        decoration: InputDecoration(
            errorMaxLines: 4,
            counterText: "",
            hintText: hint.tr,
            hintStyle: Theme.of(context).textTheme.copyWith(
                headlineSmall: TextStyle(fontSize: 14.fontMultiplier,
                    color: Colors.black.withOpacity(0.4))
            ).headlineSmall
            // Theme.of(context).textTheme.headline5?.copyWith(
            //     fontSize: 14.fontMultiplier,
            //     color: Colors.black.withOpacity(0.4))

            ,
            fillColor: fillColor ?? Colors.white,
            filled: true,
            errorText: null,
            prefixIcon: leading,
            suffixIcon:
            isShowTrailing?.value ?? RxBool(false).value ?
            trailing :
            null,
            border: inputBorder,
            errorBorder: inputBorder,
            enabledBorder: inputBorder,
            disabledBorder: inputBorder,
            focusedBorder: inputBorder,
            focusedErrorBorder: inputBorder,
            errorStyle: Theme.of(context).textTheme.copyWith(
                bodySmall:const TextStyle(fontSize: 12, fontWeight: FontWeight.w300, color: Colors.red)
            ).bodySmall


            // decorationStylebodyText1?.copyWith(
            //     fontSize: 12, fontWeight: FontWeight.w300, color: Colors.red)


            ,
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16)),
        inputFormatters: inputFormatter,
        validator: validator,
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
      ),
    );
  }
}
