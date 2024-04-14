import 'package:flutter/material.dart';
import 'package:pfe_project/core/app_export.dart';

class OnboardingSetupPinTwoScreen extends StatefulWidget {
  const OnboardingSetupPinTwoScreen({super.key});

  @override
  State<OnboardingSetupPinTwoScreen> createState() =>
      _OnboardingSetupPinTwoScreenState();
}

class _OnboardingSetupPinTwoScreenState
    extends State<OnboardingSetupPinTwoScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(height: 5.v),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.h,
                    vertical: 15.v,
                  ),
                  decoration: AppDecoration.fillPrimary,
                  child: Column(
                    children: [
                      SizedBox(height: 55.v),
                      Text(
                        "Ok. Re type your PIN again.",
                        style: CustomTextStyles.titleMediumGray50,
                      ),
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 9.h,
                          right: 5.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "1",
                              style: theme.textTheme.displayMedium,
                            ),
                            const Spacer(
                              flex: 51,
                            ),
                            Text(
                              "2",
                              style: theme.textTheme.displayMedium,
                            ),
                            const Spacer(
                              flex: 48,
                            ),
                            Text(
                              "3",
                              style: theme.textTheme.displayMedium,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 31.v),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 3.h,
                          right: 6.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "4",
                              style: theme.textTheme.displayMedium,
                            ),
                            Text(
                              "5",
                              style: theme.textTheme.displayMedium,
                            ),
                            Text(
                              "6",
                              style: theme.textTheme.displayMedium,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.v),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "7",
                              style: theme.textTheme.displayMedium,
                            ),
                            Text(
                              "8",
                              style: theme.textTheme.displayMedium,
                            ),
                            Text(
                              "9",
                              style: theme.textTheme.displayMedium,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 31.v),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "0",
                              style: theme.textTheme.displayMedium,
                            ),
                            CustomImageView(
                              imagePath: ImageConstant.imgArrowLeft,
                              height: 28.v,
                              margin: EdgeInsets.only(
                                left: 96.h,
                                top: 15.v,
                                bottom: 14.v,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
