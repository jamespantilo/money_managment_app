import 'package:pfe_project/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:pfe_project/core/app_export.dart';

class OnboardingForgotPasswordEmailSentScreen extends StatelessWidget {
  const OnboardingForgotPasswordEmailSentScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(
            left: 34.h,
            top: 83.v,
            right: 34.h,
          ),
          child: Column(
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgIlustrationDeepPurple50,
                height: 216.v,
                radius: BorderRadius.circular(
                  40.h,
                ),
                alignment: Alignment.centerLeft,
              ),
              SizedBox(height: 67.v),
              Text(
                "Your email is on the way",
                style: CustomTextStyles.headlineSmallOnPrimary,
              ),
              SizedBox(height: 20.v),
              Container(
                width: 281.h,
                margin: EdgeInsets.only(
                  left: 16.h,
                  right: 24.h,
                ),
                child: Text(
                  "Check your email test@test.com and follow the instructions to reset your password",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium,
                ),
              ),
              SizedBox(height: 5.v)
            ],
          ),
        ),
        bottomNavigationBar: _buildBackToLogin(context),
      ),
    );
  }

  /// Section Widget
  Widget _buildBackToLogin(BuildContext context) {
    return CustomElevatedButton(
      text: "Back to Login",
      margin: EdgeInsets.only(
        left: 23.h,
        right: 24.h,
        bottom: 79.v,
      ),
      onPressed: () {
        onTapBackToLogin(context);
      },
    );
  }

  /// Navigates to the onboardingLoginScreen when the action is triggered.
  onTapBackToLogin(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.onboardingLoginScreen);
  }
}
