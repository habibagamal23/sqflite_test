import 'package:flutter/material.dart';
import 'package:sqflite_test/features/home/widgets/todo_card.dart';

import '../../../core/Database/local_db.dart';
import '../../../core/sheardprefrance/shaerd.dart';
import '../../add_task/add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> tasks = [];
  // final SharedPreferencesHelper _prefsHelper = SharedPreferencesHelper();
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    createDatabase();
    getTasksFromDatabase();
    // _loadTheme();
  }

  Future<void> getTasksFromDatabase() async {
    tasks = await getDataFromDatabase();
    setState(() {});
  }

  Future<void> deleteTask(int id) async {
    await updateTaskStatusToDone(id);
    await deleteFromDatabase(id);
    getTasksFromDatabase();
  }

  // void _toggleDarkMode() async {
  //   isDarkMode = !isDarkMode;
  //   await _prefsHelper.setTheme(isDarkMode); // حفظ حالة الثيم
  //   setState(() {});
  // }
  //
  // Future<void> _loadTheme() async {
  //   isDarkMode = await _prefsHelper.getTheme(); // استرجاع حالة الثيم
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    // app bar
    //text
    //float
    return Scaffold(
      appBar: AppBar(
        title: Text("Taskes"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: (){},
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
            getTasksFromDatabase();
          }
        },
      ),
    );
  }

  Widget _buildTaskList() {
    if (tasks.isEmpty) {
      return Center(child: Text("No tasks available"));
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
