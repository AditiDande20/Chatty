import 'package:chatty/screens/auth/profile.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../services/firebase_services.dart';
import '../../utils/constants.dart';
import '../../utils/custom_colors.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/common_modal.dart';
import 'login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isLoading = false;

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
        backgroundColor: CustomColors.whiteColor,
        body: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      color: CustomColors.whiteColor,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Text(
                              ConstantsData.appName,
                              style: GoogleFonts.courgette(
                                  textStyle: const TextStyle(
                                fontSize: 70,
                                fontWeight: FontWeight.bold,
                                color: CustomColors.baseColor,
                              )),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          const Text('Create Account',
                              style: TextStyle(
                                  fontSize: 25,
                                  height: 1.5,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black)),
                          const Text('Take the first step – sign up today!',
                              style: TextStyle(
                                  fontSize: 16,
                                  height: 1.5,
                                  fontWeight: FontWeight.normal,
                                  color: CustomColors.baseColor))
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: const EdgeInsets.only(top: 50),
                      color: CustomColors.whiteColor,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 40,
                            decoration: BoxDecoration(
                                color: CustomColors.whiteColor,
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
                                  BoxShadow(
                                      color: CustomColors.backgroundColor,
                                      spreadRadius: 1,
                                      blurRadius: 10,
                                      offset: const Offset(
                                        -7,
                                        -7,
                                      ))
                                ]),
                            child: TextField(
                              maxLength: 50,
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                counterText: "",
                                  contentPadding: const EdgeInsets.all(20),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  filled: true,
                                  hintStyle: const TextStyle(
                                      color: CustomColors.greyColor),
                                  hintText: "Email",
                                  fillColor: CustomColors.whiteColor,
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
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            width: MediaQuery.of(context).size.width - 40,
                            decoration: BoxDecoration(
                                color: CustomColors.whiteColor,
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
                                  BoxShadow(
                                      color: CustomColors.backgroundColor,
                                      spreadRadius: 1,
                                      blurRadius: 10,
                                      offset: const Offset(
                                        -7,
                                        -7,
                                      ))
                                ]),
                            child: TextField(
                              maxLength: 8,
                              obscureText: true,
                              controller: passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                  counterText: "",
                                  contentPadding: const EdgeInsets.all(20),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  filled: true,
                                  hintStyle: const TextStyle(
                                      color: CustomColors.greyColor),
                                  hintText: "Password",
                                  fillColor: CustomColors.whiteColor,
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
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            width: MediaQuery.of(context).size.width - 40,
                            decoration: BoxDecoration(
                                color: CustomColors.whiteColor,
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
                                  BoxShadow(
                                      color: CustomColors.backgroundColor,
                                      spreadRadius: 1,
                                      blurRadius: 10,
                                      offset: const Offset(
                                        -7,
                                        -7,
                                      ))
                                ]),
                            child: TextField(
                              controller: confirmPasswordController,
                              keyboardType: TextInputType.visiblePassword,
                              maxLength: 8,
                              obscureText: true,
                              decoration: InputDecoration(
                                  counterText: "",
                                  contentPadding: const EdgeInsets.all(20),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  filled: true,
                                  hintStyle: const TextStyle(
                                      color: CustomColors.greyColor),
                                  hintText: "Confirm Password",
                                  fillColor: CustomColors.whiteColor,
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
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 50),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Text('Register',
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
                                          borderRadius:
                                              BorderRadius.circular(30),
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
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 70),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Already have an account ? ',
                                      style: TextStyle(
                                          fontSize: 18,
                                          height: 1.5,
                                          fontWeight: FontWeight.normal,
                                          color: CustomColors.greyColor)),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginScreen()));
                                    },
                                    child: const Text('Login',
                                        style: TextStyle(
                                            fontSize: 20,
                                            height: 1.5,
                                            fontWeight: FontWeight.bold,
                                            color: CustomColors.baseColor)),
                                  ),
                                ]),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
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
    } else if (passwordController.text.toString().trim().isEmpty) {
      showErrorCommonModal(
          context: context,
          heading: ConstantsData.passwordValidation,
          description: '',
          buttonName: ConstantsData.ok);
    } else if (confirmPasswordController.text.toString().trim().isEmpty) {
      showErrorCommonModal(
          context: context,
          heading: ConstantsData.confirmPasswordValidation,
          description: '',
          buttonName: ConstantsData.ok);
    } else if (confirmPasswordController.text.trim() !=
        passwordController.text.trim()) {
      showErrorCommonModal(
          context: context,
          heading: ConstantsData.verifyPasswordValidation,
          description: '',
          buttonName: ConstantsData.ok);
    } else {
      networkCheck();
    }
  }

  networkCheck() async {
    setState(() {
      isLoading = true;
    });
    hideKeyboard();
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      if (mounted) {
        var userCredentials = await registerWithEmailAndPassword(
            emailController.text.toString().trim(),
            passwordController.text.toString().trim(),
            context);
        setState(() {
          isLoading = false;
        });
        if (userCredentials != null) {
          emailController.clear();
          passwordController.clear();
          confirmPasswordController.clear();

          if (mounted) {
            showSuccessModal(
                heading: ConstantsData.registeredSuccesfully,
                description: '',
                buttonName: ConstantsData.ok);

           
          }
        }
      }
    } else {
      setState(() {
        isLoading = false;
      });
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
              Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfileScreen(flag: ConstantsData.edit,),
              ),
            );
            },
            onFirstBtnTap: () {},
            onSecondBtnTap: () {},
          );
        });
  }
}
