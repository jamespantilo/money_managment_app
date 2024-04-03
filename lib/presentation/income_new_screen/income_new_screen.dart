import 'package:pfe_project/widgets/app_bar/custom_app_bar.dart';
import 'package:pfe_project/widgets/app_bar/appbar_leading_image.dart';
import 'package:pfe_project/widgets/app_bar/appbar_title.dart';
import 'package:pfe_project/widgets/custom_text_form_field.dart';
import 'package:pfe_project/widgets/custom_drop_down.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:pfe_project/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:pfe_project/core/app_export.dart';

// ignore_for_file: must_be_immutable
class IncomeNewScreen extends StatelessWidget {
  IncomeNewScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController inputFieldController = TextEditingController();

  TextEditingController inputFieldController1 = TextEditingController();

  List<String> dropdownItemList = ["Date 1", "Date 2", "Date 3"];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: Container(
          color: appTheme.teal500,
          width: double.maxFinite,
          //padding: EdgeInsets.symmetric(vertical: 4.v),
          child: Column(
            children: [
              SizedBox(height: 63.v),
              Expanded(
                child: Container(
                  decoration: AppDecoration.fillTeal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Opacity(
                        opacity: 0.64,
                        child: Padding(
                          padding: EdgeInsets.only(left: 26.h),
                          child: Text(
                            "How much?",
                            style: CustomTextStyles.titleMediumGray50SemiBold18,
                          ),
                        ),
                      ),
                      SizedBox(height: 12.v),
                      Padding(
                        padding: EdgeInsets.only(left: 25.h),
                        child: Row(
                          children: [
                            Text(
                              "1",
                              style: theme.textTheme.displayLarge,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5.h),
                              child: Text(
                                "DH",
                                style: theme.textTheme.displayLarge,
                              ),
                            )
                          ],
                        ),
                      ),
                      Spacer(),
                      _buildFrame(context)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: _buildSave(context),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      backgroundColor: appTheme.teal500,
      height: 56.v,
      leadingWidth: 48.h,
      leading: AppbarLeadingImage(
        onTap: () {
          Navigator.pop(context);
        },
        imagePath: ImageConstant.imgMagiconsGlyphPrimary,
        margin: EdgeInsets.only(
          left: 16.h,
          top: 12.v,
          bottom: 12.v,
        ),
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "Income",
      ),
    );
  }

  /// Section Widget
  Widget _buildFrame(BuildContext context) {
    return Container(
      width: 389.h,
      padding: EdgeInsets.symmetric(horizontal: 15.h),
      decoration: AppDecoration.fillOnErrorContainer.copyWith(
        borderRadius: BorderRadiusStyle.customBorderTL32,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 29.v),
          Padding(
            padding: EdgeInsets.only(
              left: 13.h,
              right: 15.h,
            ),
            child: CustomTextFormField(
              controller: inputFieldController,
              hintText: "Source",
              hintStyle: CustomTextStyles.bodyLargeGray800,
              //borderDecoration: TextFormFieldStyleHelper.outlineGrayTL161,
            ),
          ),
          SizedBox(height: 16.v),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.h),
            child: CustomTextFormField(
              controller: inputFieldController1,
              hintText: "Description",
              hintStyle: CustomTextStyles.bodyLargeGray800,
              textInputAction: TextInputAction.done,
            ),
          ),
          SizedBox(height: 20.v),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.h),
            child: CustomDropDown(
              icon: CustomImageView(
                imagePath:
                    ImageConstant.imgMagiconsGlyphArrowArrowdown2Black900,
                height: 32.adaptSize,
                width: 32.adaptSize,
              ),
              hintText: "Date",
              items: dropdownItemList,
              contentPadding: EdgeInsets.only(
                left: 16.h,
                top: 18.v,
                bottom: 18.v,
              ),
              borderDecoration: DropDownStyleHelper.outlineGrayTL16,
              filled: true,
              fillColor: theme.colorScheme.onErrorContainer,
            ),
          ),
          SizedBox(height: 30.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(right: 15.h),
              decoration: AppDecoration.outlineGray100022.copyWith(
                borderRadius: BorderRadiusStyle.circleBorder17,
              ),
              child: DottedBorder(
                color: appTheme.gray10002,
                padding: EdgeInsets.only(
                  left: 1.h,
                  top: 1.v,
                  right: 1.h,
                  bottom: 1.v,
                ),
                strokeWidth: 1.h,
                radius: Radius.circular(16),
                borderType: BorderType.RRect,
                dashPattern: [8, 8],
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 89.h,
                    vertical: 8.v,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 32.adaptSize,
                        width: 32.adaptSize,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 10.h,
                          top: 9.v,
                          bottom: 5.v,
                        ),
                        child: Container(),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildSave(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 52.v, top: 20.h),
      padding: EdgeInsets.symmetric(horizontal: 15.h),
      child: CustomElevatedButton(
        height: 66.v,
        text: "Save",
        onPressed: () {
          onTapSave(context);
        },
      ),
    );
  }

  /// Navigates to the onboardingOnboardingThirteenScreen when the action is triggered.
  onTapSave(BuildContext context) {
    Navigator.pop(context);
  }
}
