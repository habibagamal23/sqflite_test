import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/Provider/user_Provider.dart';
import '../../../core/sheardprefrance/shaerd.dart';
import 'home_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  final SharedPreferenceHelper _prefsHelper = SharedPreferenceHelper();

  @override
  void initState() {
    super.initState();
    _checkIfNameExists();
  }

  void _checkIfNameExists() async {
    String? name = await _prefsHelper.getName();
    if (name != null && name.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }
  void _goToNextScreen() async {
    String name = _nameController.text;
    if (name.isNotEmpty) {
      await _prefsHelper.setName(name);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
      print('Welcome, $name');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your name')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Welcome to our TodoList app',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _goToNextScreen,
              child: const Text('Go'),
            ),
          ],
        ),
      ),
    );
  }
}
