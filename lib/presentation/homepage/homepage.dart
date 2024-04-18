import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:pfe_project/main.dart';
import 'package:pfe_project/presentation/categorie_page/categorie_page.dart';
import 'package:pfe_project/presentation/profile_page/profile_page.dart';
import 'package:pfe_project/widgets/app_bar/custom_app_bar.dart';
import 'package:pfe_project/widgets/custom_elevated_button.dart';
import 'package:pfe_project/widgets/custom_icon_button.dart';
import 'package:pfe_project/widgets/home_page_drop_down.dart';
import '../financial_report_detail_pie_expense_category_page/financial_report_detail_pie_expense_category_page.dart';
import 'widgets/onboardingonboardingfifteen_item_widget.dart';
import 'package:pfe_project/widgets/custom_bottom_app_bar.dart';
import 'package:pfe_project/widgets/custom_floating_button.dart';
import 'package:flutter/material.dart';
import 'package:pfe_project/core/app_export.dart';

class Income {
  final String userId;
  final int incomeAmount;
  final String incomeCategory;
  final DateTime incomeDate;
  final String incomeDescription;

  Income({
    required this.userId,
    required this.incomeAmount,
    required this.incomeCategory,
    required this.incomeDate,
    required this.incomeDescription,
  });
}

class Expense {
  final String userId;
  final int expenceAmount;
  final String expenceCategory;
  final DateTime expenceDate;
  final String expenceDescription;

  Expense({
    required this.userId,
    required this.expenceAmount,
    required this.expenceCategory,
    required this.expenceDate,
    required this.expenceDescription,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.isLogin});

  final bool? isLogin;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> dropdownItemList = [
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

  TextEditingController monthController = TextEditingController();

  TextEditingController barsController = TextEditingController();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  bool clickedAddButton = false;
  int totalIncome = 0;
  int totalExpense = 0;
  int acountBalance = 0;
  String selectedMonth = DateFormat.MMMM().format(DateTime(2020, DateTime.now().month));
  String fTap = 'y';
  List<Income> incomes = [];
  List<Map<String, dynamic>> initIncomes = [];
  List<Income> filterdIncomes = [];
  List<Expense> expenses = [];
  List<Map<String, dynamic>> initExpenses = [];
  List<Expense> filterdExpenses = [];
  List<dynamic> combinedList = [];
  bool loading= false;

  String _getImagePath(String categoryName) {
    for(var item in userCategories) {
      if( categoryName == item['categoryName']){
        return item['categoryImagePath'];
      }

    }
    return ImageConstant.imageNotFound;

  }

  List<Income> parseIncomes(List<Map<String, dynamic>> jsonList) {
    List<Income> parsedList = [];
    for (var json in jsonList) {
      DateTime incomeDate = DateFormat("dd-MM-yyyy").parse(json['incomeDate'] as String, true);
      Income incomeMap = Income(
        userId: json['userId'] as String,
        incomeAmount: json['incomeAmount'] as int,
        incomeCategory: json['incomeCategory'] as String,
        incomeDate: incomeDate,
        incomeDescription: json['incomeDescription'] as String,
      );
      parsedList.add(incomeMap);
    }
    return parsedList;
  }
  List<Expense> parseExpenses(List<Map<String, dynamic>> jsonList) {
    List<Expense> parsedList = [];
    for (var json in jsonList) {
      DateTime expensesDate = DateFormat("dd-MM-yyyy").parse(json['expenceDate'] as String, true);
      Expense incomeMap = Expense(
        userId: json['userId'] as String,
        expenceAmount: json['expenceAmount'] as int,
        expenceCategory: json['expenceCategory'] as String,
        expenceDate: expensesDate,
        expenceDescription: json['expenceDescription'] as String,
      );
      parsedList.add(incomeMap);
    }
    return parsedList;
  }




  Future<void> _getIncomeData() async {
    try {
      // Query Firestore to retrieve categories based on userId
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('incomes')
          .where('userId', isEqualTo: userId)
          .get();

      // Return list of categories
      initIncomes = querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic> ).toList();
      setState(() {});

    } catch (e) {
      print('Error getting categories: $e');
    }
  }

