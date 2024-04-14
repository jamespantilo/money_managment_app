import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pfe_project/core/app_export.dart';
import 'package:pfe_project/main.dart';
import 'package:pfe_project/presentation/income_new_screen/income_new_screen.dart';
import 'package:pfe_project/theme/theme_helper.dart';


class CategoryCustomDropDown extends StatefulWidget {
  const CategoryCustomDropDown({super.key, this.alignment, this.width, this.focusNode, this.icon, this.autofocus, this.textStyle, this.items, this.hintText, this.hintStyle, this.prefix, this.prefixConstraints, this.suffix, this.suffixConstraints, this.contentPadding, this.borderDecoration, this.fillColor, this.filled, this.validator, this.onChanged, required this.onCategorySelected});
  final Alignment? alignment;

  final double? width;

  final FocusNode? focusNode;

  final Widget? icon;

  final bool? autofocus;

  final TextStyle? textStyle;

  final List<String>? items;

  final String? hintText;

  final TextStyle? hintStyle;

  final Widget? prefix;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final EdgeInsets? contentPadding;

  final InputBorder? borderDecoration;

  final Color? fillColor;

  final bool? filled;

  final FormFieldValidator<String>? validator;

  final Function(String)? onChanged;

  final Function(String) onCategorySelected;

  @override
  State<CategoryCustomDropDown> createState() => _CategoryCustomDropDownState();
}

class _CategoryCustomDropDownState extends State<CategoryCustomDropDown> {



  @override
  Widget build(BuildContext context) {
    return widget.alignment != null
        ? Align(
      alignment: widget.alignment ?? Alignment.center,
      child: dropDownWidget,
    )
        : dropDownWidget;
  }


  DropdownMenuItem<String> _buildDropdownMenuItem(Map<String, dynamic> category) {
    return DropdownMenuItem<String>(
      value: category['categoryName'] as String,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 14.0,
            width: 14.0,
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(vertical: 2.0),
            decoration: BoxDecoration(
              color: Color(category['categoryColor']),//Color(int.parse(category['categoryName']))
              borderRadius: BorderRadius.circular(7.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2.0,left: 8),
            child: SizedBox(
              width : 300,
              child: Text(
                category['categoryName'] as String,

              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget get dropDownWidget => SizedBox(
    width: widget.width ?? double.maxFinite,
    child: DropdownButtonFormField(
      focusNode: widget.focusNode,
      icon: widget.icon,
      autofocus: widget.autofocus ?? false,
      style: widget.textStyle ?? theme.textTheme.titleSmall,
      items:userCategories.map((category) => _buildDropdownMenuItem(category)).toList(),
      decoration: decoration,
      validator: widget.validator,
      onChanged: (value) {
        if (value != null) {
          // Call the provided callback function with the selected value
          widget.onCategorySelected(value);
        }
      },
    ),
  );
  InputDecoration get decoration => InputDecoration(
    hintText: widget.hintText ?? "",
    hintStyle: widget.hintStyle ?? theme.textTheme.bodyLarge,
    prefixIcon: widget.prefix,
    prefixIconConstraints: widget.prefixConstraints,
    suffixIcon: widget.suffix,
    suffixIconConstraints: widget.suffixConstraints,
    isDense: true,
    contentPadding: widget.contentPadding ??
        EdgeInsets.only(
          top: 11.v,
          right: 11.h,
          bottom: 11.v,
        ),
    fillColor: widget.fillColor,
    filled: widget.filled,
    border: widget.borderDecoration ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.h),
          borderSide: BorderSide(
            color: appTheme.gray10002,
            width: 1,
          ),
        ),
    enabledBorder: widget.borderDecoration ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.h),
          borderSide: BorderSide(
            color: appTheme.deepPurpleA700,
            width: 1,
          ),
        ),
    focusedBorder: widget.borderDecoration ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.h),
          borderSide: BorderSide(
            color: appTheme.gray10002,
            width: 1,
          ),
        ),
  );
  
}



/// Extension on [CategoryCustomDropDown] to facilitate inclusion of all types of border style etc
extension DropDownStyleHelper1 on CategoryCustomDropDown {
  static OutlineInputBorder get outlineGrayTL16 => OutlineInputBorder(
    borderRadius: BorderRadius.circular(16.h),
    borderSide: BorderSide(
      color: appTheme.gray10002,
      width: 1,
    ),
  );
}
