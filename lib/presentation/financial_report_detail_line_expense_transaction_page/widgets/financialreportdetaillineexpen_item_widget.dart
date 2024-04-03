import 'package:pfe_project/widgets/custom_drop_down.dart';
import 'package:pfe_project/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:pfe_project/core/app_export.dart';

// ignore: must_be_immutable
class FinancialreportdetaillineexpenItemWidget extends StatelessWidget {
  FinancialreportdetaillineexpenItemWidget({Key? key})
      : super(
          key: key,
        );

  List<String> dropdownItemList = [
    "Item One",
    "Item Two",
    "Item Three",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 9.v,
      ),
      decoration: AppDecoration.fillOnErrorContainer,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomDropDown(
            width: 131.h,
            hintText: "Transaction",
            items: dropdownItemList,
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
            onChanged: (value) {},
          ),
          CustomIconButton(
            height: 40.adaptSize,
            width: 40.adaptSize,
            padding: EdgeInsets.all(4.h),
            decoration: IconButtonStyleHelper.outlineGray,
            child: CustomImageView(
              imagePath: ImageConstant.imgMagiconsGlyphUser,
            ),
          ),
        ],
      ),
    );
  }
}
