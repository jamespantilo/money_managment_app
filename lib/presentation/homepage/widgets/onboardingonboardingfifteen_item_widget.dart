import 'package:pfe_project/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:pfe_project/core/app_export.dart';

// ignore: must_be_immutable
class OnboardingonboardingfifteenItemWidget extends StatelessWidget {
  const OnboardingonboardingfifteenItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.h,
          vertical: 11.v,
        ),
        decoration: AppDecoration.fillOnErrorContainer,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 7.v,
                bottom: 2.v,
              ),
              child: Text(
                "Recent expences",
                style: CustomTextStyles.titleMediumSemiBold,
              ),
            ),
            _buildSeeAll(context),
          ],
        ),
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
