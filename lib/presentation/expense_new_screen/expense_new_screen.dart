// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:pfe_project/presentation/income_new_screen/drop_down_widget/categories_drop_down.dart';
import 'package:pfe_project/presentation/income_new_screen/drop_down_widget/drop_down_widget.dart';
import 'package:pfe_project/widgets/app_bar/custom_app_bar.dart';
import 'package:pfe_project/widgets/app_bar/appbar_leading_image.dart';
import 'package:pfe_project/widgets/app_bar/appbar_title.dart';
import 'package:pfe_project/widgets/custom_text_form_field.dart';
import 'package:pfe_project/widgets/custom_drop_down.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:pfe_project/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:pfe_project/core/app_export.dart';
import 'package:pfe_project/widgets/widget_dropdown.dart';

import '../../main.dart';

class ExpenseNewScreen extends StatefulWidget {
  const ExpenseNewScreen({super.key});


  @override
  State<ExpenseNewScreen> createState() => _ExpenseNewScreenState();
}

class _ExpenseNewScreenState extends State<ExpenseNewScreen> {
  TextEditingController inputFieldController = TextEditingController();
  TextEditingController howMuchController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController inputFieldController1 = TextEditingController();

  List<Widget> categoryDropdownItemList = [];
  List<String> dateDropdownItemList = ["Date 1", "Date 2", "Date 3"];
  String selectedCategory = '';
  int amountValue = 0;


  DateTime? _selectedDate;
  bool saved = false;

  // Function to show date picker and update selected date
  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(), // Use selected date or current date
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()  async{
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, AppRoutes.homepage);
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: _buildAppBar(context),
          body: Form(
            key: _formKey,
            child: Container(
              color: appTheme.red500,
              child: Column(
                children: [
                  SizedBox(height: 63.v),
                  Expanded(
                    child: Container(
                      decoration: AppDecoration.fillOnError,
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
                                  '$amountValue',
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
                          const Spacer(),
                          _buildFrame(context)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          bottomNavigationBar: _buildSave(context),
        ),
      ),
    );
  }


  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      backgroundColor: appTheme.red500,
      height: 56.v,
      leadingWidth: 48.h,
      leading: AppbarLeadingImage(
        onTap: () {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, AppRoutes.homepage);
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
        text: "Expense",
      ),
    );
  }

  /// Section Widget
  Widget _buildFrame(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: EdgeInsets.symmetric(horizontal: 15.h),
      decoration: AppDecoration.fillOnErrorContainer.copyWith(
        borderRadius: BorderRadiusStyle.customBorderTL32,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 29.v),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.h),
            child: CustomTextFormField(
              onAmountChange: (value) => setState(() {
                amountValue = value ;

              } ),
              controller: howMuchController,
              textStyle: CustomTextStyles.titleSmallGray700,
              hintText: "Amount",

              hintStyle: CustomTextStyles.bodyLargeGray800,
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please fill the the amount';
                }
                return null;
              },
            ),
          ),
          SizedBox(height: 29.v),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.h),
            child: CategoryCustomDropDown(
              onCategorySelected: (value) => setState(() => selectedCategory = value),
              icon: CustomImageView(
                imagePath:
                ImageConstant.imgMagiconsGlyphArrowArrowdown2Black900,
                height: 32.adaptSize,
                width: 32.adaptSize,
              ),
              hintText: "Category",
              items: dateDropdownItemList,
              contentPadding: EdgeInsets.only(
                left: 16.h,
                top: 18.v,
                bottom: 18.v,
              ),
              borderDecoration: DropDownStyleHelper1.outlineGrayTL16,
              filled: true,
              fillColor: theme.colorScheme.onErrorContainer,
              onChanged: (value) {
                setState(() {
                  value;
                });
              },
            ),
          ),
          // Container(
          //   width:  double.maxFinite,
          //   margin: const EdgeInsets.symmetric(horizontal: 16),
          //   child: CategoryDropdown(
          //
          //     userCategories: userCategories,
          //     initialSelection: "Shopping", // Set initial selection if desired
          //   ),
          // ),
          SizedBox(height: 16.v),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.h),
            child: CustomTextFormField(
              onAmountChange: (value) => setState(() {


              }),
              controller: inputFieldController1,
              maxLines: 2,
              textStyle: CustomTextStyles.titleSmallGray700,
              hintText: "Description",
              hintStyle: CustomTextStyles.bodyLargeGray800,
              textInputAction: TextInputAction.done,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please fill the the description';
                }
                return null;
              },
            ),
          ),
          SizedBox(height: 20.v),
          InkWell(
            onTap: _selectDate,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.h),
              child: CustomDropDown(
                icon: CustomImageView(
                  imagePath:
                  ImageConstant.imgMagiconsGlyphArrowArrowdown2Black900,
                  height: 32.adaptSize,
                  width: 32.adaptSize,
                ),
                hintText: _selectedDate == null ? 'Select Date' : DateFormat('dd-MM-yyyy').format(_selectedDate!.toUtc()),
                hintStyle: _selectedDate != null ? CustomTextStyles.titleSmallGray700 : null,
                //items: dateDropdownItemList,
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
          ),
          SizedBox(height: 30.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(right: 15.h),
              decoration: AppDecoration.outlineGray100022.copyWith(
                borderRadius: BorderRadiusStyle.circleBorder17,
              ),
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

          saved ? null : onTapSave(context);
        },
      ),
    );
  }

  /// Navigates to the onboardingOnboardingThirteenScreen when the action is triggered.
  onTapSave(BuildContext context) async {
    if (_formKey.currentState!.validate() && selectedCategory.isNotEmpty && _selectedDate != null) {
      try {
        final String incomeDate = DateFormat('dd-MM-yyyy').format(_selectedDate!.toUtc());
        int amount = int.parse(howMuchController.text);

        await FirebaseFirestore.instance.collection('expenses').add({
          'userId': userId,
          'expenceAmount': amount,
          'expenceCategory': selectedCategory,
          'expenceDate': incomeDate,
          'expenceDescription': inputFieldController1.text,
        });
        setState(() {
          saved = true;
        });

        await AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'Done',
          desc: 'Expense saved successfully.',
          btnOkOnPress: () {},
          btnOkText: "Ok",
        ).show();
      } catch (e) {
        await AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Failed',
          desc: 'Failed to save expense. Please try again later.',
          btnCancelOnPress: () {},
          btnCancelText: "Ok",
        ).show();
      }
    }else {
      if(_selectedDate == null && inputFieldController1.text.isNotEmpty && howMuchController.text.isNotEmpty) {
        await AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Failed',
          desc: 'Please choose a date.',
          btnCancelOnPress: () {},
          btnCancelText: "Ok",
        ).show();
      }
      if(selectedCategory.isEmpty && inputFieldController1.text.isNotEmpty && howMuchController.text.isNotEmpty) {
        await AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Failed',
          desc: 'Please choose a category.',
          btnCancelOnPress: () {},
          btnCancelText: "Ok",
        ).show();
      }
    }
  }
}
