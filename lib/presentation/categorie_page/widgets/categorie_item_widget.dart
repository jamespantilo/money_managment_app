import 'package:pfe_project/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:pfe_project/core/app_export.dart';
import 'package:pfe_project/widgets/image_type/image_type.dart';

// ignore: must_be_immutable
class CategorieItemWidget extends StatelessWidget {
  const CategorieItemWidget({Key? key, required this.categoryName, required this.iconPath, required this.imageType})
      : super(
          key: key,
        );
final String categoryName;
final String iconPath;
final String imageType;
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
            child: ImageTypeView(
              imagePath: iconPath,
              imageType: imageType,
              color: Colors.deepPurple,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 21.v,
              right: 82.h,
              bottom: 17.v,
            ),
            child: Text(
              categoryName,
              style: CustomTextStyles.titleMedium18,
            ),
          ),
        ],
      ),
    );
  }
}
