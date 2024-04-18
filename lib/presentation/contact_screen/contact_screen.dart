// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pfe_project/main.dart';
import 'package:pfe_project/widgets/app_bar/custom_app_bar.dart';
import 'package:pfe_project/widgets/app_bar/appbar_leading_image.dart';
import 'package:pfe_project/widgets/app_bar/appbar_subtitle.dart';
import 'package:pfe_project/widgets/custom_text_form_field.dart';
import 'package:pfe_project/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:pfe_project/core/app_export.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController messageController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool saved = false;

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
                        onAmountChange: (value) => setState(() {


                        }),
                        controller: emailController,
                        hintText: "Address Email",
                        textInputType: TextInputType.emailAddress,
                        hintStyle: CustomTextStyles.bodyLargeGray800,
                        textStyle: CustomTextStyles.titleSmallGray700,
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
                    ),
                    SizedBox(height: 24.v),
                    Padding(
                      padding: EdgeInsets.only(right: 15.h),
                      child: CustomTextFormField(
                        onAmountChange: (value) => setState(() {


                        }),
                        controller: messageController,
                        hintText: "Message",
                        hintStyle: CustomTextStyles.bodyLargeGray800,
                        textStyle: CustomTextStyles.titleSmallGray700,
                        textInputAction: TextInputAction.done,
                        maxLines: 8,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.h,
                          vertical: 15.v,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please fill the the message';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 5.v)
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: _buildEnvoyer(context),
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
        text: "Contact",
      ),
      styleType: Style.bgFill,
    );
  }

  /// Section Widget
  Widget _buildEnvoyer(BuildContext context) {
    return CustomElevatedButton(
      text: "Envoyer",
      margin: EdgeInsets.only(
        left: 22.h,
        right: 25.h,
        bottom: 79.v,
      ),
      onPressed: () {
        saved ? null : onTapEnvoyer(context);
      },
    );
  }

  /// Navigates to the categorieContainerScreen when the action is triggered.
  onTapEnvoyer(BuildContext context) async {
    if (_formKey.currentState!.validate() ) {
      try {
        await FirebaseFirestore.instance.collection('messages').add({
          'userId': userId,
          'email': emailController.text,
          'message': messageController.text,
        });
        setState(() {
          saved = true;
        });
        emailController.clear();
        messageController.clear();

        await AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.rightSlide,
        title: 'Done',
        desc: 'Message has been sent successfully.',
        btnOkOnPress: () {
          Navigator.pop(context);
        },
        btnOkText: "Ok",
        ).show();
      } catch (e) {
        await AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Failed',
        desc: 'Failed to send message.',
        btnCancelOnPress: () {},
        btnCancelText: "Ok",
        ).show();
      }
    }
  }
}
