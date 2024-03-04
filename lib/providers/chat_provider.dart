import 'package:chatty/models/chat_model.dart';
import 'package:flutter/foundation.dart';

class ChatListProvider extends ChangeNotifier {
  List<ChatModel> chatModelList = [];

  List<ChatModel>? get getChatModelList {
    return chatModelList;
  }

  void setItem(List<ChatModel> item) {
    chatModelList = item;
    notifyListeners();
  }

  void addItem(List<ChatModel> item) {
    chatModelList.addAll(item);
    notifyListeners();
  }

  void removeItem(int index) {
    chatModelList.removeAt(index);
    notifyListeners();
  }

  void setEmptyList() {
    chatModelList = [];
  }
}