  Future<void> _getExpenseData() async {
    try {
      // Query Firestore to retrieve categories based on userId
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('expenses')
          .where('userId', isEqualTo: userId)
          .get();

      // Return list of categories
      initExpenses = querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic> ).toList();
      setState(() {});
    } catch (e) {
      print('Error getting expenses: $e');
    }
  }


  Future<void> _filterIncomeData() async{
    try {
      if (incomes.isNotEmpty) {
        filterdIncomes = incomes.where((income) {
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
      if (expenses.isNotEmpty) {
        filterdExpenses = expenses.where((expense) {
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

  Future<void> _initIncome() async {
    incomes = parseIncomes(initIncomes);
  }

  Future<void> _initExpense() async {
    expenses = parseExpenses(initExpenses);
  }

  void _initVariables() {
    int incomeTotal = 0;
    int expenseTotal = 0;
    for( var values in filterdIncomes) {
      incomeTotal = values.incomeAmount + incomeTotal;
    }
    for( var expenseValues in filterdExpenses) {
      expenseTotal = expenseValues.expenceAmount + expenseTotal;
    }
    totalIncome = incomeTotal;
    totalExpense = expenseTotal;
    acountBalance = totalIncome - totalExpense;
    setState(() {

    });
  }

  Future<void> _combineLists() async{
    combinedList.addAll(incomes);

    combinedList.addAll(expenses);

    combinedList.sort((a, b) {
      DateTime? dateA, dateB;


      if (a is Income) {
        dateA = a.incomeDate;
      } else if (a is Expense) {
        dateA = a.expenceDate;
      }


      if (b is Income) {
        dateB = b.incomeDate;
      } else if (b is Expense) {
        dateB = b.expenceDate;
      }

      return dateA!.compareTo(dateB!);
    });
    setState(() {

    });


  }
    Future<List<dynamic>> getItemsForDay(DateTime day, List<dynamic> combinedList2) async{
      // Format the day to match the format of the incomeDate and expenceDate
      String formattedDay = DateFormat('yyyy-MM-dd').format(day);

      // Filter the combinedList based on the formatted day
      return combinedList2.where((item) {
        if (item is Income) {
          return DateFormat('yyyy-MM-dd').format(item.incomeDate) ==
              formattedDay;
        } else if (item is Expense) {
          return DateFormat('yyyy-MM-dd').format(item.expenceDate) ==
              formattedDay;
        }
        return false;
      }).toList();
    }

  Future<void> _usegae() async{
      DateTime selectedDay = DateTime.now(); // Change this to the selected day
      combinedList = await getItemsForDay(
          selectedDay, combinedList);

      setState(() {

      });
    }

  List<dynamic> getItemsForLast7Days(List<dynamic> combinedList3) {
    // Get the date 7 days ago from today
    DateTime startDate = DateTime.now().subtract(const Duration(days: 6));

    // Filter the combinedList based on the date range for the last 7 days
    return combinedList3.where((item) {
      if (item is Income) {
        return item.incomeDate.isAfter(startDate);
      } else if (item is Expense) {
        return item.expenceDate.isAfter(startDate);
      }
      return false;
    }).toList();
  }

  Future<void> _usergae2() async{
    combinedList = getItemsForLast7Days(combinedList);
    setState(() {

    });
    
  }

  // Define a function to filter the combinedList for the current month
  List<dynamic> getItemsForCurrentMonth(List<dynamic> combinedList4) {
    // Get the first day of the current month
    DateTime startDate = DateTime(DateTime.now().year, DateTime.now().month, 1);

    // Get the first day of the next month
    DateTime endDate = DateTime(DateTime.now().year, DateTime.now().month + 1, 1);

    // Filter the combinedList based on the date range for the current month
    return combinedList4.where((item) {
      if (item is Income) {
        return item.incomeDate.isAfter(startDate) && item.incomeDate.isBefore(endDate);
      } else if (item is Expense) {
        return item.expenceDate.isAfter(startDate) && item.expenceDate.isBefore(endDate);
      }
      return false;
    }).toList();
  }

  Future<void> _usergae3() async {
    combinedList = getItemsForCurrentMonth(combinedList);
    
    setState(() {

    });
    
  }

  // Define a function to calculate total amount for each category
  Map<String, int> calculateTotalAmountPerCategory(List<Income> incomesList) {
    Map<String, int> totalAmountPerCategory = {};
    for (Income income in incomesList) {
      totalAmountPerCategory[income.incomeCategory] ??= 0;
      totalAmountPerCategory[income.incomeCategory] = totalAmountPerCategory[income.incomeCategory]! + income.incomeAmount;
    }
    return totalAmountPerCategory;
  }

void displayTotalAmount() {
  // Calculate total amount for each category
  Map<String, int> totalAmountPerCategory = calculateTotalAmountPerCategory(incomes);

// Print the total amount for each category
  totalAmountPerCategory.forEach((category, amount) {
    print('============Category: $category, Total Amount: $amount===============');
  });
}


  Future<void> _fetchAndMergeCategories() async {
    try {
      // Merge Firestore categories with existing categories

      firestoreCategories.forEach((firestoreCategory) {
        if (!categories.any((category) => category['categoryName'] == firestoreCategory['categoryName'])) {
          categories.add(firestoreCategory);
        }
      });

      // Update UI with merged categories
      setState(() {
        loading = false;
      });
    } catch (e) {
      print('Error fetching and merging categories: $e');
    }
  }



  Future<void> _fetchCategoriesByUserId() async {
    try {
      // Query Firestore to retrieve categories
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('category')
          .where('userId', isEqualTo: userId)
          .get();

      querySnapshot.docs.forEach((doc) {
        //print(doc.data() as Map<String, dynamic>);
        // Extract data from each document and add it to the list
        firestoreCategories.add(doc.data() as Map<String, dynamic>);

      });

      setState(() {

      });

    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  List<Map<String, dynamic>> categories = [
    {
      "categoryName": "Shopping",
      "categoryImagePath": "assets/images/shopping.png",
      'categoryColor': Colors.black.value as int
    },
    {
      "categoryName": "Subscription",
      "categoryImagePath": "assets/images/subscription.png",
      'categoryColor': Colors.white.value as int
    },
    {
      "categoryName": "Food",
      "categoryImagePath": "assets/images/food.png",
      'categoryColor': Colors.grey.value as int
    },
    {
      "categoryName": "Traveling",
      "categoryImagePath": "assets/images/travelling.png",
      'categoryColor': Colors.lightBlue.value as int
    },
    {
      "categoryName": "Transportation",
      "categoryImagePath": "assets/images/transport.png",
      'categoryColor': Colors.lightGreen.value as int
    }
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userId = sharedPref!.getString('userId')!;
    _fetchCategoriesByUserId().then((_) {
      _fetchAndMergeCategories().then((value) {
        userCategories = categories;
      });
    });
    _getIncomeData().then((_) {
      _initIncome().then((__) {
        _filterIncomeData().then((___) {
          _getExpenseData().then((___________) {
            _initExpense().then((_____________) {
              _filterExpenseData().then((______________) {
                _initVariables();
                _combineLists().then((_____) {
                  loading = true;
                  displayTotalAmount();

                });
              });
            });
          });
        });
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: loading ? SizedBox(
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

                  _buildSeeAll(context),
                ],
              ),

              SizedBox(height: 5.v)
            ],
          ),
        ) : const Center(child: CircularProgressIndicator(color: Colors.red,),),
        bottomNavigationBar: _buildBottomNavigation(context),
        floatingActionButton: CustomFloatingButton(
          height: 53,
          width: 58,
          backgroundColor: theme.colorScheme.primary,
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
                                imagePath: sharedPref!.getString('imagePath'),
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
                      width: 160.h,
                      child: HomePageDropDrown(
                        onMonthChoose: (value) => setState(() {
                          selectedMonth = value;
                          _filterIncomeData().then((_) {
                            _filterExpenseData().then((__) {
                              _initVariables();
                            });
                          });
                        }),
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

                        hintText: selectedMonth,
                        items: dropdownItemList,
                        filled: true,
                        fillColor: theme.colorScheme.onErrorContainer,
                      ),
                    ),
                    actions: [
                      InkWell(
                        onTap: () {
                          sharedPref!.setBool('notification', true);
                          setState(() {

                          });
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
                              sharedPref!.getBool('notification')! ? const SizedBox() : Align(
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
                              ),
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
                    "$acountBalance DH",
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
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // crossAxisAlignment: CrossAxisAlignment.start,
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
                                    left: 8.h,
                                    top: 4.v,
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
                                        "$totalIncome DH",
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
                                        "$totalExpense DH",
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
    return  const Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 30,top: 16, bottom: 8),
          child: Text('Spend Frequency',style: TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.bold),),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildToday(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () async {
        combinedList.clear();
        await _combineLists();
        await _usegae();
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
      onPressed: () async {
        combinedList.clear();
        await _combineLists();
        await _usergae2();
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
      onPressed: () async {
        combinedList.clear();
        await _combineLists();
        await _usergae3();
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

  Widget _buildyear(BuildContext context) {
    return CustomElevatedButton(

      onPressed: () async {
        combinedList.clear();
        await _combineLists();
        setState(() {
          fTap = 'y';
        });
      },
      height: 34.v,
      width: 90.h,
      text: "Year",
      buttonStyle: fTap == 'y'
          ? CustomButtonStyles.fillDeepPurple
          : CustomButtonStyles.none,
      buttonTextStyle: fTap == 'y'
          ? CustomTextStyles.titleSmallPrimary
          : CustomTextStyles.bodyLargeGray800,
      alignment: Alignment.centerLeft,
    );
  }

  Widget _recents() {
    return Container(

      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 11.v,
      ),
      decoration: AppDecoration.fillOnErrorContainer,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 14,top: 0, bottom: 0),
            child: Text(
              "Recents",
              style: CustomTextStyles.titleMediumSemiBold,
            ),
          )
        ],

      ),
    );
  }

  /// Section Widget
  Widget _buildTabs(BuildContext context) {
    return SizedBox(

      width: MediaQuery.sizeOf(context).width,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildToday(context),
              _buildWeek(context),
              _buildmonth(context),
              _buildyear(context)
            ],
          ),
          const SizedBox(height: 8,),
          _recents(),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildSeeAll(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height / 3 - 10,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: combinedList.isEmpty ? const Center(child: Text('No transaction found',style: TextStyle(fontSize: 20),),) : ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 1.v,
                );
              },
              itemCount: combinedList.length,
              itemBuilder: (context, index) {
                final item = combinedList[index];
                return  OnboardingonboardingfifteenItemWidget(
                  date: item is Income ? item.incomeDate : item.expenceDate,
                  categoryName: item is Income ? item.incomeCategory : item.expenceCategory,
                  imagePath: item is Income ? _getImagePath(item.incomeCategory) : _getImagePath(item.expenceCategory),
                  amount: item is Income ? item.incomeAmount : item.expenceAmount,
                  description:item is Income ? item.incomeDescription : item.expenceDescription,
                  isIncome: item is Income ? true : false,

                );
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
        type == BottomBarEnum.Chart ?
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            FinancialReportDetailPieExpenseCategoryPage(
                dataMap: calculateTotalAmountPerCategory(incomes),
            expenses: expenses,incomes: incomes,),))
            : type == BottomBarEnum.Home ? Navigator.pushReplacementNamed(context, getCurrentRoute(type)) : Navigator.pushNamed(context, getCurrentRoute(type));

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
        return const ProfilePage();
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
