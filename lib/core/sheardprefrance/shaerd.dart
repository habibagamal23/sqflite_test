import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static const String _keyName = 'name';

  Future<void> setName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyName, name);
  }

  Future<String?> getName() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyName);
  }

  Future<void> clearName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyName);
  }
}
