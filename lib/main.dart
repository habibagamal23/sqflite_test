import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_test/features/home/screens/home_screen.dart';

import 'core/Provider/task_provider.dart';
import 'core/Provider/user_Provider.dart';
import 'features/home/screens/welcomScreen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
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
      home: WelcomeScreen()


    );
  }
}
