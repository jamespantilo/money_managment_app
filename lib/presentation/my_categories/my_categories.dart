// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pfe_project/main.dart';

import '../../routes/app_routes.dart';

class MyCategoriesPage extends StatefulWidget {
  @override
  _MyCategoriesPageState createState() => _MyCategoriesPageState();
}

class _MyCategoriesPageState extends State<MyCategoriesPage> {
  final List<Map<String, dynamic>> categories = [
    {
      'categoryName': 'Clothing',
      'categoryImagePath': 'assets/categories/clothing.png',
      'categoryColor': Colors.red
    },
    {
      'categoryName': 'Gifts & Donations',
      'categoryImagePath': 'assets/categories/gift.png',
      'categoryColor': Colors.blue
    },
    {
      'categoryName': 'Health & Wellness',
      'categoryImagePath': 'assets/categories/health.png',
      'categoryColor': Colors.green
    },
    {
      'categoryName': 'Rent/Mortgage',
      'categoryImagePath': 'assets/categories/rent.png',
      'categoryColor': Colors.orange
    },
    {
      'categoryName': 'Debt & Loans',
      'categoryImagePath': 'assets/categories/debt.png',
      'categoryColor': Colors.yellow
    },
    {
      'categoryName': 'Donations',
      'categoryImagePath': 'assets/categories/donation.png',
      'categoryColor': Colors.purple
    },
    {
      'categoryName': 'Education',
      'categoryImagePath': 'assets/categories/education.png',
      'categoryColor': Colors.pink
    },
    {
      'categoryName': 'Electricity',
      'categoryImagePath': 'assets/categories/electricity.png',
      'categoryColor': Colors.teal
    },
    {
      'categoryName': 'Utilities',
      'categoryImagePath': 'assets/categories/expenses.png',
      'categoryColor': Colors.cyan
    },
    {
      'categoryName': 'Entertainment',
      'categoryImagePath': 'assets/categories/Entertainment.png',
      'categoryColor': Colors.amber
    },
    {
      'categoryName': 'Home maintenance/Repairs',
      'categoryImagePath': 'assets/categories/homemaintence.png',
      'categoryColor': Colors.indigo
    },
    {
      'categoryName': 'Insurance',
      'categoryImagePath': 'assets/categories/Insurance.png',
      'categoryColor': Colors.brown
    },
    {
      'categoryName': 'Internet',
      'categoryImagePath': 'assets/categories/internet.png',
      'categoryColor': Colors.lime
    },
    {
      'categoryName': 'Investments',
      'categoryImagePath': 'assets/categories/Investments.png',
      'categoryColor': Colors.deepOrange
    },
    {
      'categoryName': 'Pets & Pet Care',
      'categoryImagePath': 'assets/categories/pets.png',
      'categoryColor': Colors.deepPurple
    },
  ];

  List<bool> _selected = [];
  late String userId;
  List chosenCategories = [];
  bool loading = false;

  Future<void> _getCategoriesByUserId(String userId) async {
    try {
      // Query Firestore to retrieve categories based on userId
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('category')
          .where('userId', isEqualTo: userId)
          .get();

      // Return list of categories
      chosenCategories = querySnapshot.docs.map((doc) => doc.data()).toList();
      setState(() {});
    } catch (e) {
      print('Error getting categories: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    userId = sharedPref!.getString('userId')!;
    _getCategoriesByUserId(userId).then((_)  {
    // Initialize the _selected list with false for all categories
    _selected = List<bool>.generate(categories.length, (index) => false);
        _removeChosenCategories();
    });

  }

  Future<void> _removeChosenCategories() async {
    try {
      if (chosenCategories.isNotEmpty) {
        // Remove chosen categories from the list of available categories
        for (var chosenCategory in chosenCategories) {
          categories.removeWhere((category) =>
              category['categoryName'] == chosenCategory['categoryName']);
        }

        // Update UI to reflect changes
        setState(() {});
      }
    } catch (e) {
      print('Error removing chosen categories: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _saveSelectedCategories(context),
        child: const Icon(Icons.save),
      ),
      appBar: AppBar(
        title: const Text('My Categories'),
        centerTitle: true,
        leading: Container(),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          GridView.builder(
            itemCount: categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    // Toggle the selection status of the category
                    _selected[index] = !_selected[index];
                  });
                },
                child: Card(
                  elevation: 3,
                  color: _selected[index] ? Colors.grey[300] : Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        categories[index]['categoryImagePath'],
                        height: 100,
                        width: 100,
                        color: Colors.deepPurple,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        categories[index]['categoryName'],
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          loading ? const Center(child: CircularProgressIndicator(color: Colors.red,),) : const SizedBox()
        ],
      ),
    );
  }

  void _saveSelectedCategories(BuildContext context) async {
    setState(() {
      loading = true;
    });
    try {
      // Iterate over selected categories and save them to Firestore
      for (int i = 0; i < _selected.length; i++) {
        if (_selected[i]) {
          await FirebaseFirestore.instance.collection('category').add({
            'userId': userId,
            'categoryName': categories[i]['categoryName'],
            'categoryImagePath': categories[i]['categoryImagePath'],
            'categoryColor': categories[i]['categoryColor'].value as int,
          });
        }
      }
      setState(() {
        loading = false;
      });
      await fetchCategoriesByUserId().then((_) async {
        await fetchAndMergeCategories();
      });
      await AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.rightSlide,
        title: 'Done',
        desc: 'Selected categories saved successfully.',
        btnOkOnPress: () {},
        btnOkText: "Ok",
      ).show();
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, AppRoutes.categoriePage);
    } catch (e) {
      setState(() {
        loading = false;
      });
      await AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Failed',
        desc: 'Failed to save selected categories. Please try again later.',
        btnCancelOnPress: () {},
        btnCancelText: "Ok",
      ).show();
    }
  }
}
