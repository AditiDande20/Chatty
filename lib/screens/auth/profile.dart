import 'dart:io';

import 'package:chatty/screens/auth/login.dart';
import 'package:chatty/utils/constants.dart';
import 'package:chatty/widgets/user_image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';
import '../../services/firebase_services.dart';
import '../../utils/custom_colors.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/common_modal.dart';

class ProfileScreen extends StatefulWidget {
  final String? flag;
  const ProfileScreen({super.key, this.flag});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool isChanged = false;
  bool isLoading = false;
  File? imageFile;
  String? uploadedImage;
  String? fetchedImageUrl;

  @override
  initState() {
    setData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      opacity: 0.5,
      color: CustomColors.greyColor,
      progressIndicator: const CircularProgressIndicator(
        color: CustomColors.baseColor,
      ),
      isLoading: isLoading,
      child: Scaffold(
        backgroundColor: CustomColors.backgroundColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100.0),
          child: AppBar(
            surfaceTintColor: CustomColors.backgroundColor,
            backgroundColor: CustomColors.backgroundColor,
            toolbarHeight: 100,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: const Text(
              ConstantsData.profile,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: CustomColors.blackColor,
              ),
            ),
          ),
        ),
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                UserImagePicker(
                  imageUrl: fetchedImageUrl,
                  onPickImage: (pickedImage) {
                    setState(() {
                      isChanged = true;
                      imageFile = pickedImage;
                    });
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(top: 40, bottom: 20),
                  width: MediaQuery.of(context).size.width - 40,
                  decoration: BoxDecoration(
                      color: CustomColors.backgroundColor,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                            color: CustomColors.foregroundColor,
                            offset: const Offset(
                              7,
                              7,
                            ),
                            blurRadius: 10,
                            spreadRadius: 1),
                        const BoxShadow(
                            color: CustomColors.whiteColor,
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: Offset(
                              -7,
                              -7,
                            ))
                      ]),
                  child: TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(20),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        filled: true,
                        hintStyle:
                            const TextStyle(color: CustomColors.greyColor),
                        hintText: ConstantsData.addEmail,
                        fillColor: CustomColors.backgroundColor,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(50.0),
                        )),
                    onChanged: (value) {
                      setState(() {
                        isChanged = true;
                      });
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 40,
                  decoration: BoxDecoration(
                      color: CustomColors.backgroundColor,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                            color: CustomColors.foregroundColor,
                            offset: const Offset(
                              7,
                              7,
                            ),
                            blurRadius: 10,
                            spreadRadius: 1),
                        const BoxShadow(
                            color: CustomColors.whiteColor,
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: Offset(
                              -7,
                              -7,
                            ))
                      ]),
                  child: TextField(
                    controller: nameController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(20),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        filled: true,
                        hintStyle:
                            const TextStyle(color: CustomColors.greyColor),
                        hintText: ConstantsData.addName,
                        fillColor: CustomColors.backgroundColor,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(50.0),
                        )),
                    onChanged: (value) {
                      setState(() {
                        isChanged = true;
                      });
                    },
                  ),
                ),
                if (isChanged)
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 50),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(ConstantsData.edit,
                              style: TextStyle(
                                  fontSize: 18,
                                  height: 1.5,
                                  fontWeight: FontWeight.bold,
                                  color: CustomColors.baseColor)),
                          const SizedBox(
                            width: 15,
                          ),
                          InkWell(
                            onTap: () {
                              validateInput();
                            },
                            child: Container(
                              height: 60,
                              width: 70,
                              decoration: BoxDecoration(
                                  color: CustomColors.baseColor,
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.red.shade50,
                                        offset: const Offset(
                                          7,
                                          7,
                                        ),
                                        blurRadius: 5,
                                        spreadRadius: 1),
                                    BoxShadow(
                                        color: Colors.red.shade50,
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: const Offset(
                                          -7,
                                          -7,
                                        ))
                                  ]),
                              child: const Icon(
                                Icons.arrow_forward,
                                color: CustomColors.whiteColor,
                              ),
                            ),
                          )
                        ]),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  validateInput() {
    if (emailController.text.toString().trim().isEmpty) {
      showErrorCommonModal(
          context: context,
          heading: ConstantsData.emailValidation,
          description: '',
          buttonName: ConstantsData.ok);
    } else if (!isValidEmail(emailController.text.trim())) {
      showErrorCommonModal(
          context: context,
          heading: ConstantsData.verifyEmailValidation,
          description: '',
          buttonName: ConstantsData.ok);
    } else if (nameController.text.toString().trim().isEmpty) {
      showErrorCommonModal(
          context: context,
          heading: ConstantsData.nameValidation,
          description: '',
          buttonName: ConstantsData.ok);
    } else if (imageFile == null && fetchedImageUrl == null) {
      showErrorCommonModal(
          context: context,
          heading: ConstantsData.imageValidation,
          description: '',
          buttonName: ConstantsData.ok);
    } else {
      networkCheck();
    }
  }

  networkCheck() async {
    hideKeyboard();
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      if (mounted) {
        saveProfileData();
      }
    } else {
      if (mounted) {
        showErrorCommonModal(
            context: context,
            heading: ConstantsData.noInternet,
            description: ConstantsData.noInternetDescription,
            buttonName: ConstantsData.ok);
      }
    }
  }

  void showSuccessModal({heading, description, buttonName}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CommonModal(
            heading: heading,
            description: description,
            buttonName: buttonName,
            firstButtonName: "",
            secondButtonName: "",
            onConfirmBtnTap: () {
              if (widget.flag != null && widget.flag!.isNotEmpty) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              } else {
                Navigator.pop(context);
                setState(() {
                  isChanged = false;
                });
              }
            },
            onFirstBtnTap: () {},
            onSecondBtnTap: () {},
          );
        });
  }

  Future<void> saveProfileData() async {
    setState(() {
      isLoading = true;
    });
    if (imageFile != null) {
      uploadedImage = await uploadImagetoFirebaseStorage(imageFile!, context);
    }

    if (mounted) {
      var userMap = {
        UserCollection.userId: FirebaseAuth.instance.currentUser?.uid,
        UserCollection.name: nameController.text.toString().trim(),
        UserCollection.email: emailController.text.toString().trim(),
        UserCollection.imageUrl: imageFile != null
            ? uploadedImage.toString().trim()
            : fetchedImageUrl.toString(),
        UserCollection.createdTime: DateTime.now.toString().trim(),
      };
      saveDatatoFirestoreDatabase(ConstantsData.users,
          FirebaseAuth.instance.currentUser!.uid, userMap, context);

      var user = Provider.of<UserProvider>(context, listen: false);
      user.doAddUser(userMap);

      setState(() {
        isLoading = false;
      });

      showSuccessModal(
          heading: ConstantsData.savedSuccessfully,
          description: '',
          buttonName: ConstantsData.ok);
    }
  }

  void setData() async {
    setState(() {
      isLoading = true;
    });
    var user = FirebaseAuth.instance.currentUser;
    var userData =
        await getDataFromFirestoreDatabase(ConstantsData.users, context);

    if (user != null) {
      emailController.text =
          FirebaseAuth.instance.currentUser!.email.toString();
    }
    if (userData != null && userData.data() != null) {
      nameController.text =
          userData.data()![ConstantsData.name].toString().trim();
      fetchedImageUrl =
          userData.data()![ConstantsData.imageUrl].toString().trim();
    }
    setState(() {
      isLoading = false;
    });
  }
}
