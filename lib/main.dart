import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pfe_project/presentation/homepage/homepage.dart';
import 'package:pfe_project/presentation/onboarding_login_screen/onboarding_login_screen.dart';
import 'package:pfe_project/presentation/set_profile/set_profile.dart';
import 'core/app_export.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedPref;

List<Map<String, dynamic>> userCategories = [
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

String userId = '';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();

bool getSetProfileValue() {
  if (sharedPref!.getInt('set_profile') != null) {
    if (sharedPref!.getInt('set_profile') != 0) {
      return true;
    }
    return false;
  }
  return false;
}
FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<void> getImagePath(String userId) async {
  try {
    QuerySnapshot querySnapshot = await _firestore
        .collection('user')
        .where('userId', isEqualTo: userId)
        .limit(1)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      var userData = querySnapshot.docs.first.data() as Map<String, dynamic>;
final imagePath = userData['photo_url'] as String;
      final username = userData['username'] as String;
      sharedPref!.setString('imagePath', imagePath) ;
      sharedPref!.setString('username', username) ;

    } else {
      return null; // User document not found
    }
  } catch (e) {
    print('Error fetching user profile: $e');
    return null; // Handle error fetching user profile
  }
}
List<Map<String, dynamic>> firestoreCategories = [];

Future<void> fetchAndMergeCategories() async {
  try {
    // Merge Firestore categories with existing categories

    firestoreCategories.forEach((firestoreCategory) {
      if (!userCategories.any((category) => category['categoryName'] == firestoreCategory['categoryName'])) {
        userCategories.add(firestoreCategory);
      }
    });


  } catch (e) {
    print('Error fetching and merging categories: $e');
  }
}



Future<void> fetchCategoriesByUserId() async {
  try {
    for(int i = 0; i < userCategories.length ; i++) {
      userCategories[i]['categoryColor'] = userCategories[i]['categoryColor'].value as int;
    }
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



  } catch (e) {
    print('Error fetching categories: $e');
  }
}

Future<void> _fetchCategoriesByUserId1() async {
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


  } catch (e) {
    print('Error fetching categories: $e');
  }
}

Future<void> _fetchAndMergeCategories1() async {
  try {
    // Merge Firestore categories with existing categories

    firestoreCategories.forEach((firestoreCategory) {
      if (!userCategories.any((category) => category['categoryName'] == firestoreCategory['categoryName'])) {
        userCategories.add(firestoreCategory);
      }
    });

  } catch (e) {
    print('Error fetching and merging categories: $e');
  }
}



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  sharedPref = await SharedPreferences.getInstance();
  sharedPref!.getInt('signin') ?? sharedPref!.setInt('signin', 0);
  sharedPref!.getBool('notification') ?? sharedPref!.setBool('notification', false);
  userId = sharedPref!.getString('userId') ?? '';
  userId.isNotEmpty ? getImagePath(userId) : null;
  await _fetchCategoriesByUserId1().then((_) async {
   await _fetchAndMergeCategories1().then((value) {

    });
  });

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  ///Please update theme as per your need if required.
  ThemeHelper().changeTheme('primary');
  runApp(const MyApp());
}

goToPage() {
  if (sharedPref!.getInt('signin') == 0) {
    return const OnboardingLoginScreen();
  } else if (sharedPref!.getInt('signin') != 0 && getSetProfileValue()) {
    return const HomePage();
  } else {
    return const SetProfilePage();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          theme: theme,
          debugShowCheckedModeBanner: false,
          routes: AppRoutes.routes,
          home: goToPage() ,
        );
      },
    );
  }
}
