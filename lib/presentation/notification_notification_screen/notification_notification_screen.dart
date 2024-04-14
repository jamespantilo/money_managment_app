import 'package:pfe_project/widgets/app_bar/custom_app_bar.dart';
import 'package:pfe_project/widgets/app_bar/appbar_leading_image.dart';
import 'package:pfe_project/widgets/app_bar/appbar_subtitle.dart';
import 'package:pfe_project/widgets/app_bar/appbar_trailing_image.dart';
import 'package:flutter/material.dart';
import 'package:pfe_project/core/app_export.dart';

class NotificationNotificationScreen extends StatefulWidget {
  const NotificationNotificationScreen({super.key});

  @override
  State<NotificationNotificationScreen> createState() =>
      _NotificationNotificationScreenState();
}

class _NotificationNotificationScreenState
    extends State<NotificationNotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              _buildListItem(context),
              SizedBox(height: 5.v),
              _buildListItem1(context),
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
          top: 18.v,
          bottom: 18.v,
        ),
      ),
      centerTitle: true,
      title: AppbarSubtitle(
        text: "Notification",
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgIconsMoreHorizontal,
          margin: EdgeInsets.symmetric(
            horizontal: 16.h,
            vertical: 18.v,
          ),
        ),
      ],
      styleType: Style.bgFill,
    );
  }

  /// Section Widget
  Widget _buildListItem(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 20.h,
        vertical: 13.v,
      ),
      decoration: AppDecoration.fillOnErrorContainer,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 2.v),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Shopping budget has exceeds the..",
                    style: theme.textTheme.titleMedium,
                  ),
                  SizedBox(height: 9.v),
                  Text(
                    "Your Shopping budget has exceeds the lim....",
                    style: theme.textTheme.labelLarge,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 16.h,
              top: 16.v,
              bottom: 15.v,
            ),
            child: Text(
              "19.30",
              style: theme.textTheme.labelLarge,
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildListItem1(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 20.h,
        vertical: 13.v,
      ),
      decoration: AppDecoration.fillOnErrorContainer,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 2.v),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Utilities budget has exceeds the..",
                    style: theme.textTheme.titleMedium,
                  ),
                  SizedBox(height: 9.v),
                  Text(
                    "Your Utilities budget has exceeds the limit....",
                    style: theme.textTheme.labelLarge,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 35.h,
              top: 16.v,
              bottom: 15.v,
            ),
            child: Text(
              "19.30",
              style: theme.textTheme.labelLarge,
            ),
          ),
        ],
      ),
    );
  }
}
