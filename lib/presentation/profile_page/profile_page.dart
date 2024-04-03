import 'package:pfe_project/widgets/custom_icon_button.dart';
import 'package:pfe_project/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:pfe_project/core/app_export.dart';

// ignore_for_file: must_be_immutable
class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key})
      : super(
          key: key,
        );

  TextEditingController mohamedController = TextEditingController();

  TextEditingController mohamedController1 = TextEditingController();

  TextEditingController yassineController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                decoration: AppDecoration.fillOnErrorContainer,
                child: Column(
                  children: [
                    _buildThirtyFour(context),
                    Divider(),
                    SizedBox(height: 49.v),
                    _buildThirtySeven(context),
                    SizedBox(height: 14.v),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 36.h),
                        child: Text(
                          "Prénom",
                          style: CustomTextStyles.titleSmallGray700,
                        ),
                      ),
                    ),
                    _buildMohamed(context),
                    SizedBox(height: 15.v),
                    _buildThirtySix(context),
                    SizedBox(height: 16.v),
                    _buildThirtyThree(context),
                    SizedBox(height: 14.v),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 36.h),
                        child: Text(
                          "Adresse email",
                          style: CustomTextStyles.titleSmallGray700,
                        ),
                      ),
                    ),
                    SizedBox(height: 91.v),
                    _buildEmail(context),
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
  Widget _buildThirtyFour(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 1.h),
      padding: EdgeInsets.symmetric(
        horizontal: 57.h,
        vertical: 22.v,
      ),
      decoration: AppDecoration.fillGray10001,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 115.adaptSize,
            width: 115.adaptSize,
            margin: EdgeInsets.only(bottom: 12.v),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.myImg,
                  height: 115.adaptSize,
                  width: 115.adaptSize,
                  radius: BorderRadius.circular(
                    57.h,
                  ),
                  alignment: Alignment.center,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: 5.h,
                    bottom: 4.v,
                  ),
                  child: CustomIconButton(
                    height: 22.adaptSize,
                    width: 22.adaptSize,
                    padding: EdgeInsets.all(2.h),
                    decoration: IconButtonStyleHelper.fillDeepPurpleA,
                    alignment: Alignment.bottomRight,
                    child: CustomImageView(
                      imagePath: ImageConstant.imgEdit1SvgrepoCom,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 14.v,
              right: 13.h,
              bottom: 26.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 121.h,
                  child: Text(
                    "Izeddin\nSinan",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextStyles.headlineSmallBlack900,
                  ),
                ),
                SizedBox(height: 5.v),
                Text(
                  "# 1200",
                  style: CustomTextStyles.titleSmallGray500,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildThirtySeven(BuildContext context) {
    return SizedBox(
      height: 66.v,
      width: 318.h,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          CustomTextFormField(
            width: 318.h,
            controller: mohamedController,
            hintText: "Izeddin_123",
            hintStyle: theme.textTheme.titleLarge!,
            alignment: Alignment.bottomCenter,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 30.h,
              vertical: 9.v,
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Pseudo",
              style: CustomTextStyles.titleSmallGray700,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 18.v,
              right: 4.h,
            ),
            child: CustomIconButton(
              height: 20.adaptSize,
              width: 20.adaptSize,
              padding: EdgeInsets.all(2.h),
              decoration: IconButtonStyleHelper.fillDeepPurpleA,
              alignment: Alignment.topRight,
              child: CustomImageView(
                imagePath: ImageConstant.imgEdit1SvgrepoCom,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildMohamed(BuildContext context) {
    return SizedBox(
      height: 48.v,
      width: 318.h,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          CustomTextFormField(
            width: 318.h,
            controller: mohamedController1,
            hintText: "Izeddin",
            hintStyle: theme.textTheme.titleLarge!,
            alignment: Alignment.bottomCenter,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 30.h,
              vertical: 9.v,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 4.h),
            child: CustomIconButton(
              height: 20.adaptSize,
              width: 20.adaptSize,
              padding: EdgeInsets.all(2.h),
              decoration: IconButtonStyleHelper.fillDeepPurpleA,
              alignment: Alignment.topRight,
              child: CustomImageView(
                imagePath: ImageConstant.imgEdit1SvgrepoCom,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildThirtySix(BuildContext context) {
    return SizedBox(
      height: 66.v,
      width: 318.h,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          CustomTextFormField(
            width: 318.h,
            controller: yassineController,
            hintText: "Sinan",
            hintStyle: theme.textTheme.titleLarge!,
            alignment: Alignment.bottomCenter,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 30.h,
              vertical: 9.v,
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Nom",
              style: CustomTextStyles.titleSmallGray700,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 18.v,
              right: 4.h,
            ),
            child: CustomIconButton(
              height: 20.adaptSize,
              width: 20.adaptSize,
              padding: EdgeInsets.all(2.h),
              decoration: IconButtonStyleHelper.fillDeepPurpleA,
              alignment: Alignment.topRight,
              child: CustomImageView(
                imagePath: ImageConstant.imgEdit1SvgrepoCom,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildThirtyThree(BuildContext context) {
    return SizedBox(
      height: 65.v,
      width: 318.h,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 79.h,
                vertical: 8.v,
              ),
              decoration: AppDecoration.outlineGray10002.copyWith(
                borderRadius: BorderRadiusStyle.circleBorder17,
              ),
              child: Text(
                "+212 000-000000",
                style: theme.textTheme.titleLarge,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Numéro de téléphone",
              style: CustomTextStyles.titleSmallGray700,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 17.v,
              right: 4.h,
            ),
            child: CustomIconButton(
              height: 20.adaptSize,
              width: 20.adaptSize,
              padding: EdgeInsets.all(2.h),
              decoration: IconButtonStyleHelper.fillDeepPurpleA,
              alignment: Alignment.topRight,
              child: CustomImageView(
                imagePath: ImageConstant.imgEdit1SvgrepoCom,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildEmail(BuildContext context) {
    return SizedBox(
      height: 48.v,
      width: 318.h,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          CustomTextFormField(
            width: 318.h,
            controller: emailController,
            hintText: "izeddine1937@gmail.com",
            hintStyle: theme.textTheme.titleLarge!,
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.emailAddress,
            alignment: Alignment.bottomCenter,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 30.h,
              vertical: 9.v,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 4.h),
            child: CustomIconButton(
              height: 20.adaptSize,
              width: 20.adaptSize,
              padding: EdgeInsets.all(2.h),
              decoration: IconButtonStyleHelper.fillDeepPurpleA,
              alignment: Alignment.topRight,
              child: CustomImageView(
                imagePath: ImageConstant.imgEdit1SvgrepoCom,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
