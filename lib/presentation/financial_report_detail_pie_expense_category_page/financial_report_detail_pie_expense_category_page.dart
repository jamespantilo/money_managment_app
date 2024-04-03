import 'package:pfe_project/widgets/custom_drop_down.dart';
import 'package:pfe_project/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:pfe_project/core/app_export.dart';

// ignore_for_file: must_be_immutable
class FinancialReportDetailPieExpenseCategoryPage extends StatefulWidget {
  const FinancialReportDetailPieExpenseCategoryPage({Key? key})
      : super(
          key: key,
        );

  @override
  FinancialReportDetailPieExpenseCategoryPageState createState() =>
      FinancialReportDetailPieExpenseCategoryPageState();
}

class FinancialReportDetailPieExpenseCategoryPageState
    extends State<FinancialReportDetailPieExpenseCategoryPage>
    with
        AutomaticKeepAliveClientMixin<
            FinancialReportDetailPieExpenseCategoryPage> {
  List<String> dropdownItemList = [
    "Gategory 1",
    "Gategory 2",
    "Gategory 3",
  ];

  List<String> monthDropdownItemList = [
    "April",
    "Mai",
    "December",
  ];

  bool changeButton = false;

  bool changeChartButton = false;

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.fillOnErrorContainer,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.h,
                      vertical: 11.v,
                    ),
                    decoration: AppDecoration.fillOnErrorContainer,
                    child: CustomDropDown(
                      width: MediaQuery.sizeOf(context).width.h / 3,
                      hintText: "Month",
                      items: monthDropdownItemList,
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
                  Padding(
                    padding: const EdgeInsets.only(right: 14),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              changeChartButton = false;
                            });
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            color: changeChartButton
                                ? Colors.white
                                : Colors.deepPurple,
                            child: Icon(
                              Icons.show_chart_outlined,
                              color: !changeChartButton
                                  ? Colors.white
                                  : Colors.deepPurple,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              changeChartButton = true;
                            });
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            color: changeChartButton
                                ? Colors.deepPurple
                                : Colors.white,
                            child: Icon(
                              Icons.pie_chart,
                              color: changeChartButton
                                  ? Colors.white
                                  : Colors.deepPurple,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              changeChartButton
                  ? Image.asset(
                      'assets/images/chart1.png',
                      width: 200,
                      height: 200,
                      fit: BoxFit.fill,
                    )
                  : Image.asset(
                      'assets/images/chart2.png',
                      width: MediaQuery.sizeOf(context).width,
                      height: 200,
                      fit: BoxFit.fill,
                    ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: Container(
                  margin: const EdgeInsets.all(4),
                  padding: const EdgeInsets.all(6),
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(50)),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              changeButton = false;
                            });
                          },
                          child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: !changeButton
                                    ? Colors.deepPurple
                                    : Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(
                              'Expense',
                              style: TextStyle(
                                  color: changeButton
                                      ? Colors.black
                                      : Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              changeButton = true;
                            });
                          },
                          child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: changeButton
                                    ? Colors.deepPurple
                                    : Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(
                              'Income',
                              style: TextStyle(
                                  color: changeButton
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8.v),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.h),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.h,
                        vertical: 11.v,
                      ),
                      decoration: AppDecoration.fillOnErrorContainer,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomDropDown(
                            width: MediaQuery.sizeOf(context).width.h / 3 ,
                            hintText: "Category",
                            items: dropdownItemList,
                            prefix: Container(
                              margin: EdgeInsets.fromLTRB(8.h, 8.v, 4.h, 8.v),
                              child: CustomImageView(
                                imagePath: ImageConstant
                                    .imgMagiconsGlyphArrowArrowdown2,
                                height: 24.adaptSize,
                                width: 24.adaptSize,
                              ),
                            ),
                            prefixConstraints: BoxConstraints(
                              maxHeight: 40.v,
                            ),
                          ),
                          CustomIconButton(
                            height: 40.adaptSize,
                            width: 40.adaptSize,
                            padding: EdgeInsets.all(4.h),
                            decoration: IconButtonStyleHelper.outlineGray,
                            child: CustomImageView(
                              imagePath: ImageConstant.imgMagiconsGlyphUser,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.v),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.h),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 105.h,
                                padding: EdgeInsets.symmetric(vertical: 6.v),
                                decoration: AppDecoration.outlineGray.copyWith(
                                  borderRadius:
                                      BorderRadiusStyle.circleBorder17,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height: 14.adaptSize,
                                      width: 14.adaptSize,
                                      margin:
                                          EdgeInsets.symmetric(vertical: 2.v),
                                      decoration: BoxDecoration(
                                        color: appTheme.amberA700,
                                        borderRadius: BorderRadius.circular(
                                          7.h,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 2.v),
                                      child: Text(
                                        "Shopping",
                                        style: theme.textTheme.titleSmall,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 2.v),
                                child: Text(
                                  "- 120 DH",
                                  style: theme.textTheme.headlineSmall,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.v),
                          CustomImageView(
                            imagePath: ImageConstant.imgProgressBar,
                            height: 18.v,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 21.v),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 119.h,
                            padding: EdgeInsets.symmetric(vertical: 6.v),
                            decoration: AppDecoration.outlineGray.copyWith(
                              borderRadius: BorderRadiusStyle.circleBorder17,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 14.adaptSize,
                                  width: 14.adaptSize,
                                  margin: EdgeInsets.symmetric(vertical: 2.v),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primary,
                                    borderRadius: BorderRadius.circular(
                                      7.h,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 2.v),
                                  child: Text(
                                    "Subcription",
                                    style: theme.textTheme.titleSmall,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 2.v),
                            child: Text(
                              "- 80 DH",
                              style: theme.textTheme.headlineSmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.v),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 16.h,
                          right: 48.h,
                        ),
                        child: Container(
                          height: 12.v,
                          width: 311.h,
                          decoration: BoxDecoration(
                            color: appTheme.gray10002,
                          ),
                          child: ClipRRect(
                            child: LinearProgressIndicator(
                              value: 0.5,
                              backgroundColor: appTheme.gray10002,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                theme.colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.v),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.h),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 75.h,
                                padding: EdgeInsets.symmetric(vertical: 7.v),
                                decoration: AppDecoration.outlineGray.copyWith(
                                  borderRadius:
                                      BorderRadiusStyle.circleBorder17,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height: 14.adaptSize,
                                      width: 14.adaptSize,
                                      margin:
                                          EdgeInsets.symmetric(vertical: 1.v),
                                      decoration: BoxDecoration(
                                        color: theme.colorScheme.onError,
                                        borderRadius: BorderRadius.circular(
                                          7.h,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Food",
                                      style: theme.textTheme.titleSmall,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 2.v),
                                child: Text(
                                  "- 32 DH",
                                  style: theme.textTheme.headlineSmall,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.v),
                          CustomImageView(
                            imagePath: ImageConstant.imgProgressBarGray10002,
                            height: 18.v,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
