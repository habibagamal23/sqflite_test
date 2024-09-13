// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class UserProvider extends ChangeNotifier {
//   bool _isAuthorized = false;
//   String? _userName;
//
//   bool get isAuthorized => _isAuthorized;
//   String? get userName => _userName;
//
//   Future<void> tryLogin() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     _userName = prefs.getString('userName');
//     _isAuthorized = _userName != null;
//     notifyListeners();
//   }
//
//   Future<void> saveName(String name) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('userName', name);
//     _userName = name;
//     _isAuthorized = true;
//     notifyListeners();
//   }
//
//   Future<void> logout() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.remove('userName');
//     _isAuthorized = false;
//     _userName = null;
//     notifyListeners();
//   }
// }
