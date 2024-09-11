// import 'package:shared_preferences/shared_preferences.dart';
//
// class SharedPreferencesHelper {
//   static const String themeKey = 'isDarkMode';
//
//   // حفظ حالة الثيم
//   Future<void> setTheme(bool isDarkMode) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool(themeKey, isDarkMode);
//   }
//
//   // استرجاع حالة الثيم
//   Future<bool> getTheme() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getBool(themeKey) ?? false; // افتراضياً الوضع النهاري
//   }
// }
