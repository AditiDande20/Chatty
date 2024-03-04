import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetChecking {
  static final InternetChecking _singleton = InternetChecking._internal();

  factory InternetChecking() {
    return _singleton;
  }

  InternetChecking._internal();

  Future<bool> isInternet() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile) {
        // I am connected to a mobile network, make sure there is actually a net connection.
        if (await InternetConnectionChecker().hasConnection) {
          // Mobile data detected & internet connection confirmed.
          return true;
        } else {
          // Mobile data detected but no internet connection found.
          debugPrint("Mobile data detected but no internet connection found.");
          return false;
        }
      } else if (connectivityResult == ConnectivityResult.wifi) {
        // I am connected to a WIFI network, make sure there is actually a net connection.
        if (await InternetConnectionChecker().hasConnection) {
          // Wifi detected & internet connection confirmed.
          return true;
        } else {
          // Wifi detected but no internet connection found.
          debugPrint("Wifi detected but no internet connection found.");
          return false;
        }
      } else {
        // Neither mobile data or WIFI detected, not internet connection found.
        debugPrint(
            "Neither mobile data or WIFI detected, not internet connection found.");
        return false;
      }
    } on SocketException catch (_) {
      debugPrint("SocketException, not internet connection found.");
      return false;
    }
  }
}
