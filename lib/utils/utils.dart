import 'package:flutter/material.dart';

import '../widgets/common_modal.dart';

hideKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

bool isValidEmail(String email) {
  bool emailValid = false;
  if (email != "") {
    emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
  return emailValid;
}

void showErrorCommonModal({ context,  heading,  description, buttonName}) {
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
            Navigator.pop(context);

          },
          onFirstBtnTap: () {},
          onSecondBtnTap: () {},
        );
      });
}