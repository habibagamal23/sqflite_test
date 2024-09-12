import 'package:flutter/material.dart';
import 'package:sqflite_test/features/home/screens/welcomScreen.dart';
import 'package:sqflite_test/features/home/widgets/todo_card.dart';

import '../../../core/Database/local_db.dart';
import '../../../core/sheardprefrance/shaerd.dart';
import '../../add_task/add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> tasks = [];
  String? _name;
  final SharedPreferenceHelper _prefsHelper = SharedPreferenceHelper();

  @override
  void initState() {
    super.initState();
    Intia();
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

  Future<void> Intia() async {
    await createDatabase();
    await getTasksFromDatabase();
  }

  Future<void> getTasksFromDatabase() async {
    tasks = await getDataFromDatabase();
    setState(() {});
  }

  Future<void> deleteTask(int id) async {
    await updateTaskStatusToDone(id);
    await deleteFromDatabase(id);
    await getTasksFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Taskes  ${_name} "),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],

      ),
      body: _buildTaskList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final res = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskScreen()),
          );

          if (res != null) {
            await insertIntoDatabase(
              title: res['title'],
              desc: res['description'],
              date: DateTime.now().toString(),
            );
            await getTasksFromDatabase();
          }
        },
      ),
    );
  }

  Widget _buildTaskList() {
    if (tasks.isEmpty) {
      return Center(child: Text("Wlcome ${_name} Add u TAsk"));
    }
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return CardTodolist(
          title: tasks[index]['title'] ?? '',
          desc: tasks[index]['desc'] ?? '',
          onDelete: () => deleteTask(tasks[index]['id']),
        );
      },
    );
  }
}
