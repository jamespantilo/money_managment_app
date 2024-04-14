// ignore_for_file: use_build_context_synchronously

import 'package:pfe_project/main.dart';
import 'package:pfe_project/widgets/app_bar/custom_app_bar.dart';
import 'package:pfe_project/widgets/app_bar/appbar_leading_image.dart';
import 'package:pfe_project/widgets/app_bar/appbar_subtitle.dart';
import 'package:pfe_project/widgets/custom_text_form_field.dart';
import 'package:pfe_project/widgets/custom_checkbox_button.dart';
import 'package:pfe_project/widgets/custom_elevated_button.dart';
import 'package:pfe_project/widgets/custom_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:pfe_project/core/app_export.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:google_sign_in/google_sign_in.dart';

class OnboardingSignUpScreen extends StatefulWidget {
  const OnboardingSignUpScreen({super.key});

  @override
  State<OnboardingSignUpScreen> createState() => _OnboardingSignUpScreenState();
}

class _OnboardingSignUpScreenState extends State<OnboardingSignUpScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool checkbox = false;
  bool loading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  bool tapIcon = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: Stack(
          children: [
            SizedBox(
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
                      horizontal: 23.h,
                      vertical: 58.v,
                    ),
                    child: Column(
                      children: [
                        _buildName(context),
                        SizedBox(height: 25.v),
                        _buildEmail(context),
                        SizedBox(height: 25.v),
                        _buildPassword(context),
                        SizedBox(height: 18.v),
                        _buildCheckbox(context),
                        SizedBox(height: 25.v),
                        _buildSignUp(context),
                        SizedBox(height: 12.v),
                        Text(
                          "Or",
                          style: CustomTextStyles.titleSmallOnPrimaryContainer,
                        ),
                        SizedBox(height: 14.v),
                        _buildSignUpWithGoogle(context),
                        SizedBox(height: 19.v),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              onTapTxtConfirmation(context);
                            },
                            child: Container(
                              width: 197.h,
                              margin: EdgeInsets.only(left: 49.h),
                              child: Text(
                                "Already have an account? Login",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: CustomTextStyles.titleMediumPrimary
                                    .copyWith(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5.v)
                      ],
                    ),
                  ),
                ),
              ),
            ),
            loading
                ? const Center(
                    child: CircularProgressIndicator(
                    color: Colors.red,
                  ))
                : Container(),
          ],
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
          top: 17.v,
          bottom: 17.v,
        ),
      ),
      centerTitle: true,
      title: AppbarSubtitle(
        text: "Sign Up",
      ),
      styleType: Style.bgFill,
    );
  }

  /// Section Widget
  Widget _buildName(BuildContext context) {
    return CustomTextFormField(
      controller: nameController,
      hintText: "Name",
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please fill the name';
        }
        return null;
      },
    );
  }

  /// Section Widget
  Widget _buildEmail(BuildContext context) {
    return CustomTextFormField(
      controller: emailController,
      hintText: "Email",
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
    );
  }

  /// Section Widget
  Widget _buildPassword(BuildContext context) {
    return CustomTextFormField(
      controller: passwordController,
      hintText: "Password",
      textInputAction: TextInputAction.done,
      textInputType: TextInputType.visiblePassword,
      suffix: tapIcon
          ? InkWell(
              onTap: () {
                setState(() {
                  tapIcon ? tapIcon = false : tapIcon = true;
                });
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(30.h, 12.v, 16.h, 12.v),
                child: CustomImageView(
                  imagePath: ImageConstant.imgEye,
                  height: 32.adaptSize,
                  width: 32.adaptSize,
                  color: Colors.black,
                ),
              ),
            )
          : InkWell(
              onTap: () {
                setState(() {
                  tapIcon ? tapIcon = false : tapIcon = true;
                });
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(30.h, 12.v, 22.h, 12.v),
                child: CustomImageView(
                  imagePath: 'assets/images/hidepswd.png',
                  height: 24.adaptSize,
                  width: 24.adaptSize,
                ),
              ),
            ),
      suffixConstraints: BoxConstraints(
        maxHeight: 58.v,
      ),
      obscureText: tapIcon ? false : true,
      contentPadding: EdgeInsets.only(
        left: 16.h,
        top: 19.v,
        bottom: 19.v,
      ),
      borderDecoration: TextFormFieldStyleHelper.outlineGrayTL161,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please fill the password';
        }
        return null;
      },
    );
  }

  /// Section Widget
  Widget _buildCheckbox(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(right: 31.h),
        child: CustomCheckboxButton(
          alignment: Alignment.centerLeft,
          text:
              "By signing up, you agree to the Terms of Service and Privacy Policy",
          isExpandedText: true,
          value: checkbox,
          onChange: (value) {
            setState(() {
              checkbox = value;
            });
          },
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildSignUp(BuildContext context) {
    return CustomElevatedButton(
      height: 58.v,
      text: "Sign Up",
      onPressed: () {
        setState(() {
          loading = true;
        });
        onTapSignUp(context);
      },
    );
  }

  /// Section Widget
  Widget _buildSignUpWithGoogle(BuildContext context) {
    return CustomOutlinedButton(
      onPressed: () async {
        User? user = await _handleSignUpWithGoogle();
        if (user != null) {
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.homepage, (route) => false);
        }
      },
      text: "Sign Up with Google",
      leftIcon: Container(
        margin: EdgeInsets.only(right: 10.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgFlatcoloriconsgoogle,
          height: 32.adaptSize,
          width: 32.adaptSize,
        ),
      ),
    );
  }

  /// Navigates to the onboardingSignUpVerficationScreen when the action is triggered.
  onTapSignUp(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        final UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        await sharedPref!.setString('name', nameController.text);
        setState(() {
          loading = false;
        });
        await AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'Done',
          desc: 'Your registration has been completed successfully',
          btnOkOnPress: () {},
          btnOkText: "Ok",
        ).show();

        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.onboardingLoginScreen, (route) => false);
      }on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          // Email is already registered
          await AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.rightSlide,
            title: 'Sign Up Error',
            desc: 'The email address is already in use. Please use a different email or try logging in.',
            btnCancelOnPress: () {},
            btnCancelText: "Ok",
          ).show();
          setState(() {
            loading = false;
          });

        } else {
          await AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.rightSlide,
            title: 'Sign Up Error',
            desc: 'Failed to sign up. Please try again.',
            btnCancelOnPress: () {},
            btnCancelText: "Ok",
          ).show();
        }
        setState(() {
          loading = false;
        });
      }
      catch (e) {
        // Handle sign up errors
        print("Error signing up: $e");
      }
    }
  }

  Future<User?> _handleSignUpWithGoogle() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        UserCredential authResult =
            await _auth.signInWithCredential(credential);
        return authResult.user;
      } else {
        // User canceled the Google sign in
        return null;
      }
    } catch (error) {
      print('Error signing up with Google: $error');
      return null;
    }
  }

  /// Navigates to the onboardingLoginScreen when the action is triggered.
  onTapTxtConfirmation(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.onboardingLoginScreen);
  }
}
