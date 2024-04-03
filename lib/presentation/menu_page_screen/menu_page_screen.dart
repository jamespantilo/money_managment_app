import 'package:pfe_project/widgets/app_bar/custom_app_bar.dart';
import 'package:pfe_project/widgets/app_bar/appbar_leading_image.dart';
import 'package:pfe_project/widgets/app_bar/appbar_subtitle.dart';
import 'package:pfe_project/widgets/custom_icon_button.dart';
import 'package:pfe_project/main.dart';
import 'package:flutter/material.dart';
import 'package:pfe_project/core/app_export.dart';

class MenuPageScreen extends StatelessWidget {
  const MenuPageScreen({Key? key})
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
            horizontal: 22.h,
            vertical: 33.v,
          ),
          child: Column(
            children: [
              _buildEightySeven(context),
              SizedBox(height: 59.v),
              _buildEight(context),
              SizedBox(height: 5.v),
              _buildFifteen(context),
              SizedBox(height: 5.v),
              _buildTen(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 52.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgMagiconsGlyphPrimary,
        margin: EdgeInsets.only(
          left: 20.h,
          bottom: 16.v,
        ),
      ),
      centerTitle: true,
      title: AppbarSubtitle(
        text: "Setting",
      ),
      styleType: Style.bgFill,
    );
  }

  /// Section Widget
  Widget _buildEightySeven(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 13.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.myImg,
            width: 80.h,
            height: 80.h,
            fit: BoxFit.cover,
            radius: BorderRadius.circular(
              50,
            ),
            alignment: Alignment.center,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 26.h,
              top: 14.v,
              bottom: 14.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Username",
                  style: CustomTextStyles.titleSmallOnPrimaryContainer_1,
                ),
                SizedBox(height: 6.v),
                Text(
                  "Izeddin ",
                  style: CustomTextStyles.headlineSmallPrimaryContainer,
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(
              top: 19.v,
              bottom: 23.v,
            ),
            child: CustomIconButton(
              height: 40.adaptSize,
              width: 40.adaptSize,
              padding: EdgeInsets.all(4.h),
              decoration: IconButtonStyleHelper.outlineGray,
              child: CustomImageView(
                imagePath: ImageConstant.imgMagiconsOutlineUser,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildEight(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.settingsSettingsScreen);
      },
      child: Container(
        margin: EdgeInsets.only(right: 10.h),
        padding: EdgeInsets.all(17.h),
        decoration: AppDecoration.fillDeepPurpleA.copyWith(
          borderRadius: BorderRadiusStyle.customBorderTL24,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: 53.v,
              width: 54.h,
              margin: EdgeInsets.only(bottom: 1.v),
              padding: EdgeInsets.all(10.h),
              decoration: AppDecoration.fillDeepPurple.copyWith(
                borderRadius: BorderRadiusStyle.circleBorder17,
              ),
              child: CustomImageView(
                imagePath: ImageConstant.imgParametres1,
                height: 33.v,
                alignment: Alignment.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 9.h,
                top: 17.v,
                bottom: 16.v,
              ),
              child: Text(
                "Settings",
                style: theme.textTheme.titleMedium,
              ),
            ),
            const Spacer(),
            CustomImageView(
              imagePath: ImageConstant.imgVector9,
              width: 8.h,
              margin: EdgeInsets.symmetric(vertical: 16.v),
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildFourteen(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.h),
      padding: EdgeInsets.symmetric(
        horizontal: 17.h,
        vertical: 16.v,
      ),
      decoration: AppDecoration.fillDeepPurpleA,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 1.v),
            child: CustomIconButton(
              height: 56.adaptSize,
              width: 56.adaptSize,
              padding: EdgeInsets.all(10.h),
              child: CustomImageView(
                imagePath: ImageConstant.imgMagiconsOutlineUserPrimary,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 9.h,
              top: 19.v,
              bottom: 17.v,
            ),
            child: Text(
              "Download Report",
              style: theme.textTheme.titleMedium,
            ),
          ),
          const Spacer(),
          CustomImageView(
            imagePath: ImageConstant.imgVector9,
            width: 8.h,
            margin: EdgeInsets.symmetric(vertical: 16.v),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildFifteen(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.contactScreen);
      },
      child: Container(
        margin: EdgeInsets.only(right: 10.h),
        padding: EdgeInsets.symmetric(
          horizontal: 17.h,
          vertical: 15.v,
        ),
        decoration: AppDecoration.fillDeepPurpleA,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: 58.adaptSize,
              width: 58.adaptSize,
              margin: EdgeInsets.only(bottom: 1.v),
              padding: EdgeInsets.all(10.h),
              decoration: AppDecoration.fillDeepPurple.copyWith(
                borderRadius: BorderRadiusStyle.circleBorder17,
              ),
              child: CustomImageView(
                imagePath: ImageConstant.imgCourrielDeContact,
                height: 38.adaptSize,
                width: 38.adaptSize,
                alignment: Alignment.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 9.h,
                top: 18.v,
                bottom: 20.v,
              ),
              child: Text(
                "Contact",
                style: theme.textTheme.titleMedium,
              ),
            ),
            const Spacer(),
            CustomImageView(
              imagePath: ImageConstant.imgVector9,
              width: 8.h,
              margin: EdgeInsets.only(
                top: 17.v,
                bottom: 18.v,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildSixteen(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.h),
      padding: EdgeInsets.symmetric(
        horizontal: 17.h,
        vertical: 13.v,
      ),
      decoration: AppDecoration.fillDeepPurpleA,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: 62.v,
            width: 56.h,
            margin: EdgeInsets.only(top: 1.v),
            padding: EdgeInsets.all(10.h),
            decoration: AppDecoration.fillDeepPurple.copyWith(
              borderRadius: BorderRadiusStyle.circleBorder17,
            ),
            child: CustomImageView(
              imagePath: ImageConstant.imgInformations1,
              width: 36.h,
              alignment: Alignment.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 9.h,
              top: 22.v,
              bottom: 20.v,
            ),
            child: Text(
              "Q/A",
              style: theme.textTheme.titleMedium,
            ),
          ),
          const Spacer(),
          CustomImageView(
            imagePath: ImageConstant.imgVector9,
            width: 8.h,
            margin: EdgeInsets.only(
              top: 20.v,
              bottom: 19.v,
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildTen(BuildContext context) {
    return InkWell(
      onTap: () async{
        await sharedPref!.setInt('signin',0);
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.onboardingLoginScreen, (route) => false);
      },
      child: Container(
        margin: EdgeInsets.only(right: 10.h),
        padding: EdgeInsets.symmetric(
          horizontal: 17.h,
          vertical: 18.v,
        ),
        decoration: AppDecoration.fillDeepPurpleA.copyWith(
          borderRadius: BorderRadiusStyle.customBorderBL24,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 1.v),
              child: CustomIconButton(
                height: 52.adaptSize,
                width: 52.adaptSize,
                padding: EdgeInsets.all(10.h),
                decoration: IconButtonStyleHelper.fillDeepOrange,
                child: CustomImageView(
                  imagePath: ImageConstant.imgMagiconsOutlineUserOnerror,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 9.h,
                top: 17.v,
                bottom: 15.v,
              ),
              child: Text(
                "Logout",
                style: theme.textTheme.titleMedium,
              ),
            ),
            const Spacer(),
            CustomImageView(
              imagePath: ImageConstant.imgVector9,
              width: 8.h,
              margin: EdgeInsets.only(
                top: 14.v,
                bottom: 15.v,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
