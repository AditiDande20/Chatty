import 'package:chatty/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  String? chatId;
  String? senderId;
  String? receiverId;
  String? senderName;
  String? receiverName;
  String? message;
  String? createdTime;
  String? receiverImageUrl;
  String? senderImageUrl;

  ChatModel(
      {required this.chatId,
      required this.senderId,
      required this.receiverId,
      required this.senderName,
      required this.receiverName,
      required this.createdTime,
      required this.receiverImageUrl,
      this.senderImageUrl
      });

  Map<String, dynamic> toJson() => {
        ChatCollection.chatId: chatId,
        ChatCollection.senderId: senderId,
        ChatCollection.receivingId: receiverId,
        ChatCollection.senderName: senderName,
        ChatCollection.receivingName: receiverName,
        ChatCollection.message: message,
        ChatCollection.date: createdTime,
        ChatCollection.receiverImageUrl: receiverImageUrl,
        ChatCollection.senderImageUrl: senderImageUrl,
      };

  ChatModel.fromDocument(QueryDocumentSnapshot snapshot) {
    chatId = snapshot.get(ChatCollection.chatId);
    senderId = snapshot.get(ChatCollection.senderId);
    senderName = snapshot.get(ChatCollection.senderName);
    receiverId = snapshot.get(ChatCollection.receivingId);
    receiverName = snapshot.get(ChatCollection.receivingName);
    message = snapshot.get(ChatCollection.message);
    createdTime = snapshot.get(ChatCollection.date);
    receiverImageUrl = snapshot.get(ChatCollection.receiverImageUrl);
    senderImageUrl = snapshot.get(ChatCollection.senderImageUrl);
  }
}
