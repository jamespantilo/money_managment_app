import 'package:pfe_project/widgets/app_bar/custom_app_bar.dart';
import 'package:pfe_project/widgets/app_bar/appbar_leading_image.dart';
import 'package:pfe_project/widgets/app_bar/appbar_subtitle.dart';
import 'package:pfe_project/widgets/custom_text_form_field.dart';
import 'package:pfe_project/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:pfe_project/core/app_export.dart';

// ignore_for_file: must_be_immutable
class OnboardingForgotPasswordScreen extends StatelessWidget {
  OnboardingForgotPasswordScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController emailController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: _formKey,
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(
                  left: 23.h,
                  top: 68.v,
                  right: 23.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 326.h,
                      margin: EdgeInsets.only(right: 17.h),
                      child: Text(
                        "Don’t worry. \nEnter your email and we’ll send you a link to reset your password.",
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: CustomTextStyles.headlineSmallOnPrimary,
                      ),
                    ),
                    SizedBox(height: 41.v),
                    CustomTextFormField(
                      controller: emailController,
                      hintText: "Email",
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 32.v),
                    CustomElevatedButton(
                      text: "Continue",
                      onPressed: () {
                        onTapContinue(context);
                      },
                    ),
                    SizedBox(height: 5.v)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 55.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgMagiconsGlyphPrimary,
        margin: EdgeInsets.only(
          left: 23.h,
          top: 13.v,
          bottom: 16.v,
        ),
      ),
      centerTitle: true,
      title: AppbarSubtitle(
        text: "Forgot Password",
      ),
      styleType: Style.bgFill,
    );
  }

  /// Navigates to the onboardingForgotPasswordEmailSentScreen when the action is triggered.
  onTapContinue(BuildContext context) {
    Navigator.pushNamed(
        context, AppRoutes.onboardingForgotPasswordEmailSentScreen);
  }
}
