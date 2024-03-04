import 'package:chatty/models/user_model.dart';
import 'package:chatty/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import '../../providers/user_list_provider.dart';
import '../../utils/constants.dart';
import '../../utils/custom_colors.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/empty_screen.dart';
import 'chat.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  TextEditingController searchController = TextEditingController();
  bool showSearch = false;
  bool isLoading = false;
  QuerySnapshot<Map<String, dynamic>>? userList;
  List<UserModel>? userModelListItem;

  @override
  void initState() {
    networkCheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    userModelListItem = Provider.of<UserListProvider>(context).getUserModelList;
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
            centerTitle: false,
            title: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                ConstantsData.appName,
                style: GoogleFonts.courgette(
                    textStyle: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: CustomColors.baseColor,
                )),
              ),
            ),
            actions: [
              // if (!showSearch)
              //   InkWell(
              //     onTap: () {
              //       setState(() {
              //         showSearch = true;
              //       });
              //     },
              //     child: Container(
              //       height: 50,
              //       width: 50,
              //       margin: const EdgeInsets.only(left: 10, right: 20, top: 10),
              //       decoration: BoxDecoration(
              //           color: CustomColors.backgroundColor,
              //           borderRadius: BorderRadius.circular(10),
              //           boxShadow: [
              //             BoxShadow(
              //                 color: CustomColors.foregroundColor,
              //                 offset: const Offset(
              //                   7,
              //                   7,
              //                 ),
              //                 blurRadius: 10,
              //                 spreadRadius: 1),
              //             const BoxShadow(
              //                 color: CustomColors.whiteColor,
              //                 spreadRadius: 1,
              //                 blurRadius: 10,
              //                 offset: Offset(
              //                   -7,
              //                   -7,
              //                 ))
              //           ]),
              //       child: const Icon(
              //         Icons.search,
              //         color: CustomColors.baseColor,
              //       ),
              //     ),
              //   ),
              // if (showSearch) showSearchBar()
            ],
          ),
        ),
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(children: [
              const Text(
                  'In the cookie of life, friends are the chocolate chips. Hurry up and add your chocolate chips',
                  style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      fontWeight: FontWeight.normal,
                      color: CustomColors.greyColor)),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                  child: userModelListItem != null &&
                          userModelListItem!.isNotEmpty
                      ? ListView.builder(
                          itemCount: userModelListItem?.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (context) => ChatScreen(
                                              userDetails:
                                                  userModelListItem?[index],
                                            )))
                                    .then((value) {
                                  if (value) {
                                    networkCheck();
                                  }
                                });
                              },
                              child: userModelListItem?[index].userId !=
                                      FirebaseAuth.instance.currentUser?.uid
                                  ? Container(
                                      padding: const EdgeInsets.all(20),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      decoration: BoxDecoration(
                                          color: CustomColors.backgroundColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                                color: CustomColors
                                                    .foregroundColor,
                                                offset: const Offset(
                                                  7,
                                                  7,
                                                ),
                                                blurRadius: 10,
                                                spreadRadius: 1),
                                            const BoxShadow(
                                                color: Colors.white,
                                                spreadRadius: 1,
                                                blurRadius: 10,
                                                offset: Offset(
                                                  -7,
                                                  -7,
                                                ))
                                          ]),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: Image.network(
                                                userModelListItem?[index]
                                                        .imageUrl ??
                                                    "",
                                                fit: BoxFit.fill,
                                                height: 50,
                                                width: 50,
                                              )),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            userModelListItem?[index].name ??
                                                "",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: CustomColors.blackColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container()
                            );
                          })
                      : const EmptyScreenWidget(
                          description: ConstantsData.emptyDescription,
                          message: ConstantsData.emptyMessage,
                        ))
            ])),
      ),
    );
  }

  showSearchBar() {
    searchController.clear();
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      margin: const EdgeInsets.only(right: 20),
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
        controller: searchController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(20),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(50.0),
          ),
          filled: true,
          hintStyle: const TextStyle(color: CustomColors.greyColor),
          hintText: "Search by name",
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
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                showSearch = false;
              });
            },
            icon: const Icon(
              Icons.cancel,
              size: 30,
              color: CustomColors.baseColor,
            ),
          ),
        ),
      ),
    );
  }

  networkCheck() async {
    setState(() {
      isLoading = true;
    });
    hideKeyboard();
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      if (mounted) {
        userList = await getListFromFirestoreDatabase(
            ConstantsData.users, context, "");

        List<UserModel> allUserList =
            List<UserModel>.from(userList!.docs.map((x) {
          return UserModel.fromDocument(x);
        }));

        if (mounted) {
          Provider.of<UserListProvider>(context, listen: false)
              .setItem(allUserList);
        }

        setState(() {
          isLoading = false;
        });
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
}
