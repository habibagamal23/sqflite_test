import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  static const String _nameKey = "username";
  String? _name;

  String? get name => _name;

  // Load the name from shared preferences
  Future<void> loadName() async {
    final prefs = await SharedPreferences.getInstance();
    _name = prefs.getString(_nameKey);
    notifyListeners(); // Notify listeners that the name has been loaded
  }

  // Set the name and save it in shared preferences
  Future<void> setName(String name) async {
    _name = name;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_nameKey, name);
    notifyListeners(); // Notify listeners that the name has changed
  }

  // Clear the name from shared preferences
  Future<void> clearName() async {
    _name = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_nameKey);
    notifyListeners();
  }
}
