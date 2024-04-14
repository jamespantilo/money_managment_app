import 'package:pfe_project/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:pfe_project/core/app_export.dart';
import 'package:pfe_project/widgets/custom_icon_button.dart';
import 'package:pfe_project/widgets/image_type/image_type.dart';

// ignore: must_be_immutable
class OnboardingonboardingfifteenItemWidget extends StatelessWidget {
  const OnboardingonboardingfifteenItemWidget({Key? key, required this.imagePath, required this.categoryName, required this.description, required this.amount, required this.isIncome})
      : super(
          key: key,
        );
  final String imagePath;
  final String categoryName;
  final String description;
  final int amount;
  final bool isIncome ;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child:Container(
        padding: EdgeInsets.symmetric(
          horizontal: 17.h,
          vertical: 10.v,
        ),
        decoration: AppDecoration.fillGray.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder24,
        ),
        child: ListTile(
          leading: CustomIconButton(
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
          height: 40.adaptSize,
          width: 40.adaptSize,
          //padding: EdgeInsets.all(4.h),
          child: ImageTypeView(

            imagePath: imagePath,
            imageType: 'asset',
            color: Colors.deepPurple,
          ),
        ),
          title: Text(
          categoryName,
          style: CustomTextStyles.titleMedium18,
        ),
          trailing:  Text(isIncome ? '+$amount' : '-$amount',style:  TextStyle(color: isIncome ? Colors.green : Colors.red,fontSize: 24),),subtitle:  Padding(
          padding: const EdgeInsets.only(top: 4,bottom: 4),
          child: Text(description.length > 20 ? "${description.substring(0, 20)}..." : description,style: const TextStyle(color: Colors.grey,fontSize: 18),),
        ),)
      ),
    );
  }

  /// Section Widget
  Widget _buildSeeAll(BuildContext context) {
    return CustomElevatedButton(
      height: 32.v,
      width: 78.h,
      text: "See All",
      buttonStyle: CustomButtonStyles.fillDeepPurple,
      buttonTextStyle: CustomTextStyles.titleSmallPrimary_1,
    );
  }
}

