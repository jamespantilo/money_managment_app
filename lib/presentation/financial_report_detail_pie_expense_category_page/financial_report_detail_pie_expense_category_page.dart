import 'package:intl/intl.dart';
import 'package:pfe_project/presentation/homepage/homepage.dart';
import 'package:pfe_project/widgets/custom_drop_down.dart';
import 'package:pfe_project/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:pfe_project/core/app_export.dart';
import 'package:pfe_project/widgets/home_page_drop_down.dart';
import 'package:pie_chart/pie_chart.dart';


// Class to represent category information
class CategoryInfo {
  final String name;
  final Color color;
  final double percentage;
  final int totalAmount;

  CategoryInfo({required this.name, required this.color, required this.percentage, required this.totalAmount});
}




// ignore_for_file: must_be_immutable
class FinancialReportDetailPieExpenseCategoryPage extends StatefulWidget {
  const FinancialReportDetailPieExpenseCategoryPage({Key? key, required this.dataMap, required this.incomes, required this.expenses,})
      : super(
          key: key,
        );
  final Map<String, int> dataMap;
  final List<Income> incomes;
  final List<Expense> expenses;

  @override
  FinancialReportDetailPieExpenseCategoryPageState createState() =>
      FinancialReportDetailPieExpenseCategoryPageState();
}

