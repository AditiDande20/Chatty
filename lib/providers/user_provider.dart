import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserProvider with ChangeNotifier, DiagnosticableTreeMixin {
  Map userData = {};

  UserProvider() {
    initUserProvider();
  }

  void initUserProvider() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _userData = (prefs.get('userData').toString());
    userData = _userData != "null" ? json.decode(_userData) as Map : {};
    notifyListeners();
  }

  void doAddUser(response) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userData = response;
    await prefs.setString('userData', json.encode(userData));
    notifyListeners();
  }

  void doUpdateUser(response) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userData['auth']['user'] = response;
    await prefs.setString('userData', json.encode(userData));
    notifyListeners();
  }

  void doRemoveUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userData = {};
    await prefs.remove('userData');
    notifyListeners();
  }

  
}
