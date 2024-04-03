import 'package:pfe_project/widgets/app_bar/custom_app_bar.dart';
import 'package:pfe_project/widgets/app_bar/appbar_leading_image.dart';
import 'package:pfe_project/widgets/app_bar/appbar_subtitle.dart';
import 'package:pfe_project/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:pfe_project/core/app_export.dart';

class OnboardingSignUpVerficationScreen extends StatelessWidget {
  const OnboardingSignUpVerficationScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 21.h,
            vertical: 82.v,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Spacer(),
              Container(
                width: 297.h,
                margin: EdgeInsets.only(right: 49.h),
                child: Text(
                  "Enter your Verification Code",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.displaySmall,
                ),
              ),
              SizedBox(height: 52.v),
              Row(
                children: [
                  Text(
                    "8",
                    style: theme.textTheme.headlineLarge,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.h),
                    child: Text(
                      "2",
                      style: theme.textTheme.headlineLarge,
                    ),
                  ),
                  Container(
                    height: 16.adaptSize,
                    width: 16.adaptSize,
                    margin: EdgeInsets.only(
                      left: 16.h,
                      top: 11.v,
                      bottom: 11.v,
                    ),
                    decoration: BoxDecoration(
                      color: appTheme.gray300,
                      borderRadius: BorderRadius.circular(
                        8.h,
                      ),
                    ),
                  ),
                  Container(
                    height: 16.adaptSize,
                    width: 16.adaptSize,
                    margin: EdgeInsets.only(
                      left: 16.h,
                      top: 11.v,
                      bottom: 11.v,
                    ),
                    decoration: BoxDecoration(
                      color: appTheme.gray300,
                      borderRadius: BorderRadius.circular(
                        8.h,
                      ),
                    ),
                  ),
                  Container(
                    height: 16.adaptSize,
                    width: 16.adaptSize,
                    margin: EdgeInsets.only(
                      left: 16.h,
                      top: 11.v,
                      bottom: 11.v,
                    ),
                    decoration: BoxDecoration(
                      color: appTheme.gray300,
                      borderRadius: BorderRadius.circular(
                        8.h,
                      ),
                    ),
                  ),
                  Container(
                    height: 16.adaptSize,
                    width: 16.adaptSize,
                    margin: EdgeInsets.only(
                      left: 16.h,
                      top: 11.v,
                      bottom: 11.v,
                    ),
                    decoration: BoxDecoration(
                      color: appTheme.gray300,
                      borderRadius: BorderRadius.circular(
                        8.h,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 47.v),
              Text(
                "04:59",
                style: CustomTextStyles.titleMediumPrimarySemiBold,
              ),
              SizedBox(height: 14.v),
              Container(
                width: 321.h,
                margin: EdgeInsets.only(right: 27.h),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "We send verification code to your\nemail ",
                        style: CustomTextStyles.titleMediumff292b2d,
                      ),
                      TextSpan(
                        text: "brajaoma*****@gmail.com",
                        style: CustomTextStyles.titleMediumff7e3dff,
                      ),
                      TextSpan(
                        text: ". You can\ncheck your inbox.",
                        style: CustomTextStyles.titleMediumff212224,
                      )
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 13.v),
              Text(
                "I didn’t received the code? Send again",
                style: CustomTextStyles.titleMediumPrimary.copyWith(
                  decoration: TextDecoration.underline,
                ),
              ),
              SizedBox(height: 43.v),
              CustomElevatedButton(
                text: "Verify",
                onPressed: () {
                  onTapVerify(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 64.v,
      leadingWidth: 54.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgMagiconsGlyphPrimary,
        margin: EdgeInsets.only(
          left: 22.h,
          top: 16.v,
          bottom: 16.v,
        ),
      ),
      centerTitle: true,
      title: AppbarSubtitle(
        text: "Verification",
      ),
      styleType: Style.bgFill,
    );
  }

  /// Navigates to the onboardingOnboardingThirteenScreen when the action is triggered.
  onTapVerify(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.homepage);
  }
}
