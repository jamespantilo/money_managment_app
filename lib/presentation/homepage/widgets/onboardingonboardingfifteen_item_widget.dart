import 'package:intl/intl.dart';
import 'package:pfe_project/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:pfe_project/core/app_export.dart';
import 'package:pfe_project/widgets/custom_icon_button.dart';
import 'package:pfe_project/widgets/image_type/image_type.dart';

// ignore: must_be_immutable
class OnboardingonboardingfifteenItemWidget extends StatelessWidget {
  const OnboardingonboardingfifteenItemWidget({Key? key, required this.imagePath, required this.categoryName, required this.description, required this.amount, required this.isIncome, required this.date})
      : super(
          key: key,
        );
  final String imagePath;
  final String categoryName;
  final String description;
  final int amount;
  final bool isIncome ;
  final DateTime date ;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child:Container(
        padding: EdgeInsets.symmetric(
          horizontal: 17.h,
          vertical: 4.v,
        ),
        decoration: AppDecoration.fillGray.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder24,
        ),
        child: Container(
          decoration: BoxDecoration(color: Colors.grey.shade100,borderRadius: BorderRadius.circular(25)),
          padding: const EdgeInsets.all(24.0),
          width: MediaQuery.sizeOf(context).width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          Row(
            //mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomIconButton(
            height: 60.adaptSize,
            width: 60.adaptSize,
            padding: EdgeInsets.all(10.h),
            child: ImageTypeView(
              imagePath: imagePath,
              imageType: "asset",
              color: Colors.deepPurple,
            ),
          ), Column(
                  mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Text(
                  categoryName,style: const TextStyle(fontSize: 24),),
              ),
              const SizedBox(height: 8,),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Text(description.length > 20 ? "${description.substring(0, 20)}..." :
                description,style: const TextStyle(color: Colors.grey,fontSize: 20),),
              )
            ],)
          ],),
              Column(children: [
                Text(isIncome ? '+$amount' : '-$amount',style:  TextStyle(color: isIncome ? Colors.green : Colors.red,fontSize: 24),),const SizedBox(height: 8,),
                 Text(DateFormat('d MMMM y').format(date))
              ],),
          ]),)

      ),
    );
  }

  /// Section Widget
  Widget _buildSeeAll(BuildContext context) {
    return CustomElevatedButton(
      height: 32.v,
      width: 78.h,
      text: "See All",
      buttonStyle: CustomButtonStyles.fillDeepPurple,
      buttonTextStyle: CustomTextStyles.titleSmallPrimary_1,
    );
  }
}

