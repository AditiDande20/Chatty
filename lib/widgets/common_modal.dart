import 'package:flutter/material.dart';

import '../utils/custom_colors.dart';

class CommonModal extends StatefulWidget {
  final String heading;
  final String description;
  final String buttonName;
  final String firstButtonName;
  final String secondButtonName;

  final Function onConfirmBtnTap;
  final Function onFirstBtnTap;
  final Function onSecondBtnTap;

  const CommonModal({
    Key? key,
    required this.heading,
    required this.description,
    required this.buttonName,
    required this.firstButtonName,
    required this.secondButtonName,
    required this.onConfirmBtnTap,
    required this.onFirstBtnTap,
    required this.onSecondBtnTap,
  }) : super(key: key);

  @override
  _CommonModalState createState() => _CommonModalState();
}

class _CommonModalState extends State<CommonModal> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return AlertDialog(
        backgroundColor: CustomColors.backgroundColor,
        surfaceTintColor: CustomColors.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        insetPadding: const EdgeInsets.only(left: 18.0, right: 18.0),
        contentPadding: const EdgeInsets.only(
            top: 30, bottom: 30.0, left: 30.0, right: 30.0),
        scrollable: true,
        content: Container(
          color: CustomColors.backgroundColor,
          width: width,
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Container(
              color: CustomColors.backgroundColor,
              child: Text(
                widget.heading,
                style: const TextStyle(
                    color: CustomColors.blackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            if (widget.description != "")
              Container(
                color: CustomColors.backgroundColor,
                margin: const EdgeInsets.only(top: 15.0),
                child: Text(
                  widget.description,
                  style: const TextStyle(
                    color: CustomColors.greyColor,
                    fontSize: 16,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            if (widget.buttonName != "")
              Container(
                  margin: const EdgeInsets.only(top: 30.0, bottom: 2),
                  height: 46,
                  
                  decoration: BoxDecoration(
                      color: CustomColors.backgroundColor,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color: CustomColors.foregroundColor,
                            offset: const Offset(
                              7,
                              7,
                            ),
                            blurRadius: 5,
                            spreadRadius: 1),
                        const BoxShadow(
                            color: CustomColors.whiteColor,
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(
                              -7,
                              -7,
                            ))
                      ]),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                      backgroundColor: CustomColors.backgroundColor,
                      surfaceTintColor: CustomColors.backgroundColor,
                    ),
                    child: Text(
                      widget.buttonName,
                      style: const TextStyle(
                          fontSize: 18,
                          color: CustomColors.baseColor,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      widget.onConfirmBtnTap();
                    },
                  )),
            if (widget.firstButtonName != "" && widget.secondButtonName != "")
              Container(
                  margin: const EdgeInsets.only(top: 30.0, bottom: 2),
                  width: double.infinity,
                  height: 46,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                            color: CustomColors.backgroundColor,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                  color: CustomColors.foregroundColor,
                                  offset: const Offset(
                                    7,
                                    7,
                                  ),
                                  blurRadius: 5,
                                  spreadRadius: 1),
                              const BoxShadow(
                                  color: CustomColors.whiteColor,
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(
                                    -7,
                                    -7,
                                  ))
                            ]),
                        height: 52,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 50,
                            backgroundColor: CustomColors.backgroundColor,
                            surfaceTintColor: CustomColors.backgroundColor,
                          ),
                          child: Text(
                            widget.firstButtonName,
                            style: const TextStyle(
                                fontSize: 18,
                                color: CustomColors.baseColor,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            widget.onFirstBtnTap();
                          },
                        ),
                      )),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: CustomColors.backgroundColor,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                    color: CustomColors.foregroundColor,
                                    offset: const Offset(
                                      7,
                                      7,
                                    ),
                                    blurRadius: 5,
                                    spreadRadius: 1),
                                const BoxShadow(
                                    color: CustomColors.whiteColor,
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: Offset(
                                      -7,
                                      -7,
                                    ))
                              ]),
                          height: 46,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: CustomColors.backgroundColor,
                                surfaceTintColor: CustomColors.backgroundColor),
                            child: Text(
                              widget.secondButtonName,
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: CustomColors.baseColor,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            onPressed: () {
                              widget.onSecondBtnTap();
                            },
                          ),
                        ),
                      ),
                    ],
                  )),
          ]),
        ));
  }
}
