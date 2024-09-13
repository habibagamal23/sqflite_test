import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_test/features/home/screens/welcomScreen.dart';
import '../../../core/Database/local_db.dart';
import '../../../core/Provider/task_provider.dart';
import '../../../core/Provider/user_provider.dart';
import '../../add_task/add_task_screen.dart';
import '../widgets/tasklist.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    initDbAndLoadData();
  }

  Future<void> initDbAndLoadData() async {
    await initDb();
    await Provider.of<TaskProvider>(context, listen: false).loadTasks();
  }

  Future<void> initDb() async {
    await createDatabase();
    // Load the name from the UserProvider
    await Provider.of<UserProvider>(context, listen: false).loadName();
  }

  void _logout() async {
    // Delete all tasks from the local database
    await deleteAllTasks();
    // Clear the name using UserProvider
    await Provider.of<UserProvider>(context, listen: false).clearName();
    // Navigate back to the WelcomeScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => WelcomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Access TaskProvider and UserProvider
    final taskProvider = Provider.of<TaskProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        // Display the user's name from the UserProvider
        title: Text("Tasks of ${userProvider.name ?? 'Guest'}"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: TaskList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskScreen()),
          );
        },
      ),
    );
  }
}
