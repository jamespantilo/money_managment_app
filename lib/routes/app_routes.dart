import 'package:flutter/material.dart';
import 'package:pfe_project/presentation/categorie_page/categorie_page.dart';
import 'package:pfe_project/presentation/financial_report_detail_pie_expense_category_page/financial_report_detail_pie_expense_category_page.dart';
import 'package:pfe_project/presentation/homepage/homepage.dart';
import 'package:pfe_project/presentation/profile_page/profile_page.dart';
import '../presentation/onboarding_sign_up_verfication_screen/onboarding_sign_up_verfication_screen.dart';
import '../presentation/onboarding_reset_password_screen/onboarding_reset_password_screen.dart';
import '../presentation/onboarding_forgot_password_screen/onboarding_forgot_password_screen.dart';
import '../presentation/onboarding_setup_pin_two_screen/onboarding_setup_pin_two_screen.dart';
import '../presentation/onboarding_sign_up_screen/onboarding_sign_up_screen.dart';
import '../presentation/onboarding_login_screen/onboarding_login_screen.dart';
import '../presentation/onboarding_forgot_password_email_sent_screen/onboarding_forgot_password_email_sent_screen.dart';
import '../presentation/financial_report_detail_line_expense_transaction_tab_container_screen/financial_report_detail_line_expense_transaction_tab_container_screen.dart';
import '../presentation/notification_notification_screen/notification_notification_screen.dart';
import '../presentation/settings_settings_screen/settings_settings_screen.dart';
import '../presentation/menu_page_screen/menu_page_screen.dart';
import '../presentation/contact_screen/contact_screen.dart';
import '../presentation/add_categorie_screen/add_categorie_screen.dart';
import '../presentation/categorie_container_screen/categorie_container_screen.dart';
import '../presentation/expense_new_screen/expense_new_screen.dart';
import '../presentation/income_new_screen/income_new_screen.dart';
import '../presentation/app_navigation_screen/app_navigation_screen.dart';

class AppRoutes {
  static const String onboardingSignUpVerficationScreen =
      '/onboarding_sign_up_verfication_screen';

  static const String onboardingResetPasswordScreen =
      '/onboarding_reset_password_screen';

  static const String onboardingForgotPasswordScreen =
      '/onboarding_forgot_password_screen';

  static const String onboardingSetupPinTwoScreen =
      '/onboarding_setup_pin_two_screen';

  static const String onboardingOnboardingThreeScreen =
      '/onboarding_onboarding_three_screen';

  static const String onboardingSignUpScreen = '/onboarding_sign_up_screen';

  static const String onboardingLoginScreen = '/onboarding_login_screen';

  static const String onboardingForgotPasswordEmailSentScreen =
      '/onboarding_forgot_password_email_sent_screen';

  static const String financialReportDetailLineExpenseTransactionPage =
      '/financial_report_detail_line_expense_transaction_page';

  static const String
      financialReportDetailLineExpenseTransactionTabContainerScreen =
      '/financial_report_detail_line_expense_transaction_tab_container_screen';

  static const String financialReportDetailPieExpenseCategoryPage =
      '/financial_report_detail_pie_expense_category_page';

  static const String notificationNotificationScreen =
      '/notification_notification_screen';

  static const String settingsSettingsScreen = '/settings_settings_screen';

  static const String menuPageScreen = '/menu_page_screen';

  static const String profilePage = '/profile_page';

  static const String contactScreen = '/contact_screen';

  static const String addCategorieScreen = '/add_categorie_screen';

  static const String categoriePage = '/categorie_page';

  static const String categorieContainerScreen = '/categorie_container_screen';

  static const String homepage = '/homepage';

  static const String expenseNewScreen = '/expense_new_screen';

  static const String incomeNewScreen = '/income_new_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static Map<String, WidgetBuilder> routes = {
    onboardingSignUpVerficationScreen: (context) =>
        const OnboardingSignUpVerficationScreen(),
    onboardingResetPasswordScreen: (context) => OnboardingResetPasswordScreen(),
    onboardingForgotPasswordScreen: (context) =>
        OnboardingForgotPasswordScreen(),
    onboardingSetupPinTwoScreen: (context) =>
        const OnboardingSetupPinTwoScreen(),
    onboardingSignUpScreen: (context) => OnboardingSignUpScreen(),
    onboardingLoginScreen: (context) => OnboardingLoginScreen(),
    onboardingForgotPasswordEmailSentScreen: (context) =>
        const OnboardingForgotPasswordEmailSentScreen(),
    financialReportDetailLineExpenseTransactionTabContainerScreen: (context) =>
        const FinancialReportDetailLineExpenseTransactionTabContainerScreen(),
    notificationNotificationScreen: (context) =>
        const NotificationNotificationScreen(),
    settingsSettingsScreen: (context) => const SettingsSettingsScreen(),
    menuPageScreen: (context) => const MenuPageScreen(),
    contactScreen: (context) => ContactScreen(),
    addCategorieScreen: (context) => AddCategorieScreen(),
    categorieContainerScreen: (context) => CategorieContainerScreen(),
    homepage: (context) => const HomePage(),
    expenseNewScreen: (context) => ExpenseNewScreen(),
    incomeNewScreen: (context) => IncomeNewScreen(),
    appNavigationScreen: (context) => const AppNavigationScreen(),
    financialReportDetailPieExpenseCategoryPage: (context) =>
        const FinancialReportDetailPieExpenseCategoryPage(),
    categoriePage: (context) => const CategoriePage(),
    profilePage: (context) => ProfilePage(),
  };
}
