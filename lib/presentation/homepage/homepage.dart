import 'package:pfe_project/presentation/categorie_page/categorie_page.dart';
import 'package:pfe_project/presentation/profile_page/profile_page.dart';
import 'package:pfe_project/widgets/app_bar/custom_app_bar.dart';
import 'package:pfe_project/widgets/custom_text_form_field.dart';
import 'package:pfe_project/widgets/custom_elevated_button.dart';
import 'package:pfe_project/widgets/custom_icon_button.dart';
import 'package:pfe_project/widgets/home_page_drop_down.dart';
import 'widgets/onboardingonboardingfifteen_item_widget.dart';
import 'package:pfe_project/widgets/custom_bottom_app_bar.dart';
import 'package:pfe_project/widgets/custom_floating_button.dart';
import 'package:flutter/material.dart';
import 'package:pfe_project/core/app_export.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> dropdownItemList = ["November", "December", "April"];

  TextEditingController monthController = TextEditingController();

  TextEditingController barsController = TextEditingController();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  bool clickedAddButton = false;

  String fTap = 't';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: Column(
            children: [
              _buildMonth(context),
              Column(
                children: [
                  SizedBox(height: 12.v),
                  _buildBars(context),
                  SizedBox(height: 11.v),
                  _buildTabs(context),
                  SizedBox(height: 7.v),
                  _buildSeeAll(context)
                ],
              ),
              SizedBox(height: 5.v)
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomNavigation(context),
        floatingActionButton: CustomFloatingButton(
          height: 53,
          width: 58,
          onTap: () {
            setState(() {
              clickedAddButton
                  ? clickedAddButton = false
                  : clickedAddButton = true;
            });
          },
          child: CustomImageView(
            imagePath: ImageConstant.imgPlus,
            height: 26.5.v,
            width: 29.0.h,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  /// Section Widget
  Widget _buildMonth(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: MediaQuery.sizeOf(context).height / 3.5,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgFrame5,
            height: 15.v,
            alignment: Alignment.topLeft,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 7.v),
              decoration: AppDecoration.outlineBlueGray.copyWith(
                borderRadius: BorderRadiusStyle.customBorderBL32,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomAppBar(
                    backgroundColor: Colors.transparent,
                    height: 40.v,
                    leadingWidth: 48.h,
                    leading: Container(
                      height: 32.adaptSize,
                      width: 32.adaptSize,
                      margin: EdgeInsets.only(
                        left: 16.h,
                        top: 4.v,
                        bottom: 4.v,
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.menuPageScreen);
                            },
                            child: Container(
                              height: 32.adaptSize,
                              width: 32.adaptSize,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.red, width: 2),
                                  borderRadius: BorderRadius.circular(50)),
                              child: CustomImageView(
                                radius: BorderRadius.circular(50),
                                imagePath: ImageConstant.myImg,
                                height: 32.adaptSize,
                                width: 32.adaptSize,
                                alignment: Alignment.centerLeft,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    centerTitle: true,
                    title: SizedBox(
                      height: 40.v,
                      width: 150.h,
                      child: HomePageDropDrown(
                        width: 150.h,
                        prefix: Container(
                          margin: EdgeInsets.fromLTRB(8.h, 8.v, 4.h, 8.v),
                          child: CustomImageView(
                            imagePath:
                                ImageConstant.imgMagiconsGlyphArrowArrowdown2,
                            height: 24.adaptSize,
                            width: 24.adaptSize,
                          ),
                        ),
                        hintText: "Octorber",
                        items: dropdownItemList,
                        filled: true,
                        fillColor: theme.colorScheme.onErrorContainer,
                      ),
                    ),
                    actions: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context,
                              AppRoutes.notificationNotificationScreen);
                        },
                        child: Container(
                          height: 33.5.v,
                          width: 36.130005.h,
                          margin: EdgeInsets.fromLTRB(12.h, 2.v, 12.h, 4.v),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CustomImageView(
                                imagePath:
                                    ImageConstant.imgMagiconsGlyphEcommerce,
                                height: 32.adaptSize,
                                width: 32.adaptSize,
                                alignment: Alignment.centerRight,
                                margin: EdgeInsets.only(
                                  top: 1.v,
                                  right: 4.h,
                                ),
                              ),
                              CustomImageView(
                                imagePath:
                                    ImageConstant.imgMagiconsGlyphEcommerce,
                                height: 32.adaptSize,
                                width: 32.adaptSize,
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(
                                  top: 1.v,
                                  right: 4.h,
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 18.h,
                                  height: 18.h,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Text(
                                    "2",
                                    textAlign: TextAlign.center,
                                    style: CustomTextStyles
                                        .labelLargeOnErrorContainer,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10.v),
                  Text(
                    "Account Balance",
                    style: CustomTextStyles.titleSmallGray600,
                  ),
                  SizedBox(height: 8.v),
                  Text(
                    "9400 DH",
                    style: CustomTextStyles.displayMediumPrimaryContainer,
                  ),
                  SizedBox(height: 22.v),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(right: 8.h),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.h,
                              vertical: 14.v,
                            ),
                            decoration: AppDecoration.fillTeal.copyWith(
                              borderRadius: BorderRadiusStyle.roundedBorder28,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 46.v,
                                  width: 49.h,
                                  margin: EdgeInsets.only(top: 1.v),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.h,
                                    vertical: 7.v,
                                  ),
                                  decoration: AppDecoration.fillGray.copyWith(
                                    borderRadius:
                                        BorderRadiusStyle.circleBorder17,
                                  ),
                                  child: CustomImageView(
                                    imagePath: ImageConstant.imgUser,
                                    height: 32.adaptSize,
                                    width: 32.adaptSize,
                                    alignment: Alignment.center,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 1.v,
                                    right: 7.h,
                                    bottom: 5.v,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Income",
                                        style:
                                            CustomTextStyles.titleSmallGray50,
                                      ),
                                      SizedBox(height: 1.v),
                                      Text(
                                        "5000 DH",
                                        style: CustomTextStyles
                                            .titleMediumGray50SemiBold,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 8.h),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.h,
                              vertical: 14.v,
                            ),
                            decoration: AppDecoration.fillOnError.copyWith(
                              borderRadius: BorderRadiusStyle.roundedBorder28,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 46.v,
                                  width: 49.h,
                                  margin: EdgeInsets.only(top: 1.v),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.h,
                                    vertical: 7.v,
                                  ),
                                  decoration: AppDecoration.fillGray.copyWith(
                                    borderRadius:
                                        BorderRadiusStyle.circleBorder17,
                                  ),
                                  child: CustomImageView(
                                    imagePath: ImageConstant.imgUserRed500,
                                    height: 32.adaptSize,
                                    width: 32.adaptSize,
                                    alignment: Alignment.center,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 8.h,
                                    top: 4.v,
                                    bottom: 5.v,
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Expenses",
                                        style:
                                            CustomTextStyles.titleSmallGray50,
                                      ),
                                      Text(
                                        "1200 DH",
                                        style: CustomTextStyles
                                            .titleMediumGray50SemiBold,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildBars(BuildContext context) {
    return CustomTextFormField(
      controller: barsController,
      hintText: "Frequency",
      textInputAction: TextInputAction.done,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 12.v,
      ),
      borderDecoration: TextFormFieldStyleHelper.fillOnErrorContainer,
    );
  }

  /// Section Widget
  Widget _buildToday(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () {
        setState(() {
          fTap = 't';
        });
      },
      height: 34.v,
      width: 90.h,
      text: "Today",
      buttonStyle: fTap == 't'
          ? CustomButtonStyles.fillDeepPurple
          : CustomButtonStyles.none,
      buttonTextStyle: fTap == 't'
          ? CustomTextStyles.titleSmallPrimary
          : CustomTextStyles.bodyLargeGray800,
      alignment: Alignment.centerLeft,
    );
  }

  Widget _buildWeek(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () {
        setState(() {
          fTap = 'w';
        });
      },
      height: 34.v,
      width: 90.h,
      text: "Week",
      buttonStyle: fTap == 'w'
          ? CustomButtonStyles.fillDeepPurple
          : CustomButtonStyles.none,
      buttonTextStyle: fTap == 'w'
          ? CustomTextStyles.titleSmallPrimary
          : CustomTextStyles.bodyLargeGray800,
      alignment: Alignment.centerLeft,
    );
  }

  Widget _buildmonth(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () {
        setState(() {
          fTap = 'm';
        });
      },
      height: 34.v,
      width: 90.h,
      text: "Month",
      buttonStyle: fTap == 'm'
          ? CustomButtonStyles.fillDeepPurple
          : CustomButtonStyles.none,
      buttonTextStyle: fTap == 'm'
          ? CustomTextStyles.titleSmallPrimary
          : CustomTextStyles.bodyLargeGray800,
      alignment: Alignment.centerLeft,
    );
  }

  /// Section Widget
  Widget _buildTabs(BuildContext context) {
    return SizedBox(
      height: 34.v,
      width: MediaQuery.sizeOf(context).width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildToday(context),
          _buildWeek(context),
          _buildmonth(context)
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildSeeAll(BuildContext context) {
    return SizedBox(
      height: 343.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 1.v,
                );
              },
              itemCount: 18,
              itemBuilder: (context, index) {
                return const OnboardingonboardingfifteenItemWidget();
              },
            ),
          ),
          clickedAddButton
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 3.v),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomIconButton(
                          height: 56.adaptSize,
                          width: 56.adaptSize,
                          padding: EdgeInsets.all(12.h),
                          decoration: IconButtonStyleHelper.fillTeal,
                          onTap: () {
                            onTapBtnUser(context);
                          },
                          child: CustomImageView(
                            imagePath: ImageConstant.imgUserGray50,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 58.h),
                          child: CustomIconButton(
                            height: 56.adaptSize,
                            width: 56.adaptSize,
                            padding: EdgeInsets.all(12.h),
                            decoration: IconButtonStyleHelper.fillOnError,
                            onTap: () {
                              onTapBtnUser1(context);
                            },
                            child: CustomImageView(
                              imagePath: ImageConstant.imgUserGray5056x56,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildBottomNavigation(BuildContext context) {
    return CustomBottomAppBar(
      onChanged: (BottomBarEnum type) {
        Navigator.pushNamed(context, getCurrentRoute(type));
      },
    );
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.homepage;
      case BottomBarEnum.Categories:
        return AppRoutes.categoriePage;
      case BottomBarEnum.Chart:
        return AppRoutes.financialReportDetailPieExpenseCategoryPage;
      case BottomBarEnum.Profile:
        return AppRoutes.profilePage;
      default:
        return AppRoutes.homepage;
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.categoriePage:
        return const CategoriePage();
      case AppRoutes.profilePage:
        return ProfilePage();
      default:
        return const DefaultWidget();
    }
  }

  /// Navigates to the incomeNewScreen when the action is triggered.
  onTapBtnUser(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.incomeNewScreen);
  }

  /// Navigates to the expenseNewScreen when the action is triggered.
  onTapBtnUser1(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.expenseNewScreen);
  }
}
