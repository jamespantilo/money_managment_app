import 'package:pfe_project/presentation/categorie_page/categorie_page.dart';
import 'package:pfe_project/presentation/profile_page/profile_page.dart';
import 'package:pfe_project/widgets/custom_bottom_app_bar.dart';
import 'package:pfe_project/widgets/custom_floating_button.dart';
import 'package:flutter/material.dart';
import 'package:pfe_project/core/app_export.dart';

// ignore_for_file: must_be_immutable
class CategorieContainerScreen extends StatelessWidget {
  CategorieContainerScreen({Key? key})
      : super(
          key: key,
        );

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.fillOnErrorContainer,
          child: Column(
            children: [
              Navigator(
                key: navigatorKey,
                initialRoute: AppRoutes.categoriePage,
                onGenerateRoute: (routeSetting) => PageRouteBuilder(
                  pageBuilder: (ctx, ani, ani1) =>
                      getCurrentPage(routeSetting.name!),
                  transitionDuration: const Duration(seconds: 0),
                ),
              ),
              SizedBox(height: 5.v)
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomNavigation(context),
        floatingActionButton: CustomFloatingButton(
          height: 53,
          width: 58,
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
  Widget _buildBottomNavigation(BuildContext context) {
    return CustomBottomAppBar(
      onChanged: (BottomBarEnum type) {
        Navigator.pushNamed(
            navigatorKey.currentContext!, getCurrentRoute(type));
      },
    );
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.categoriePage;
      case BottomBarEnum.Categories:
        return "/";
      case BottomBarEnum.Chart:
        return "/";
      case BottomBarEnum.Profile:
        return AppRoutes.profilePage;
      default:
        return "/";
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
}
