import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/Provider/task_provider.dart';
import 'core/Provider/user_provider.dart';
import 'features/home/screens/welcomScreen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()), // Add UserProvider here
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Provider & SharedPreferences Demo',
      home: WelcomeScreen(),
    );
  }
}
