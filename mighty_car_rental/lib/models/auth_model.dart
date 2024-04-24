import 'package:flutter/material.dart';

class AuthModel extends ChangeNotifier {
  bool _isLogin = false;
  Map<String, dynamic> user = {};
  Map<String, dynamic> favVehicle = {};
  Map<String, dynamic> pendingList = {};
  Map<String, dynamic> approvedList = {};
  Map<String, dynamic> deniedList = {};
  Map<String, dynamic> vehicle = {};
  List<Map<String, dynamic>> favDoc = [];
  final List<dynamic> _fav = [];

  bool get isLogin {
    return _isLogin;
  }

  List<dynamic> get getFav {
    return _fav;
  }

  Map<String, dynamic> get getUser {
    return user;
  }

  Map<String, dynamic> get getFavVehicle {
    return favVehicle;
  }

  Map<String, dynamic> get getBooking {
    return pendingList;
  }

//when login success, update the status
  void loginSuccess(
      Map<String, dynamic> userData, Map<String, dynamic> vehicleInfo) {
    _isLogin = true;

    user = userData;
    vehicle = vehicleInfo;

    notifyListeners();
  }
}
