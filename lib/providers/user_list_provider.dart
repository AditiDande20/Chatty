import 'package:chatty/models/user_model.dart';
import 'package:flutter/foundation.dart';

class UserListProvider extends ChangeNotifier {
  List<UserModel> userModelList = [];

  List<UserModel>? get getUserModelList {
    return userModelList;
  }

  void setItem(List<UserModel> item) {
    userModelList = item;
    notifyListeners();
  }

  void addItem(List<UserModel> item) {
    userModelList.addAll(item);
    notifyListeners();
  }

  void removeItem(int index) {
    userModelList.removeAt(index);
    notifyListeners();
  }

  void setEmptyList() {
    userModelList = [];
    // notifyListeners();
  }
}
