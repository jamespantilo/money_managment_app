import 'package:pfe_project/widgets/app_bar/custom_app_bar.dart';
import 'package:pfe_project/widgets/app_bar/appbar_leading_image.dart';
import 'package:pfe_project/widgets/app_bar/appbar_subtitle.dart';
import 'package:pfe_project/widgets/custom_drop_down.dart';
import 'package:pfe_project/widgets/custom_icon_button.dart';
import 'package:pfe_project/presentation/financial_report_detail_pie_expense_category_page/financial_report_detail_pie_expense_category_page.dart';
import 'package:pfe_project/presentation/financial_report_detail_line_expense_transaction_page/financial_report_detail_line_expense_transaction_page.dart';
import 'package:flutter/material.dart';
import 'package:pfe_project/core/app_export.dart';

class FinancialReportDetailLineExpenseTransactionTabContainerScreen
    extends StatefulWidget {
  const FinancialReportDetailLineExpenseTransactionTabContainerScreen(
      {Key? key})
      : super(
          key: key,
        );

  @override
  FinancialReportDetailLineExpenseTransactionTabContainerScreenState
      createState() =>
          FinancialReportDetailLineExpenseTransactionTabContainerScreenState();
}

class FinancialReportDetailLineExpenseTransactionTabContainerScreenState
    extends State<FinancialReportDetailLineExpenseTransactionTabContainerScreen>
    with TickerProviderStateMixin {
  List<String> dropdownItemList = [
    "Item One",
    "Item Two",
    "Item Three",
  ];

  late TabController tabviewController;

  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              _buildFinancialReport(context),
              SizedBox(height: 9.v),
              _buildTabview(context),
              _buildTabBarView(context),
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
        imagePath: ImageConstant.imgMagiconsGlyphPrimary,
        margin: EdgeInsets.only(
          left: 22.h,
          top: 4.v,
          bottom: 16.v,
        ),
      ),
      centerTitle: true,
      title: AppbarSubtitle(
        text: "Financial Report",
      ),
      styleType: Style.bgFill,
    );
  }

  /// Section Widget
  Widget _buildFinancialReport(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 7.h,
        vertical: 8.v,
      ),
      decoration: AppDecoration.fillOnErrorContainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(right: 1.h),
            padding: EdgeInsets.symmetric(
              horizontal: 14.h,
              vertical: 8.v,
            ),
            decoration: AppDecoration.fillOnErrorContainer,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.v),
                  child: CustomDropDown(
                    width: 96.h,
                    hintText: "Month",
                    items: dropdownItemList,
                    prefix: Container(
                      margin: EdgeInsets.fromLTRB(8.h, 8.v, 4.h, 8.v),
                      child: CustomImageView(
                        imagePath:
                            ImageConstant.imgMagiconsGlyphArrowArrowdown2,
                        height: 24.adaptSize,
                        width: 24.adaptSize,
                      ),
                    ),
                    prefixConstraints: BoxConstraints(
                      maxHeight: 40.v,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomIconButton(
                      height: 48.adaptSize,
                      width: 48.adaptSize,
                      padding: EdgeInsets.all(8.h),
                      decoration: IconButtonStyleHelper.outlinePrimary,
                      child: CustomImageView(
                        imagePath: ImageConstant.imgSearch,
                      ),
                    ),
                    CustomIconButton(
                      height: 48.adaptSize,
                      width: 48.adaptSize,
                      padding: EdgeInsets.all(8.h),
                      decoration: IconButtonStyleHelper.outlineGrayLR8,
                      child: CustomImageView(
                        imagePath: ImageConstant.imgMagiconsGlyphPrimary48x48,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 7.v),
          Padding(
            padding: EdgeInsets.only(left: 23.h),
            child: Text(
              " 332 DH",
              style: CustomTextStyles.headlineLargeBlack900,
            ),
          ),
          SizedBox(height: 19.v),
          CustomImageView(
            imagePath: ImageConstant.imgGroup214,
            height: 169.v,
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildTabview(BuildContext context) {
    return Container(
      height: 56.v,
      width: 342.h,
      decoration: BoxDecoration(
        color: appTheme.gray10002,
        borderRadius: BorderRadius.circular(
          28.h,
        ),
      ),
      child: TabBar(
        controller: tabviewController,
        labelPadding: EdgeInsets.zero,
        labelColor: appTheme.black900,
        unselectedLabelColor: appTheme.gray50,
        tabs: const [
          Tab(
            child: Text(
              "Expense",
            ),
          ),
          Tab(
            child: Text(
              "Income",
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildTabBarView(BuildContext context) {
    return SizedBox(
      height: 368.v,
      child: TabBarView(
        controller: tabviewController,
        children: const [
          FinancialReportDetailPieExpenseCategoryPage(dataMap: {},expenses: [],incomes: []),
          FinancialReportDetailLineExpenseTransactionPage(),
        ],
      ),
    );
  }
}
