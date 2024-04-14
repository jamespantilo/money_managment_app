import 'package:pfe_project/widgets/app_bar/custom_app_bar.dart';
import 'package:pfe_project/widgets/app_bar/appbar_leading_image.dart';
import 'package:pfe_project/widgets/app_bar/appbar_subtitle.dart';
import 'package:flutter/material.dart';
import 'package:pfe_project/core/app_export.dart';

class SettingsSettingsScreen extends StatelessWidget {
  const SettingsSettingsScreen({Key? key})
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
          padding: EdgeInsets.symmetric(vertical: 25.v),
          child: Column(
            children: [
              _buildFrame(
                context,
                language: "Currency",
                english: "DH",
              ),
              _buildFrame(
                context,
                language: "Language",
                english: "English",
              ),
              _buildFrame(
                context,
                language: "Theme",
                english: "Light",
              ),
              SizedBox(height: 3.v),
              _buildFrameNinetyEight(
                context,
                about: "Notification",
              ),
              SizedBox(height: 3.v),
              _buildFrameNinetyEight(
                context,
                about: "About",
              ),
              SizedBox(height: 5.v),
            ],
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
          top: 14.v,
          bottom: 14.v,
        ),
      ),
      centerTitle: true,
      title: AppbarSubtitle(
        text: "Settings",
      ),
      styleType: Style.bgFill,
    );
  }

  /// Common widget
  Widget _buildFrame(
    BuildContext context, {
    required String language,
    required String english,
  }) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(16.h),
      decoration: AppDecoration.fillOnErrorContainer,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 3.v),
            child: Text(
              language,
              style: theme.textTheme.titleMedium!.copyWith(
                color: appTheme.blueGray900,
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(top: 5.v),
            child: Text(
              english,
              style: CustomTextStyles.titleSmallOnPrimaryContainer_1.copyWith(
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgMagiconsGlyphPrimary24x24,
            height: 24.adaptSize,
            width: 24.adaptSize,
          ),
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildFrameNinetyEight(
    BuildContext context, {
    required String about,
  }) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(16.h),
      decoration: AppDecoration.fillOnErrorContainer,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 1.v,
              bottom: 2.v,
            ),
            child: Text(
              about,
              style: theme.textTheme.titleMedium!.copyWith(
                color: appTheme.blueGray900,
              ),
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgMagiconsGlyphPrimary24x24,
            height: 24.adaptSize,
            width: 24.adaptSize,
          ),
        ],
      ),
    );
  }
}
