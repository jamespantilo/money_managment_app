import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pfe_project/main.dart';
import 'package:pfe_project/widgets/custom_elevated_button.dart';
import 'package:pfe_project/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:pfe_project/core/app_export.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pfe_project/widgets/image_type/image_type.dart';
import 'dart:io';

import '../../widgets/custom_icon_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController pseudoNameController = TextEditingController();

  TextEditingController prenomController = TextEditingController();

  TextEditingController nomController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController telephoneController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  bool loading = false;
String documentId= '';
  bool enablePseudoName = false;
  bool enablePrenom = false;
  bool enableNom = false;
  bool enablePhoneNumber = false;
  bool enableEmail = false;
   String prenom ='';
   String nom ='';
   String imagePath ='';
   late String userId ;
  bool imageChanged = false;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    userId = sharedPref!.getString('userId')!;
    fetchData(userId);
  }

  Future<void> fetchData(String userId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('user')
          .where('userId', isEqualTo: userId)
          .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        var userData = querySnapshot.docs.first.data() as Map<String, dynamic>;
       pseudoNameController.text = userData['username'] as String;
        nomController.text = userData['name'] as String;
        prenomController.text = userData['familyName'] as String;
        telephoneController.text = userData['phoneNumber'];
        emailController.text = userData['email'] as String;
        imagePath = userData['photo_url'] as String;
        nom = userData['name'] as String;
        prenom = userData['familyName'] as String;
        setState(() {

        });
      } else {
        return null; // User document not found
      }
    } catch (e) {
      print('Error fetching user profile: $e');
      return null; // Handle error fetching user profile
    }
  }

  Future<void> _setImage() async {
    final file = await FilePicker.platform.pickFiles(type: FileType.image);
    if (file != null) {
      setState(() {
        imageChanged = true;
        imagePath = file.paths.first!;
      });
    }
  }

  Future<String?> _uploadImageToFirebaseStorage(File imageFile) async {
    try {
      // Create a reference to the location you want to upload to in Firebase Storage
      final Reference storageReference =
      FirebaseStorage.instance.ref().child('images').child(imageFile.path);

      // Upload the file to Firebase Storage
      final TaskSnapshot uploadTask = await storageReference.putFile(imageFile);

      // Get the download URL of the uploaded file
      final String downloadUrl = await uploadTask.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()  async{
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, AppRoutes.homepage);
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body:
        Stack(
          children: [

            SizedBox(
              width: SizeUtils.width,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Form(
                  key: _formKey,
                  child: Container(
                    width: double.maxFinite,
                    decoration: AppDecoration.fillOnErrorContainer,
                    child: Column(
                      children: [
                        _buildThirtyFour(context),
                        const Divider(),
                        SizedBox(height: 49.v),
                        _buildThirtySeven(context),
                        SizedBox(height: 14.v),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 36.h),
                            child: Text(
                              "Prénom",
                              style: CustomTextStyles.titleSmallGray700,
                            ),
                          ),
                        ),
                        _buildMohamed(context),
                        SizedBox(height: 15.v),
                        _buildThirtySix(context),
                        SizedBox(height: 16.v),
                        _buildThirtyThree(context),
                        SizedBox(height: 16.v),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 36.h),
                            child: Text(
                              "Adresse email",
                              style: CustomTextStyles.titleSmallGray700,
                            ),
                          ),
                        ),
                        SizedBox(height: 30.v),
                        _buildEmail(context),
                        SizedBox(height: 30.v),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: CustomElevatedButton(
                            height: 61.v,
                            text: "Save",
                            onPressed: () {
                              _saveToFirebase();
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            loading
                ? const Center(child: CircularProgressIndicator(color: Colors.red,)) : SizedBox(),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildThirtyFour(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 1.h),
      padding: EdgeInsets.symmetric(
        horizontal: 57.h,
        vertical: 22.v,
      ),
      decoration: AppDecoration.fillGray10001,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 115.adaptSize,
            width: 115.adaptSize,
            margin: EdgeInsets.only(bottom: 12.v),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                imageChanged ? ImageTypeView(
                  imagePath: imagePath,
                  height: 115.adaptSize,
                  width: 115.adaptSize,
                  radius: BorderRadius.circular(
                    57.h,
                  ),
                  alignment: Alignment.center,
                  imageType: 'file',
                ) : ImageTypeView(
                  imagePath: imagePath,
                  height: 115.adaptSize,
                  width: 115.adaptSize,
                  radius: BorderRadius.circular(
                    57.h,
                  ),
                  alignment: Alignment.center,
                  imageType: 'network',
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: 5.h,
                    bottom: 4.v,
                  ),
                  child: CustomIconButton(
                    onTap: () async {
                      await _setImage();
                    },
                    height: 22.adaptSize,
                    width: 22.adaptSize,
                    padding: EdgeInsets.all(2.h),
                    decoration: IconButtonStyleHelper.fillDeepPurpleA,
                    alignment: Alignment.bottomRight,
                    child: CustomImageView(
                      imagePath: ImageConstant.imgEdit1SvgrepoCom,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 14.v,
              right: 13.h,
              bottom: 26.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 121.h,
                  child: Text(
                    "$prenom\n$nom",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextStyles.headlineSmallBlack900,
                  ),
                ),
                SizedBox(height: 5.v),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildThirtySeven(BuildContext context) {
    return SizedBox(
      height: 66.v,
      width: 318.h,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          CustomTextFormField(
            width: 318.h,
            enable: enablePseudoName,
            textStyle: CustomTextStyles.titleSmallGray700,
            controller: pseudoNameController,
            hintText: "pseudo name",
            hintStyle: theme.textTheme.bodyLarge!,
            alignment: Alignment.bottomCenter,

            contentPadding: EdgeInsets.symmetric(
              horizontal: 30.h,
              vertical: 9.v,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please fill the pseudo name';
              }
              return null;
            },
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Pseudo",
              style: CustomTextStyles.titleSmallGray700,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 18.v,
              right: 4.h,
            ),
            child: CustomIconButton(
              onTap: () {
                setState(() {
                  enablePseudoName = true;
                });
              },
              height: 20.adaptSize,
              width: 20.adaptSize,
              padding: EdgeInsets.all(2.h),
              decoration: IconButtonStyleHelper.fillDeepPurpleA,
              alignment: Alignment.topRight,
              child: CustomImageView(
                imagePath: ImageConstant.imgEdit1SvgrepoCom,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildMohamed(BuildContext context) {
    return SizedBox(
      height: 48.v,
      width: 318.h,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          CustomTextFormField(
            width: 318.h,
            enable: enablePrenom,
            controller: prenomController,
            textStyle: CustomTextStyles.titleSmallGray700,
            hintText: "prenom",
            hintStyle: theme.textTheme.bodyLarge!,
            alignment: Alignment.bottomCenter,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 30.h,
              vertical: 9.v,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please fill the prenom';
              }
              return null;
            },
          ),
          Padding(
            padding: EdgeInsets.only(right: 4.h),
            child: CustomIconButton(
              onTap: () {
                setState(() {
                  enablePrenom = true;
                });
              },
              height: 20.adaptSize,
              width: 20.adaptSize,
              padding: EdgeInsets.all(2.h),
              decoration: IconButtonStyleHelper.fillDeepPurpleA,
              alignment: Alignment.topRight,
              child: CustomImageView(
                imagePath: ImageConstant.imgEdit1SvgrepoCom,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildThirtySix(BuildContext context) {
    return SizedBox(
      height: 66.v,
      width: 318.h,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          CustomTextFormField(
            width: 318.h,
            enable: enableNom,
            textStyle: CustomTextStyles.titleSmallGray700,
            controller: nomController,
            hintText: sharedPref!.getString('name') ?? 'nom',
            hintStyle: theme.textTheme.bodyLarge!,
            alignment: Alignment.bottomCenter,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 30.h,
              vertical: 9.v,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please fill the nom';
              }
              return null;
            },
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Nom",
              style: CustomTextStyles.titleSmallGray700,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 18.v,
              right: 4.h,
            ),
            child: CustomIconButton(
              onTap: () {
                setState(() {
                  enableNom = true;
                });
              },
              height: 20.adaptSize,
              width: 20.adaptSize,
              padding: EdgeInsets.all(2.h),
              decoration: IconButtonStyleHelper.fillDeepPurpleA,
              alignment: Alignment.topRight,
              child: CustomImageView(
                imagePath: ImageConstant.imgEdit1SvgrepoCom,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildThirtyThree(BuildContext context) {
    return SizedBox(
      height: 65.v,
      width: 318.h,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomTextFormField(
              width: 318.h,
              enable: enablePhoneNumber,
              textInputType: TextInputType.number,
              textStyle: CustomTextStyles.titleSmallGray700,
              controller: telephoneController,
              hintText: "0600000000",
              hintStyle: theme.textTheme.bodyLarge!,
              alignment: Alignment.bottomCenter,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 30.h,
                vertical: 9.v,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please fill the telephone nombre';
                }
                return null;
              },
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Numéro de téléphone",
              style: CustomTextStyles.titleSmallGray700,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 17.v,
              right: 4.h,
            ),
            child: CustomIconButton(
              onTap: () {
                setState(() {
                  enablePhoneNumber = true;
                });
              },
              height: 20.adaptSize,
              width: 20.adaptSize,
              padding: EdgeInsets.all(2.h),
              decoration: IconButtonStyleHelper.fillDeepPurpleA,
              alignment: Alignment.topRight,
              child: CustomImageView(
                imagePath: ImageConstant.imgEdit1SvgrepoCom,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildEmail(BuildContext context) {
    return SizedBox(
      height: 48.v,
      width: 318.h,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          CustomTextFormField(
            width: 318.h,
            enable: enableEmail,
            controller: emailController,
            hintText: sharedPref!.getString('email'),
            textStyle: CustomTextStyles.titleSmallGray700,
            hintStyle: theme.textTheme.bodyLarge!,
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.emailAddress,
            alignment: Alignment.bottomCenter,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 30.h,
              vertical: 9.v,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please fill the email';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  .hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          Padding(
            padding: EdgeInsets.only(right: 4.h),
            child: CustomIconButton(
              onTap: () {
                setState(() {
                  enableEmail = true;
                });
              },
              height: 20.adaptSize,
              width: 20.adaptSize,
              padding: EdgeInsets.all(2.h),
              decoration: IconButtonStyleHelper.fillDeepPurpleA,
              alignment: Alignment.topRight,
              child: CustomImageView(
                imagePath: ImageConstant.imgEdit1SvgrepoCom,
              ),
            ),
          ),
        ],
      ),
    );
  }


  Future<String> getDocumentIdByUserId(String userId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('user')
          .where('userId', isEqualTo: userId)
          .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {

        return querySnapshot.docs.first.id;
      } else {
        return ''; // User document not found
      }
    } catch (e) {
      print('Error fetching user profile: $e');
      return ''; // Handle error fetching user profile
    }
  }



  Future<void> _saveToFirebase() async {
    setState(() {
      loading = true;
    });
    if (_formKey.currentState!.validate()) {
      // Validate succeeded, proceed with saving to Firebase
        var photoUrl = imageChanged ? await _uploadImageToFirebaseStorage(File(imagePath)) : imagePath;
        // Reference to the document to be updated
        final String getDocumentId = await getDocumentIdByUserId(userId);
        final userDocRef = FirebaseFirestore.instance.collection('user').doc(getDocumentId);
        await userDocRef.update({
          'username': pseudoNameController.text,
          'name': prenomController.text,
          'familyName': nomController.text,
          'phoneNumber': telephoneController.text,
          'email': emailController.text,
          'photo_url': photoUrl
        });
     setState(() {
       enableEmail = false;
       enablePhoneNumber = false;
       enableNom = false;
       enablePrenom = false;
       enablePseudoName = false;
     });
        sharedPref!.setString('imagePath', photoUrl!) ;
      //ignore: use_build_context_synchronously
      await AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.rightSlide,
        title: 'Done',
        desc: 'Your Data has been updated successfully',
        btnOkOnPress: () {

        },
        btnOkText: "Ok",
      ).show();
      setState(() {
        loading = false;
      });
    }else {
      setState(() {
        loading = false;
      });
    }
  }
}
