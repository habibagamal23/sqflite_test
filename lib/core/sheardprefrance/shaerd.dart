import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static const String _nameKey = "username";

  // Get the stored name
  Future<String?> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_nameKey);
  }

  // Set the name in shared preferences
  Future<void> setName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_nameKey, name);
  }

  // Clear the name
  Future<void> clearName() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_nameKey);
  }
}
