import 'package:pfe_project/widgets/app_bar/custom_app_bar.dart';
import 'package:pfe_project/widgets/app_bar/appbar_leading_image.dart';
import 'package:pfe_project/widgets/app_bar/appbar_title.dart';
import 'package:pfe_project/widgets/custom_drop_down.dart';
import 'package:pfe_project/widgets/custom_text_form_field.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:pfe_project/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:pfe_project/core/app_export.dart';

// ignore_for_file: must_be_immutable
class ExpenseNewScreen extends StatelessWidget {
  ExpenseNewScreen({Key? key})
      : super(
          key: key,
        );

  List<String> dropdownItemList = ["Gategory 1", "Gategory 2", "Gategory 3"];

  TextEditingController inputFieldController = TextEditingController();

  List<String> dropdownItemList1 = ["Date 1", "Date 2", "Date 3"];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: AppDecoration.fillOnError,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.v),
                      _buildAppBar(context),
                      SizedBox(height: 75.v),
                      Opacity(
                        opacity: 0.64,
                        child: Padding(
                          padding: EdgeInsets.only(left: 27.h),
                          child: Text(
                            "How much?",
                            style: CustomTextStyles.titleMediumGray50SemiBold18,
                          ),
                        ),
                      ),
                      SizedBox(height: 12.v),
                      Padding(
                        padding: EdgeInsets.only(left: 26.h),
                        child: Row(
                          children: [
                            Text(
                              "0",
                              style: theme.textTheme.displayLarge,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10.h),
                              child: Text(
                                "D ",
                                style: theme.textTheme.displayLarge,
                              ),
                            ),
                            Text(
                              "H ",
                              style: theme.textTheme.displayLarge,
                            )
                          ],
                        ),
                      ),
                      const Spacer(),
                      _buildInputField(context)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      backgroundColor: appTheme.red500,
      height: 32.v,
      leadingWidth: 48.h,
      leading: AppbarLeadingImage(
        onTap: () {
          Navigator.pop(context);
        },
        imagePath: ImageConstant.imgMagiconsGlyphPrimary,
        margin: EdgeInsets.only(left: 16.h),
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "Expense",
      ),
    );
  }

  /// Section Widget
  Widget _buildInputField(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height / 2,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.h,
                vertical: 14.v,
              ),
              decoration: AppDecoration.fillOnErrorContainer.copyWith(
                borderRadius: BorderRadiusStyle.customBorderTL32,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.v),
                  Padding(
                    padding: EdgeInsets.only(right: 15.h),
                    child: CustomDropDown(
                      icon: Container(
                        margin: EdgeInsets.fromLTRB(30.h, 0.v, 16.h, 0.v),
                        child: CustomImageView(
                          imagePath: ImageConstant
                              .imgMagiconsGlyphArrowArrowdown2Black900,
                          height: 32.adaptSize,
                          width: 32.adaptSize,
                        ),
                      ),
                      hintText: "Category",
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
                  SizedBox(height: 16.v),
                  Padding(
                    padding: EdgeInsets.only(right: 15.h),
                    child: CustomTextFormField(
                      controller: inputFieldController,
                      hintText: "Description",
                      textStyle:
                          const TextStyle(color: Colors.black, fontSize: 14),
                      hintStyle:
                          const TextStyle(color: Colors.grey, fontSize: 14),
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                  SizedBox(height: 20.v),
                  Padding(
                    padding: EdgeInsets.only(right: 15.h),
                    child: CustomDropDown(
                      icon: Container(
                        margin: EdgeInsets.fromLTRB(30.h, 0.v, 16.h, 0.v),
                        child: CustomImageView(
                          imagePath: ImageConstant
                              .imgMagiconsGlyphArrowArrowdown2Black900,
                          height: 32.adaptSize,
                          width: 32.adaptSize,
                        ),
                      ),
                      hintText: "Date",
                      items: dropdownItemList1,
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
                  SizedBox(height: 27.v),
                  Container(
                    margin: EdgeInsets.only(right: 14.h),
                    decoration: AppDecoration.outlineGray100021.copyWith(
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
                      radius: const Radius.circular(16),
                      borderType: BorderType.RRect,
                      dashPattern: [8, 8],
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 89.h,
                          vertical: 11.v,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 32.adaptSize,
                              width: 32.adaptSize,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 10.h,
                                top: 6.v,
                                bottom: 5.v,
                              ),
                              child: Container(),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.h,
                vertical: 10.v,
              ),
              decoration: AppDecoration.fillOnErrorContainer,
              child: CustomElevatedButton(
                height: 61.v,
                text: "Save",
                onPressed: () {
                  onTapSave(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Navigates to the onboardingOnboardingThirteenScreen when the action is triggered.
  onTapSave(BuildContext context) {
    Navigator.pop(context);
  }
}
