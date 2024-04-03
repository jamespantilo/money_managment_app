import 'package:pfe_project/widgets/app_bar/custom_app_bar.dart';
import 'package:pfe_project/widgets/app_bar/appbar_leading_image.dart';
import 'package:pfe_project/widgets/app_bar/appbar_subtitle.dart';
import 'package:pfe_project/widgets/custom_text_form_field.dart';
import 'package:pfe_project/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:pfe_project/core/app_export.dart';

// ignore_for_file: must_be_immutable
class ContactScreen extends StatelessWidget {
  ContactScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController emailController = TextEditingController();

  TextEditingController messageController = TextEditingController();

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
                        controller: emailController,
                        hintText: "Address Email",
                        textInputType: TextInputType.emailAddress,
                      ),
                    ),
                    SizedBox(height: 24.v),
                    Padding(
                      padding: EdgeInsets.only(right: 15.h),
                      child: CustomTextFormField(
                        controller: messageController,
                        hintText: "Message",
                        textInputAction: TextInputAction.done,
                        maxLines: 8,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.h,
                          vertical: 15.v,
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
        onTapEnvoyer(context);
      },
    );
  }

  /// Navigates to the categorieContainerScreen when the action is triggered.
  onTapEnvoyer(BuildContext context) {
    Navigator.pop(context);
  }
}
