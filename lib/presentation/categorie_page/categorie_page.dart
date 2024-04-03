import 'package:pfe_project/widgets/app_bar/custom_app_bar.dart';
import 'package:pfe_project/widgets/app_bar/appbar_leading_image.dart';
import 'package:pfe_project/widgets/app_bar/appbar_subtitle.dart';
import 'package:pfe_project/widgets/custom_elevated_button.dart';
import 'widgets/categorie_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:pfe_project/core/app_export.dart'; // ignore_for_file: must_be_immutable

class CategoriePage extends StatelessWidget {
  const CategoriePage({Key? key})
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
            horizontal: 18.h,
            vertical: 11.v,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomElevatedButton(
                height: 44.v,
                width: 165.h,
                text: "Ajouter Categorie",
                margin: EdgeInsets.only(left: 1.h),
                buttonStyle: CustomButtonStyles.fillPrimaryTL22,
                buttonTextStyle: CustomTextStyles.titleSmallOnErrorContainer,
                onPressed: () {
                  onTapAjouterCategorie(context);
                },
              ),
              SizedBox(height: 22.v),
              _buildCategorie(context),
              SizedBox(height: 97.v)
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 52.v,
      leadingWidth: 54.h,
      leading: AppbarLeadingImage(
        onTap: () {
          Navigator.pop(context);
        },
        imagePath: ImageConstant.imgMagiconsGlyphPrimary,
        margin: EdgeInsets.only(
          left: 22.h,
          top: 4.v,
          bottom: 16.v,
        ),
      ),
      centerTitle: true,
      title: AppbarSubtitle(
        text: "Categorie",
      ),
      styleType: Style.bgFill,
    );
  }

  /// Section Widget
  Widget _buildCategorie(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 1.h),
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 15.v,
          );
        },
        itemCount: 5,
        itemBuilder: (context, index) {
          return CategorieItemWidget();
        },
      ),
    );
  }

  /// Navigates to the addCategorieScreen when the action is triggered.
  onTapAjouterCategorie(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.addCategorieScreen);
  }
}