class FinancialReportDetailPieExpenseCategoryPageState
    extends State<FinancialReportDetailPieExpenseCategoryPage>
    with
        AutomaticKeepAliveClientMixin<
            FinancialReportDetailPieExpenseCategoryPage> {

  List<String> monthDropdownItemList = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  bool changeButton = false;

  bool changeChartButton = false;
  String selectedMonth = DateFormat.MMMM().format(DateTime(2020, DateTime.now().month));
  List<Income> filterdIncomes = [];
  List<Expense> filterdExpenses = [];


  // Define a function to calculate total amount for each category
  Map<String, int> calculateIncomesTotalAmountPerCategory(List<Income> incomesList) {
    Map<String, int> totalIncomeAmountPerCategory = {};
    for (Income income in incomesList) {
      totalIncomeAmountPerCategory[income.incomeCategory] ??= 0;
      totalIncomeAmountPerCategory[income.incomeCategory] = totalIncomeAmountPerCategory[income.incomeCategory]! + income.incomeAmount;
    }
    return totalIncomeAmountPerCategory;
  }

  Map<String, int> calculateExpensesTotalAmountPerCategory(List<Expense> expenseList) {
    Map<String, int> totalExpenseAmountPerCategory = {};
    for (Expense expense in expenseList) {
      totalExpenseAmountPerCategory[expense.expenceCategory] ??= 0;
      totalExpenseAmountPerCategory[expense.expenceCategory] = totalExpenseAmountPerCategory[expense.expenceCategory]! + expense.expenceAmount;
    }
    return totalExpenseAmountPerCategory;
  }

  //====================Filter Data========================================================
  Future<void> _filterIncomeData() async{
    try {
      if (widget.incomes.isNotEmpty) {
        filterdIncomes = widget.incomes.where((income) {
          final selectedMonthIndex = DateTime.parse(income.incomeDate.toString()).month;
          final selectedMonthName = DateFormat.MMMM().format(DateTime(2020, selectedMonthIndex));
          return selectedMonthName == selectedMonth;
        }).toList();

        // Update UI to reflect changes
        setState(() {});
      }
    } catch (e) {
      print('Error removing chosen categories: $e');
    }
  }

  Future<void> _filterExpenseData() async{
    try {
      if (widget.expenses.isNotEmpty) {
        filterdExpenses = widget.expenses.where((expense) {
          final selectedMonthIndex = DateTime.parse(expense.expenceDate.toString()).month;
          final selectedMonthName = DateFormat.MMMM().format(DateTime(2020, selectedMonthIndex));
          return selectedMonthName == selectedMonth;
        }).toList();

        // Update UI to reflect changes
        setState(() {});
      }
    } catch (e) {
      print('Error removing chosen categories: $e');
    }
  }
  //========================================================================================


  Map<String, double> _calculatePercentage(Map<String, int> totalAmountPerCategory) {
    int totalAmount = totalAmountPerCategory.values.reduce((a, b) => a + b);
    return totalAmountPerCategory.map((category, amount) => MapEntry(category, amount / totalAmount));
  }

  List<Color> _generateColors(List<String> categories) {
    return List.generate(categories.length, (index) => _generateColor(index, categories.length));
  }

  Color _generateColor(int index, int totalCategories) {
    double hue = (360 / totalCategories) * index;
    return HSLColor.fromAHSL(1, hue, 0.7, 0.6).toColor();
  }
  List<CategoryInfo> categoryInfo = [];


  // Helper method to get the name, color, and percentage of each category
  List<CategoryInfo> getCategoryInfo() {
    Map<String, int> incomeDashMap = calculateIncomesTotalAmountPerCategory(filterdIncomes);
    Map<String, int> expenseDashMap = calculateExpensesTotalAmountPerCategory(filterdExpenses);
    if(incomeDashMap.isEmpty && changeButton) {
      return [];
    }else if(expenseDashMap.isEmpty && !changeButton) {
      return [];
    }
    else {
      if(incomeDashMap.isNotEmpty && changeButton) {
        List<String> categories =
        incomeDashMap.keys.toList();

        List<double> percentages = _calculatePercentage(incomeDashMap).values.toList();
        List<Color> colors = _generateColors(categories);

        List<CategoryInfo> categoryInfoList = [];
        for (int i = 0; i < categories.length; i++) {
          categoryInfoList.add(CategoryInfo(
            name: categories[i],
            color: colors[i],
            percentage: percentages[i],
            totalAmount : incomeDashMap[categories[i]]!,
          ));
        }
        return categoryInfoList;
      }else {
        List<String> categories = expenseDashMap.keys.toList();
        List<double> percentages = _calculatePercentage(expenseDashMap).values.toList();
        List<Color> colors = _generateColors(categories);

        List<CategoryInfo> categoryInfoList = [];
        for (int i = 0; i < categories.length; i++) {
          categoryInfoList.add(CategoryInfo(
            name: categories[i],
            color: colors[i],
            percentage: percentages[i],
            totalAmount : expenseDashMap[categories[i]]!,
          ));
        }
        return categoryInfoList;
      }
    }


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filterdExpenses = widget.expenses;
    filterdIncomes = widget.incomes;
    _filterIncomeData().then((_) {
      _filterExpenseData().then((__) {
        categoryInfo = getCategoryInfo();
      });
    });
  }




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
                    child: HomePageDropDrown(
                      onMonthChoose: (value) => setState(() {
                        selectedMonth = value;
                        _filterIncomeData().then((_) {
                          _filterExpenseData().then((__) {
                            categoryInfo = getCategoryInfo();
                          });
                        });
                      }),
                      width: 160.h,
                      prefix: Container(
                        margin: EdgeInsets.fromLTRB(8.h, 8.v, 4.h, 8.v),
                        child: CustomImageView(
                          imagePath:
                          ImageConstant.imgMagiconsGlyphArrowArrowdown2,
                          height: 24.adaptSize,
                          width: 24.adaptSize,
                        ),
                      ),

                      hintText: selectedMonth,
                      items: monthDropdownItemList,
                      filled: true,
                      fillColor: theme.colorScheme.onErrorContainer,
                    ),
                  ),

                ],
              ),
              const SizedBox(height: 20),
              SizedBox(height: MediaQuery.sizeOf(context).height / 2 - 250,child:
              categoryInfo.isEmpty ? const Center(child: Text('No data found'),) :
              PieChart(
                dataMap:changeButton ? _calculatePercentage(calculateIncomesTotalAmountPerCategory(filterdIncomes)) : _calculatePercentage(calculateExpensesTotalAmountPerCategory(filterdExpenses)),
                animationDuration: const Duration(milliseconds: 800),
                chartLegendSpacing: 32,
                chartRadius: MediaQuery.of(context).size.width / 2.7,
                colorList: _generateColors(widget.dataMap.keys.toList()),
                legendOptions: const LegendOptions(
                  legendPosition: LegendPosition.right,
                  showLegends: true,
                  legendTextStyle: TextStyle(fontSize: 12),
                ),
                chartType: ChartType.disc,
              ),),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12,bottom: 15),
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
                              categoryInfo = getCategoryInfo();
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
                              categoryInfo = getCategoryInfo();
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
                   SizedBox(
                     height: MediaQuery.sizeOf(context).height / 2,
                     width: double.maxFinite,
                     child:categoryInfo.isEmpty ? const Center(child: Text('No categories found'),) :
                     ListView.separated(
                       shrinkWrap: true,
                       separatorBuilder: (context, index) {
                         return SizedBox(
                           height: 1.v,
                         );
                       },
                       itemCount: categoryInfo.length,
                       itemBuilder: (context, index) {

                         return  Padding(
                           padding: EdgeInsets.symmetric(horizontal: 16.h,vertical: 8.v),
                           child: Column(
                             children: [
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Container(
                                     width: 180.h,
                                     padding: EdgeInsets.symmetric(vertical: 6.v),
                                     decoration: AppDecoration.outlineGray.copyWith(
                                       borderRadius:
                                       BorderRadiusStyle.circleBorder17,
                                     ),
                                     child: Row(
                                       // mainAxisAlignment:
                                       // MainAxisAlignment.spaceAround,
                                       children: [
                                         Container(
                                           height: 14.adaptSize,
                                           width: 14.adaptSize,
                                           margin:
                                           EdgeInsets.symmetric(vertical: 2.v,horizontal: 14),
                                           decoration: BoxDecoration(
                                             color: categoryInfo[index].color,
                                             borderRadius: BorderRadius.circular(
                                               7.h,
                                             ),
                                           ),
                                         ),
                                         Padding(
                                           padding: EdgeInsets.only(top: 2.v),
                                           child: Text(
                                             categoryInfo[index].name,
                                             style: theme.textTheme.titleSmall,
                                           ),
                                         ),
                                       ],
                                     ),
                                   ),
                                   Padding(
                                     padding: EdgeInsets.only(bottom: 2.v),
                                     child: Text(
                                       "${changeButton ? "+" : "-"}${categoryInfo[index].totalAmount} DH",
                                       style:  TextStyle(color: changeButton ? Colors.green : Colors.red ,fontSize: 24),
                                     ),
                                   ),
                                 ],
                               ),
                               SizedBox(height: 8.v),
                               Container(
                                 height: 16,
                                 margin: const EdgeInsets.all(8.0),
                                 child: LinearProgressIndicator(
                                   borderRadius: BorderRadius.circular(20),
                                   value: categoryInfo[index].percentage, // Update progress value
                                   valueColor:  AlwaysStoppedAnimation(categoryInfo[index].color),
                                 ),
                               ),
                             ],
                           ),
                         );
                       },
                     ),),
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
