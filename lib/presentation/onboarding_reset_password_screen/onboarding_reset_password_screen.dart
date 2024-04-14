import 'package:pfe_project/widgets/app_bar/custom_app_bar.dart';
import 'package:pfe_project/widgets/app_bar/appbar_leading_image.dart';
import 'package:pfe_project/widgets/app_bar/appbar_subtitle.dart';
import 'package:pfe_project/widgets/custom_text_form_field.dart';
import 'package:pfe_project/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:pfe_project/core/app_export.dart';

class OnboardingResetPasswordScreen extends StatefulWidget {
  const OnboardingResetPasswordScreen({super.key});

  @override
  State<OnboardingResetPasswordScreen> createState() =>
      _OnboardingResetPasswordScreenState();
}

class _OnboardingResetPasswordScreenState
    extends State<OnboardingResetPasswordScreen> {
  TextEditingController newpasswordController = TextEditingController();

  TextEditingController newpasswordController1 = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                padding: EdgeInsets.symmetric(
                  horizontal: 16.h,
                  vertical: 56.v,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 15.h),
                      child: CustomTextFormField(
                        controller: newpasswordController,
                        hintText: "New Password",
                        textInputType: TextInputType.visiblePassword,
                        obscureText: true,
                      ),
                    ),
                    SizedBox(height: 24.v),
                    Padding(
                      padding: EdgeInsets.only(right: 15.h),
                      child: CustomTextFormField(
                        controller: newpasswordController1,
                        hintText: "Retype new password",
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.visiblePassword,
                        obscureText: true,
                      ),
                    ),
                    SizedBox(height: 32.v),
                    CustomElevatedButton(
                      text: "Continue",
                      margin: EdgeInsets.only(right: 15.h),
                    ),
                    SizedBox(height: 5.v),
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
      leadingWidth: 48.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgMagiconsGlyphPrimary,
        margin: EdgeInsets.only(
          left: 16.h,
          top: 13.v,
          bottom: 16.v,
        ),
      ),
      centerTitle: true,
      title: AppbarSubtitle(
        text: "Reset Password",
      ),
      styleType: Style.bgFill,
    );
  }
}
