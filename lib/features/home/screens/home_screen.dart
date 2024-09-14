import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_test/features/home/screens/welcomScreen.dart';
import '../../../core/Database/local_db.dart';
import '../../../core/Provider/task_provider.dart';
import '../../../core/Provider/user_Provider.dart';
import '../../../core/sheardprefrance/shaerd.dart';
import '../../add_task/add_task_screen.dart';
import '../widgets/tasklist.dart';
import '../widgets/todo_card.dart';


class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _name;
  final SharedPreferenceHelper _prefsHelper = SharedPreferenceHelper();



  @override
  void initState() {
    super.initState();
    initDb();
  }


  Future<void> initDb() async {
    await createDatabase();
    await Provider.of<TaskProvider>(context, listen: false).loadTasks();
    loadName();

  }

  Future<void> loadName() async {
    String? name = await _prefsHelper.getName();
    setState(() {
      _name = name;
    });
  }

  void _logout() async {
    await deleteAllTasks();
    await _prefsHelper.clearName();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => WelcomeScreen()),
    );
  }
  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    // final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Tasks of ${_name}"),
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
