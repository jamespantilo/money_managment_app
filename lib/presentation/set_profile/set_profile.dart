import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pfe_project/main.dart';
import 'package:pfe_project/widgets/custom_elevated_button.dart';
import 'package:pfe_project/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:pfe_project/core/app_export.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

class SetProfilePage extends StatefulWidget {
  const SetProfilePage({super.key});

  @override
  State<SetProfilePage> createState() => _SetProfilePageState();
}

class _SetProfilePageState extends State<SetProfilePage> {
  TextEditingController pseudoNameController = TextEditingController();

  TextEditingController prenomController = TextEditingController();

  TextEditingController nomController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController telephoneController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? imagePath;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    emailController.text = sharedPref!.getString('email')!;
    sharedPref!.getString('name') != null ? nomController.text = sharedPref!.getString('name')! : null;
  }

  Future<void> _setImage() async {
    final file = await FilePicker.platform.pickFiles(type: FileType.image);
    if (file != null) {
      setState(() {
        imagePath = file.paths.first;
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
    return SafeArea(
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
                                    "First Name",
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
                                    "Email Address",
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
                    ? const Center(child: CircularProgressIndicator(color: Colors.red,)) : const SizedBox(),
              ],
            ),
      ),
    );
  }

  /// Section Widget
  Widget _buildThirtyFour(BuildContext context) {
    return InkWell(
      onTap: () async {
        await _setImage();
      },
      child: Container(
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
                  imagePath != null
                      ? SizedBox(
                          height: 115.adaptSize,
                          width: 115.adaptSize,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(57.h),
                              child: Image.file(
                                fit: BoxFit.cover,
                                File('$imagePath'),
                                height: 115.adaptSize,
                                width: 115.adaptSize,
                              )))
                      : CustomImageView(
                          imagePath: ImageConstant.imgBlankProfileP,
                          height: 115.adaptSize,
                          width: 115.adaptSize,
                          radius: BorderRadius.circular(
                            57.h,
                          ),
                          alignment: Alignment.center,
                        ),
                  // Padding(
                  //   padding: EdgeInsets.only(
                  //     right: 5.h,
                  //     bottom: 4.v,
                  //   ),
                  //   child: CustomIconButton(
                  //     height: 22.adaptSize,
                  //     width: 22.adaptSize,
                  //     padding: EdgeInsets.all(2.h),
                  //     decoration: IconButtonStyleHelper.fillDeepPurpleA,
                  //     alignment: Alignment.bottomRight,
                  //     child: CustomImageView(
                  //       imagePath: ImageConstant.imgEdit1SvgrepoCom,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.only(
            //     top: 14.v,
            //     right: 13.h,
            //     bottom: 26.v,
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       SizedBox(
            //         width: 121.h,
            //         child: Text(
            //           "prenom\nnom",
            //           maxLines: 2,
            //           overflow: TextOverflow.ellipsis,
            //           style: CustomTextStyles.headlineSmallBlack900,
            //         ),
            //       ),
            //       SizedBox(height: 5.v),
            //     ],
            //   ),
            // ),
          ],
        ),
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
            textStyle: CustomTextStyles.titleSmallGray700,
            controller: pseudoNameController,
            hintText: "Username",
            hintStyle: theme.textTheme.bodyLarge!,
            alignment: Alignment.bottomCenter,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 30.h,
              vertical: 9.v,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please fill the Username';
              }
              return null;
            },
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Username",
              style: CustomTextStyles.titleSmallGray700,
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.only(
          //     top: 18.v,
          //     right: 4.h,
          //   ),
          //   child: CustomIconButton(
          //     height: 20.adaptSize,
          //     width: 20.adaptSize,
          //     padding: EdgeInsets.all(2.h),
          //     decoration: IconButtonStyleHelper.fillDeepPurpleA,
          //     alignment: Alignment.topRight,
          //     child: CustomImageView(
          //       imagePath: ImageConstant.imgEdit1SvgrepoCom,
          //     ),
          //   ),
          // ),
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
            controller: prenomController,
            textStyle: CustomTextStyles.titleSmallGray700,
            hintText: "First Name",
            hintStyle: theme.textTheme.bodyLarge!,
            alignment: Alignment.bottomCenter,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 30.h,
              vertical: 9.v,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please fill the First Name';
              }
              return null;
            },
          ),
          // Padding(
          //   padding: EdgeInsets.only(right: 4.h),
          //   child: CustomIconButton(
          //     height: 20.adaptSize,
          //     width: 20.adaptSize,
          //     padding: EdgeInsets.all(2.h),
          //     decoration: IconButtonStyleHelper.fillDeepPurpleA,
          //     alignment: Alignment.topRight,
          //     child: CustomImageView(
          //       imagePath: ImageConstant.imgEdit1SvgrepoCom,
          //     ),
          //   ),
          // ),
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
            textStyle: CustomTextStyles.titleSmallGray700,
            controller: nomController,
            hintText: sharedPref!.getString('name') ?? 'Family Name',
            hintStyle: theme.textTheme.bodyLarge!,
            alignment: Alignment.bottomCenter,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 30.h,
              vertical: 9.v,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please fill the Family Name';
              }
              return null;
            },
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Family Name",
              style: CustomTextStyles.titleSmallGray700,
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.only(
          //     top: 18.v,
          //     right: 4.h,
          //   ),
          //   child: CustomIconButton(
          //     height: 20.adaptSize,
          //     width: 20.adaptSize,
          //     padding: EdgeInsets.all(2.h),
          //     decoration: IconButtonStyleHelper.fillDeepPurpleA,
          //     alignment: Alignment.topRight,
          //     child: CustomImageView(
          //       imagePath: ImageConstant.imgEdit1SvgrepoCom,
          //     ),
          //   ),
          // ),
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
                  return 'Please fill the Phone Number';
                }
                return null;
              },
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Phone Number",
              style: CustomTextStyles.titleSmallGray700,
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.only(
          //     top: 17.v,
          //     right: 4.h,
          //   ),
          //   child: CustomIconButton(
          //     height: 20.adaptSize,
          //     width: 20.adaptSize,
          //     padding: EdgeInsets.all(2.h),
          //     decoration: IconButtonStyleHelper.fillDeepPurpleA,
          //     alignment: Alignment.topRight,
          //     child: CustomImageView(
          //       imagePath: ImageConstant.imgEdit1SvgrepoCom,
          //     ),
          //   ),
          // ),
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
                return 'Please fill the Email Address';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  .hasMatch(value)) {
                return 'Please enter a valid Email Address';
              }
              return null;
            },
          ),
          // Padding(
          //   padding: EdgeInsets.only(right: 4.h),
          //   child: CustomIconButton(
          //     height: 20.adaptSize,
          //     width: 20.adaptSize,
          //     padding: EdgeInsets.all(2.h),
          //     decoration: IconButtonStyleHelper.fillDeepPurpleA,
          //     alignment: Alignment.topRight,
          //     child: CustomImageView(
          //       imagePath: ImageConstant.imgEdit1SvgrepoCom,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Future<void> _saveToFirebase() async {
    setState(() {
      loading = true;
    });
    if (_formKey.currentState!.validate() ) {//&& imagePath != null
      // Validate succeeded, proceed with saving to Firebase
      var photoUrl = imagePath != null ? await _uploadImageToFirebaseStorage(File(imagePath!)) : "https://firebasestorage.googleapis.com/v0/b/hussein-questions.appspot.com/o/img_blank_profile_p.png?alt=media&token=df445b36-7f4a-4842-8199-7335d5556cf4";

      // Save data to Firestore
      await FirebaseFirestore.instance.collection('user').add({
        'username': pseudoNameController.text,
        'name': prenomController.text,
        'familyName': nomController.text,
        'phoneNumber': telephoneController.text,
        'email': emailController.text,
        'photo_url': photoUrl,
        'userId': sharedPref!.getString('userId'),
        'set_profile': 1,
      });

      // Clear form fields after submission
      pseudoNameController.clear();
      prenomController.clear();
      nomController.clear();
      telephoneController.clear();
      emailController.clear();
      await getImagePath(userId);
      // ignore: use_build_context_synchronously
      await AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.rightSlide,
        title: 'Done',
        desc: 'Your registration has been completed successfully',
        btnOkOnPress: () {},
        btnOkText: "Ok",
      ).show();
      setState(() {
        loading = true;
      });
      await sharedPref!.setInt('set_profile', 1);
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.homepage, (route) => false);
    }else {
      setState(() {
        loading = false;
      });
      await AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Error',
        desc: 'Faild to completed your registration ',
        btnCancelOnPress: () {},
        btnCancelText: "Ok",
      ).show();
    }
  }
}
