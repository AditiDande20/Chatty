import 'package:chatty/models/chat_model.dart';
import 'package:chatty/models/user_model.dart';
import 'package:chatty/providers/chat_provider.dart';
import 'package:chatty/screens/chat/chat.dart';
import 'package:chatty/screens/auth/login.dart';
import 'package:chatty/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';
import '../../utils/constants.dart';
import '../../utils/custom_colors.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/common_modal.dart';
import '../../widgets/empty_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  bool showSearch = false;
  List<ChatModel>? chatModelListItem;
  QuerySnapshot<Map<String, dynamic>>? chatList;
  bool isLoading = false;
  String userId = "";
  String userName = "";
  String userImageUrl = "";
  var nameList = [];
  bool flag = false;

  @override
  void initState() {
    var user = Provider.of<UserProvider>(context, listen: false);

    userId = user.userData[UserCollection.userId].toString();
    userName = user.userData[UserCollection.name].toString();
    userImageUrl = user.userData[UserCollection.imageUrl].toString();
    loadChatsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    chatModelListItem = Provider.of<ChatListProvider>(context).getChatModelList;

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
              //       margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
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
              if (!showSearch)
                InkWell(
                  onTap: () {
                    showAlertModal(
                        heading: ConstantsData.logoutAlert,
                        description: ConstantsData.logoutAlertDescription,
                        firstButtonName: ConstantsData.cancel,
                        secondButtonName: ConstantsData.ok);
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    margin: const EdgeInsets.only(left: 10, right: 20, top: 10),
                    decoration: BoxDecoration(
                        color: CustomColors.backgroundColor,
                        borderRadius: BorderRadius.circular(10),
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
                    child: const Icon(
                      Icons.logout,
                      color: CustomColors.baseColor,
                    ),
                  ),
                ),
              //if (showSearch) showSearchBar()
            ],
          ),
        ),
        body: chatModelListItem != null && chatModelListItem!.isNotEmpty
            ? ListView.builder(
                itemCount: chatModelListItem?.length,
                itemBuilder: (context, index) {
                  var stringDate =
                      chatModelListItem?[index].createdTime.toString();
                  var date = DateTime.parse(stringDate!);
                  String time;
                  if (date.day == DateTime.now().day &&
                      date.month == DateTime.now().month &&
                      date.year == DateTime.now().year) {
                    time = DateFormat('HH:mm a').format(date);
                  } else {
                    time = DateFormat('dd/MM/yy').format(date);
                  }

                  var name = "", image = "";

                  if (chatModelListItem?[index].receiverId == userId) {
                    name = chatModelListItem![index].senderName!;
                    image = chatModelListItem?[index].senderImageUrl ?? "";
                  } else if (chatModelListItem?[index].senderId == userId) {
                    name = chatModelListItem![index].receiverName!;
                    image = chatModelListItem?[index].receiverImageUrl ?? "";
                  }
                  return InkWell(
                    onTap: () {
                      String indexUserId =
                          chatModelListItem?[index].senderId == userId
                              ? chatModelListItem![index].receiverId!
                              : chatModelListItem![index].senderId!;
                      String indexUserName =
                          chatModelListItem?[index].senderId == userId
                              ? chatModelListItem![index].receiverName!
                              : chatModelListItem![index].senderName!;
                      String indexUserImageUrl =
                          chatModelListItem?[index].senderId == userId
                              ? chatModelListItem![index].receiverImageUrl!
                              : chatModelListItem![index].senderImageUrl!;

                      Navigator.of(context)
                          .push(MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                    userDetails: UserModel(
                                        userId: indexUserId,
                                        name: indexUserName,
                                        email: "",
                                        imageUrl: indexUserImageUrl,
                                        createdDate: ""),
                                  )))
                          .then((value) {
                        if (value) {
                          nameList.clear();
                          loadChatsList();
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      decoration: BoxDecoration(
                          color: CustomColors.backgroundColor,
                          borderRadius: BorderRadius.circular(10),
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
                                color: Colors.white,
                                spreadRadius: 1,
                                blurRadius: 10,
                                offset: Offset(
                                  -7,
                                  -7,
                                ))
                          ]),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(
                                image,
                                fit: BoxFit.fill,
                                height: 50,
                                width: 50,
                              )),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            flex: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: CustomColors.blackColor,
                                  ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: Text(
                                    chatModelListItem?[index]
                                            .message
                                            .toString() ??
                                        "",
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: CustomColors.greyColor,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const Spacer(),
                          Text(
                            time,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: CustomColors.greyColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                })
            : const EmptyScreenWidget(
                description: "Start chatting with other people.",
                message: "No Chats Found",
              ),
      ),
    );
  }

  void showAlertModal(
      {heading, description, firstButtonName, secondButtonName}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CommonModal(
            heading: heading,
            description: description,
            buttonName: '',
            firstButtonName: firstButtonName,
            secondButtonName: secondButtonName,
            onConfirmBtnTap: () {},
            onFirstBtnTap: () {
              Navigator.pop(context);
            },
            onSecondBtnTap: () {
              Navigator.pop(context);
              networkCheck();
            },
          );
        });
  }

  networkCheck() async {
    setState(() {
      isLoading = true;
    });
    hideKeyboard();
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      if (mounted) {
        signOut();
        var user = Provider.of<UserProvider>(context, listen: false);
        user.doRemoveUser();
        setState(() {
          isLoading = false;
        });
        if (mounted) {
          showSuccessModal(
              heading: ConstantsData.loggedOutSuccesfully,
              description: '',
              buttonName: ConstantsData.ok);
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
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
            onFirstBtnTap: () {},
            onSecondBtnTap: () {},
          );
        });
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
        // onChanged: (value) {
        //   chatModelListItem = chatModelListItem
        //       ?.where((x) => x.message
        //           .toString()
        //           .toLowerCase()
        //           .contains(value.toLowerCase()))
        //       .toList();
        //   //setState(() {});
        // },
      ),
    );
  }

  loadChatsList() async {
    setState(() {
      isLoading = true;
    });
    hideKeyboard();
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      if (mounted) {
        chatList = await getListFromFirestoreDatabase(
          Collections.chats,
          context,
          ChatCollection.date,
        );

        List<ChatModel> allChatsList =
            List<ChatModel>.from(chatList!.docs.map((x) {
          return ChatModel.fromDocument(x);
        }));

        var list = allChatsList
            .where((chats) =>
                chats.senderId == userId || chats.receiverId == userId)
            .toList();

        List<ChatModel> finalList = [];

        for (int i = 0; i < list.length; i++) {
          if (list[i].receiverId != userId &&
              !nameList.contains(list[i].receiverId)) {
            nameList.add(list[i].receiverId);
            finalList.add(list[i]);
          } else if (list[i].senderId != userId &&
              !nameList.contains(list[i].senderId)) {
            nameList.add(list[i].senderId);
            finalList.add(list[i]);
          }
        }

        if (mounted) {
          Provider.of<ChatListProvider>(context, listen: false)
              .setItem(finalList);
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
