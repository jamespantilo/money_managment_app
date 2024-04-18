// ignore_for_file: use_build_context_synchronously

import 'dart:ffi';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pfe_project/main.dart';
import 'package:pfe_project/widgets/app_bar/custom_app_bar.dart';
import 'package:pfe_project/widgets/app_bar/appbar_leading_image.dart';
import 'package:pfe_project/widgets/app_bar/appbar_subtitle.dart';
import 'package:pfe_project/widgets/custom_text_form_field.dart';
import 'package:pfe_project/widgets/custom_elevated_button.dart';
import 'package:pfe_project/widgets/custom_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:pfe_project/core/app_export.dart';

class OnboardingLoginScreen extends StatefulWidget {
  const OnboardingLoginScreen({super.key});

  @override
  State<OnboardingLoginScreen> createState() => _OnboardingLoginScreenState();
}

class _OnboardingLoginScreenState extends State<OnboardingLoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  bool tapIcon = false;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: Stack(
          children: [
            loading ? const Center(child: CircularProgressIndicator(color: Colors.red,),) : const SizedBox(),
            SizedBox(
              width: SizeUtils.width,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: SizedBox(
                  height: SizeUtils.height,
                  child: Form(
                    key: _formKey,
                    child: Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(
                        horizontal: 22.h,
                        vertical: 56.v,
                      ),
                      child: Column(
                        children: [
                          _buildEmail(context),
                          SizedBox(height: 24.v),
                          _buildPassword(context),
                          SizedBox(height: 40.v),
                          _buildLogin(context),
                          SizedBox(height: 35.v),
                          GestureDetector(
                            onTap: () {
                              onTapTxtForgotPassword(context);
                            },
                            child: Text(
                              "Forgot Password?",
                              style: CustomTextStyles.titleMediumPrimarySemiBold,
                            ),
                          ),
                          SizedBox(height: 36.v),
                          GestureDetector(
                            onTap: () {
                              onTapTxtConfirmation(context);
                            },
                            child: Text(
                              "Don’t have an account yet? Sign Up",
                              style: CustomTextStyles.titleMediumPrimary.copyWith(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "Or",
                            style: CustomTextStyles.titleSmallOnPrimaryContainer,
                          ),
                          SizedBox(height: 14.v),
                          _buildSignInWithGoogle(context),
                          SizedBox(height: 57.v)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 54.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgMagiconsGlyphPrimary,
        margin: EdgeInsets.only(
          left: 22.h,
          top: 13.v,
          bottom: 16.v,
        ),
      ),
      centerTitle: true,
      title: AppbarSubtitle(
        text: "Login",
      ),
      styleType: Style.bgFill,
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
        maxHeight: 56.v,
      ),
      obscureText: tapIcon ? false : true,
      contentPadding: EdgeInsets.only(
        left: 16.h,
        top: 18.v,
        bottom: 18.v,
      ),
      borderDecoration: TextFormFieldStyleHelper.outlineGrayTL161,
    );
  }

  /// Section Widget
  Widget _buildLogin(BuildContext context) {
    return CustomElevatedButton(
      text: "Login",
      onPressed: () {
        onTapLogin(context);
      },
    );
  }

  /// Section Widget
  Widget _buildSignInWithGoogle(BuildContext context) {
    return CustomOutlinedButton(
      onPressed: () async {
        User? user = await _handleSignIn();
        if (user != null) {
          await sharedPref!.setInt('signin', 1);
          sharedPref!.getBool('set_profile')!
              ? Navigator.pushNamedAndRemoveUntil(
                  context, AppRoutes.homepage, (route) => false)
              : Navigator.pushNamedAndRemoveUntil(
                  context, AppRoutes.setprofilePage, (route) => false);
        }
      },
      text: "Sign in with Google",
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

  Future<User?> _handleSignIn() async {
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
      print('Error signing in with Google: $error');
      return null;
    }
  }



   Future<int?>fetchUserProfile(String userId) async {
     try {
       QuerySnapshot querySnapshot = await _firestore
           .collection('user')
           .where('userId', isEqualTo: userId)
           .limit(1)
           .get();
       if (querySnapshot.docs.isNotEmpty) {
         var userData = querySnapshot.docs.first.data() as Map<String, dynamic>;
         return userData['set_profile'] as int?;
       } else {
         return null; // User document not found
       }
     } catch (e) {
       print('Error fetching user profile: $e');
       return null; // Handle error fetching user profile
     }
  }

  Future<String?>fetchUserEmail(String userId) async {

    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('user')
          .where('userId', isEqualTo: userId)
          .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        var userData = querySnapshot.docs.first.data() as Map<String, dynamic>;
        return userData['email'] as String?;
      } else {
        return null; // User document not found
      }
    } catch (e) {
      print('Error fetching user profile: $e');
      return null; // Handle error fetching user profile
    }
  }

  /// Navigates to the onboardingOnboardingThirteenScreen when the action is triggered.
  onTapLogin(BuildContext context) async {
    setState(() {
      loading = true;
    });
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        final userId1 = userCredential.user!.uid;
        sharedPref!.getString('userId') ??
              await sharedPref!.setString('userId', userId1);
        userId = sharedPref!.getString('userId')!;
        sharedPref!.getString('imagePath') ?? await getImagePath(sharedPref!.getString('userId')!);
        sharedPref!.getString('username') ?? await getImagePath(sharedPref!.getString('userId')!);
        fetchCategoriesByUserId().then((_) async {
          await fetchAndMergeCategories();
        });
        sharedPref!.getBool('notification') ?? sharedPref!.setBool('notification', false);
        int? userProfile = await fetchUserProfile(userId1);
        if (userProfile != null) {
          await sharedPref!.setInt('set_profile', userProfile);
        } else {
          await sharedPref!.setInt('set_profile', 0);
        }
        String? userEmail = await fetchUserEmail(userId1);
        if (userEmail != null) {
          await sharedPref!.setString('email', userEmail);
        } else {
          await sharedPref!.setString('email', emailController.text);
        }
        await sharedPref!.setInt('signin', 1);
        setState(() {
          loading = false;
        });
        sharedPref!.getInt('set_profile')! != 0
            ? Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.homepage, (route) => false)
            : Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.setprofilePage, (route) => false);
        // Sign-in successful, navigate to next screen or perform other actions
      } catch (e) {
        // Sign-in failed, handle error
        debugPrint("Failed to sign in: $e");

      setState(() {
        loading = false;
      });
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Sign In Error',
          desc: 'Failed to sign in. Please check your email and password.',
          btnCancelOnPress: () {},
          btnCancelText: "Ok",
        ).show();
      }
    }else {
      setState(() {
        loading = false;
      });
    }
  }

  /// Navigates to the onboardingForgotPasswordScreen when the action is triggered.
  onTapTxtForgotPassword(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.onboardingForgotPasswordScreen);
  }

  /// Navigates to the onboardingSignUpScreen when the action is triggered.
  onTapTxtConfirmation(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.onboardingSignUpScreen);
  }
}
