import 'package:flutter/material.dart';
import 'package:pfe_project/core/app_export.dart';

class AppNavigationScreen extends StatelessWidget {
  const AppNavigationScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0XFFFFFFFF),
        body: SizedBox(
          width: 375.h,
          child: Column(
            children: [
              _buildAppNavigation(context),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0XFFFFFFFF),
                    ),
                    child: Column(
                      children: [
                        _buildScreenTitle(
                          context,
                          screenTitle: "Onboarding / Sign Up - Verfication",
                          onTapScreenTitle: () => onTapScreenTitle(context,
                              AppRoutes.onboardingSignUpVerficationScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Onboarding / Reset Password",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.onboardingResetPasswordScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Onboarding / Forgot Password",
                          onTapScreenTitle: () => onTapScreenTitle(context,
                              AppRoutes.onboardingForgotPasswordScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Onboarding / Setup Pin Two",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.onboardingSetupPinTwoScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Onboarding / Onboarding Three",
                          onTapScreenTitle: () => onTapScreenTitle(context,
                              AppRoutes.onboardingOnboardingThreeScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Onboarding / Sign Up",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.onboardingSignUpScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Onboarding / Login",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.onboardingLoginScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle:
                              "Onboarding / Forgot Password_Email Sent",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context,
                              AppRoutes
                                  .onboardingForgotPasswordEmailSentScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle:
                              "Financial Report / Detail / Line_Expense_Transaction - Tab Container",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context,
                              AppRoutes
                                  .financialReportDetailLineExpenseTransactionTabContainerScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Notification / Notification",
                          onTapScreenTitle: () => onTapScreenTitle(context,
                              AppRoutes.notificationNotificationScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Settings / Settings",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.settingsSettingsScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Menu Page",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.menuPageScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Contact",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.contactScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Add categorie",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.addCategorieScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "categorie - Container",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.categorieContainerScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Onboarding / Onboarding Fifteen",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(context, AppRoutes.homepage),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Expense / New",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.expenseNewScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Income / New",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.incomeNewScreen),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildAppNavigation(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0XFFFFFFFF),
      ),
      child: Column(
        children: [
          SizedBox(height: 10.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Text(
                "App Navigation",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0XFF000000),
                  fontSize: 20.fSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 20.h),
              child: Text(
                "Check your app's UI from the below demo presentation of your app.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0XFF888888),
                  fontSize: 16.fSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(height: 5.v),
          Divider(
            height: 1.v,
            thickness: 1.v,
            color: const Color(0XFF000000),
          ),
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildScreenTitle(
    BuildContext context, {
    required String screenTitle,
    Function? onTapScreenTitle,
  }) {
    return GestureDetector(
      onTap: () {
        onTapScreenTitle?.call();
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0XFFFFFFFF),
        ),
        child: Column(
          children: [
            SizedBox(height: 10.v),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Text(
                  screenTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0XFF000000),
                    fontSize: 20.fSize,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.v),
            SizedBox(height: 5.v),
            Divider(
              height: 1.v,
              thickness: 1.v,
              color: const Color(0XFF888888),
            ),
          ],
        ),
      ),
    );
  }

  /// Common click event
  void onTapScreenTitle(
    BuildContext context,
    String routeName,
  ) {
    Navigator.pushNamed(context, routeName);
  }
}
