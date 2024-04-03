import 'package:pfe_project/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:pfe_project/core/app_export.dart';

// ignore: must_be_immutable
class CategorieItemWidget extends StatelessWidget {
  const CategorieItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 17.h,
        vertical: 10.v,
      ),
      decoration: AppDecoration.fillGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder24,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomIconButton(
            height: 60.adaptSize,
            width: 60.adaptSize,
            padding: EdgeInsets.all(10.h),
            child: CustomImageView(
              imagePath: ImageConstant.imgMagiconsGlyphEcommerceDeepPurpleA200,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 21.v,
              right: 82.h,
              bottom: 17.v,
            ),
            child: Text(
              "Shopping",
              style: CustomTextStyles.titleMedium18,
            ),
          ),
        ],
      ),
    );
  }
}
