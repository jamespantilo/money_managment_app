import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pfe_project/main.dart';
import 'package:pfe_project/widgets/app_bar/custom_app_bar.dart';
import 'package:pfe_project/widgets/app_bar/appbar_leading_image.dart';
import 'package:pfe_project/widgets/app_bar/appbar_subtitle.dart';
import 'package:pfe_project/widgets/custom_elevated_button.dart';
import 'widgets/categorie_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:pfe_project/core/app_export.dart'; // ignore_for_file: must_be_immutable

class CategoriePage extends StatefulWidget {
  const CategoriePage({super.key});

  @override
  State<CategoriePage> createState() => _CategoriePageState();
}

class _CategoriePageState extends State<CategoriePage> {
  late String userId;
  bool loading = true;
  List<Map<String, dynamic>> firestoreCategories = [];
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
    super.initState();
    userId = sharedPref!.getString('userId')!;
    _fetchCategoriesByUserId().then((_) {
      _fetchAndMergeCategories().then((value) {
        userCategories = categories;
      });
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: loading ? const Center(child: CircularProgressIndicator(color: Colors.red,)) : Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 18.h,
            vertical: 11.v,
          ),
          child: Stack(
            children: [

              SingleChildScrollView(
                physics: PageScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 44.v,
                      width: 165.h,
                      margin: EdgeInsets.only(left: 1.h),
                    ),
                    SizedBox(height: 22.v),
                    _buildCategorie(context),
                    SizedBox(height: 97.v)
                  ],
                ),
              ),
              Stack(
                children: [
                  Container(color: Colors.white,width: double.infinity,height: 70.h,),
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
                ],
              ),
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
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 15.v,
          );
        },
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return CategorieItemWidget(
            categoryName: categories[index]["categoryName"],
            iconPath: categories[index]["categoryImagePath"],
            imageType: 'asset',
          );
        },
      ),
    );
  }

  /// Navigates to the addCategorieScreen when the action is triggered.
  onTapAjouterCategorie(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.mycategories);

  }
}
