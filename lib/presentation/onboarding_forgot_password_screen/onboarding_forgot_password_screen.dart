// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pfe_project/presentation/onboarding_forgot_password_email_sent_screen/onboarding_forgot_password_email_sent_screen.dart';
import 'package:pfe_project/widgets/app_bar/custom_app_bar.dart';
import 'package:pfe_project/widgets/app_bar/appbar_leading_image.dart';
import 'package:pfe_project/widgets/app_bar/appbar_subtitle.dart';
import 'package:pfe_project/widgets/custom_text_form_field.dart';
import 'package:pfe_project/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:pfe_project/core/app_export.dart';

class OnboardingForgotPasswordScreen extends StatefulWidget {
  const OnboardingForgotPasswordScreen({super.key});

  @override
  State<OnboardingForgotPasswordScreen> createState() =>
      _OnboardingForgotPasswordScreenState();
}

class _OnboardingForgotPasswordScreenState
    extends State<OnboardingForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _resetPassword() async {
    try {
      await _auth.sendPasswordResetEmail(email: emailController.text);
      await AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.rightSlide,
        title: 'Success',
        desc: 'Password reset email sent. Check your inbox.',
        btnOkOnPress: () {},
        btnOkText: "Ok",
      ).show();
      onTapContinue(context);
    } catch (e) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Error',
        desc: 'Failed to send password reset email. Please try again later.',
        btnCancelOnPress: () {},
        btnCancelText: "Ok",
      ).show();
      print('Failed to send password reset email: $e');
    }
  }

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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please fill the email';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 32.v),
                    CustomElevatedButton(
                      text: "Continue",
                      onPressed: () {
                        _resetPassword();
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
    Navigator.push(context, MaterialPageRoute(builder: (context) => OnboardingForgotPasswordEmailSentScreen(email: emailController.text)));
  }
}
