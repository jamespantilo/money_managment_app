import 'package:pfe_project/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:pfe_project/core/app_export.dart';

// ignore: must_be_immutable
class AppbarTitleEdittext extends StatelessWidget {
  AppbarTitleEdittext({
    Key? key,
    this.hintText,
    this.controller,
    this.margin,
  }) : super(
          key: key,
        );

  String? hintText;

  TextEditingController? controller;

  EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: CustomTextFormField(
        width: 107.h,
        controller: controller,
        hintText: "October",
        hintStyle: theme.textTheme.titleSmall!,
        prefix: Container(
          margin: EdgeInsets.fromLTRB(8.h, 8.v, 4.h, 8.v),
          child: CustomImageView(
            imagePath: ImageConstant.imgMagiconsGlyphArrowArrowdown2,
            height: 24.adaptSize,
            width: 24.adaptSize,
          ),
        ),
        prefixConstraints: BoxConstraints(
          maxHeight: 40.v,
        ),
      ),
    );
  }
}
