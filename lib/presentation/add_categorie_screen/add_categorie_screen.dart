import 'package:pfe_project/widgets/app_bar/custom_app_bar.dart';
import 'package:pfe_project/widgets/app_bar/appbar_leading_image.dart';
import 'package:pfe_project/widgets/app_bar/appbar_subtitle.dart';
import 'package:pfe_project/widgets/custom_text_form_field.dart';
import 'package:pfe_project/widgets/custom_drop_down.dart';
import 'package:pfe_project/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:pfe_project/core/app_export.dart';

class AddCategorieScreen extends StatefulWidget {
  const AddCategorieScreen({super.key});

  @override
  State<AddCategorieScreen> createState() => _AddCategorieScreenState();
}

class _AddCategorieScreenState extends State<AddCategorieScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController inputFieldController = TextEditingController();

  List<String> dropdownItemList = ["Type 1", "Type 2", "Type 3"];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                        controller: nameController,
                        hintText: "categorie name",
                        textStyle: const TextStyle(
                          color: Colors.black,
                        ),
                        hintStyle: const TextStyle(color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: 24.v),

                    SizedBox(height: 24.v),
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
                        hintText: "Type",
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
                    SizedBox(height: 5.v)
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: _buildAdd(context),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 48.h,
      leading: AppbarLeadingImage(
        onTap: () {
          Navigator.pop(context);
        },
        imagePath: ImageConstant.imgMagiconsGlyphPrimary,
        margin: EdgeInsets.only(
          left: 16.h,
          top: 13.v,
          bottom: 16.v,
        ),
      ),
      centerTitle: true,
      title: AppbarSubtitle(
        text: "Add categorie",
      ),
      styleType: Style.bgFill,
    );
  }

  /// Section Widget
  Widget _buildAdd(BuildContext context) {
    return CustomElevatedButton(
      text: "Add",
      margin: EdgeInsets.only(
        left: 22.h,
        right: 25.h,
        bottom: 79.v,
      ),
      onPressed: () {
        onTapAdd(context);
      },
    );
  }

  /// Navigates to the categorieContainerScreen when the action is triggered.
  onTapAdd(BuildContext context) {
   Navigator.pop(context);

  }
}
