import 'package:flutter/material.dart';
import 'package:pfe_project/core/app_export.dart';
import 'package:pfe_project/theme/theme_helper.dart';

class CategoryDropdown extends StatefulWidget {
  final List<Map<String, dynamic>> userCategories;
  final String initialSelection; // Optional: Set an initial selected category

  const CategoryDropdown({Key? key, required this.userCategories, required this.initialSelection}) : super(key: key);

  @override
  State<CategoryDropdown> createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialSelection; // Set initial selection if provided
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(

      child: DropdownButton<String>(

        value: _selectedCategory,
        isExpanded: true, // Make the dropdown fill the available width
        icon: const Icon(Icons.keyboard_arrow_down,size: 32,),
        items: widget.userCategories.map((category) => _buildDropdownMenuItem(category)).toList(),
        onChanged: (String? newSelection) {
          setState(() {
            _selectedCategory = newSelection;
          });
        },
      ),
    );
  }


  DropdownMenuItem<String> _buildDropdownMenuItem(Map<String, dynamic> category) {
    return DropdownMenuItem<String>(

      value: category['categoryName'] as String,
      child: Container(

        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17.0),
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
        ),
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
              padding: const EdgeInsets.only(top: 2.0),
              child: Container(
                width : MediaQuery.sizeOf(context).width / 2,
                child: Text(
                  category['categoryName'] as String,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
