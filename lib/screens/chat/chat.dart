import 'package:chatty/models/chat_model.dart';
import 'package:chatty/models/user_model.dart';
import 'package:chatty/services/firebase_services.dart';
import 'package:chatty/utils/constants.dart';
import 'package:chatty/utils/custom_colors.dart';
import 'package:chatty/utils/utils.dart';
import 'package:chatty/widgets/empty_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';
import '../../widgets/common_modal.dart';

class ChatScreen extends StatefulWidget {
  final UserModel? userDetails;
  const ChatScreen({super.key, this.userDetails});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController sendController = TextEditingController();
  String userId = "";
  String userName = "";
  String userImageUrl = "";
  List<ChatModel> chatList = [];
  bool isLoading = false;

  @override
  void initState() {
    var user = Provider.of<UserProvider>(context, listen: false);
    userId = user.userData[UserCollection.userId].toString();
    userName = user.userData[UserCollection.name].toString();
    userImageUrl = user.userData[UserCollection.imageUrl].toString();

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
            title: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context, true);
                    },
                    child: Container(
                      height: 50,
                      width: 50,
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
                        Icons.arrow_back,
                        color: CustomColors.baseColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(
                            widget.userDetails!.imageUrl!.toString(),
                            fit: BoxFit.fill,
                            height: 50,
                            width: 60,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.userDetails!.name!.toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: CustomColors.blackColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //const Spacer(),
                ],
              ),
            ),
            actions: [
              InkWell(
                onTap: () {
                  _showPopupMenu();
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
                    Icons.more_horiz,
                    color: CustomColors.baseColor,
                  ),
                ),
              )
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 100),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(Collections.chats)
                  .orderBy('date', descending: true)
                  .snapshots(),
              builder: (context, snapshots) {
                if (snapshots.hasData) {
                  var listMessage = snapshots.data?.docs;

                  List<ChatModel> allChatList =
                      List<ChatModel>.from(listMessage!.map((x) {
                    return ChatModel.fromDocument(x);
                  }));

                  if (snapshots.data?.docs != null &&
                      snapshots.data!.docs.isNotEmpty) {
                    String? receiverId = widget.userDetails?.userId;

                    chatList = allChatList
                        .where((element) =>
                            (element.receiverId == userId &&
                                element.senderId == receiverId) ||
                            (element.receiverId == receiverId &&
                                element.senderId == userId))
                        .toList();

                    if (chatList.isNotEmpty) {
                      return ListView.builder(
                        itemCount: chatList.length,
                        reverse: true,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Flex(
                                direction: Axis.horizontal,
                                mainAxisAlignment: chatList[index].senderId ==
                                        FirebaseAuth.instance.currentUser?.uid
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                children: [
                                  Container(
                                    constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.7,
                                    ),
                                    padding: const EdgeInsets.all(15),
                                    margin: const EdgeInsets.only(
                                        top: 10,
                                        bottom: 10,
                                        left: 20,
                                        right: 20),
                                    decoration: BoxDecoration(
                                        color: CustomColors.backgroundColor,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  CustomColors.foregroundColor,
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
                                    child:
                                        Text(chatList[index].message.toString(),
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                              color: CustomColors.blackColor,
                                            )),
                                  ),
                                ],
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                width: double.infinity,
                                child: Text(
                                    formatDateTime(chatList[index].createdTime)
                                        .toString(),
                                    textAlign: chatList[index].senderId ==
                                            FirebaseAuth
                                                .instance.currentUser?.uid
                                        ? TextAlign.end
                                        : TextAlign.start,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color: CustomColors.greyColor,
                                    )),
                              )
                            ],
                          );
                        },
                      );
                    } else {
                      return const EmptyScreenWidget(
                          message: "No Chats !!!",
                          description: "Send a message to begin chatting");
                    }
                  } else {
                    return const EmptyScreenWidget(
                        message: "No Chats !!!",
                        description: "Send a message to begin chatting");
                  }
                } else {
                  return const EmptyScreenWidget(
                      message: "No Chats !!!",
                      description: "Send a message to begin chatting");
                }
              }),
        ),
        bottomSheet: Container(
          margin: const EdgeInsets.all(20),
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
            controller: sendController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(20),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(50.0),
                ),
                filled: true,
                hintStyle: const TextStyle(color: CustomColors.greyColor),
                hintText: "Send a message",
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
                    sendMessage();
                  },
                  icon: const Icon(
                    Icons.send,
                    size: 30,
                    color: CustomColors.baseColor,
                  ),
                )),
          ),
        ),
      ),
    );
  }

  formatDateTime(stringDate) {
    var date = DateTime.parse(stringDate);
    var time = DateFormat('dd/MM/yy  HH:mm a').format(date);
    return time;
  }

  void sendMessage() {
    setState(() {
      isLoading = true;
    });
    String receiverId = "", imageUrl = "", name = "";
    if (widget.userDetails != null) {
      receiverId = widget.userDetails!.userId!;
      imageUrl = widget.userDetails!.imageUrl!;

      name = widget.userDetails!.name!;
    }
    String docId =
        FirebaseFirestore.instance.collection(ConstantsData.chats).doc().id;
    var map = {
      ChatCollection.chatId: docId.toString().trim(),
      ChatCollection.senderId: userId.toString().trim(),
      ChatCollection.receivingId: receiverId.toString().trim(),
      ChatCollection.senderName: userName.toString().trim(),
      ChatCollection.receivingName: name.toString().trim(),
      ChatCollection.message: sendController.text.trim(),
      ChatCollection.date: "${DateTime.now()}",
      ChatCollection.receiverImageUrl: imageUrl.toString().trim(),
      ChatCollection.senderImageUrl: userImageUrl.toString().trim()
    };

    if (sendController.text.trim().isEmpty) {
      return;
    } else {
      saveDatatoFirestoreDatabase(Collections.chats, docId, map, context);

      sendController.clear();
      setState(() {
        isLoading = false;
      });
      hideKeyboard();
    }
  }

  void _showPopupMenu() async {
    await showMenu(
      surfaceTintColor: CustomColors.backgroundColor,
      color: CustomColors.backgroundColor,
      shadowColor: CustomColors.backgroundColor,
      context: context,
      position: const RelativeRect.fromLTRB(100, 110, 10, 100),
      items: [
        PopupMenuItem(
          onTap: () {
            clearChats();
          },
          value: 1,
          child: const Text(
            "Clear Chats",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: CustomColors.blackColor,
            ),
          ),
        ),
      ],
      elevation: 8.0,
    );
  }

  Future<void> clearChats() async {
    for (int i = 0; i < chatList.length; i++) {
      await deleteDatatoFirestoreDatabase(
          Collections.chats, chatList[i].chatId!, context);
    }
   
    showSuccessModal(
        heading: "Chats Cleared",
        description: "Chats deleted successfully",
        buttonName: "OK");
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
              Navigator.pop(context);
            },
            onFirstBtnTap: () {},
            onSecondBtnTap: () {},
          );
        });
  }
}
