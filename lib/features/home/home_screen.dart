import 'package:flutter/material.dart';
import 'package:sqflite_test/features/home/widgets/todo_card.dart';

import '../../core/Database/local_db.dart';
import '../add_task/add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> tasks = [];

  @override
  void initState() {
    super.initState();
    createDatabase();
    getTasksFromDatabase();
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

  @override
  Widget build(BuildContext context) {
    // app bar
    //text
    //float
    return Scaffold(
      appBar: AppBar(
        title: Text("Taskes"),
        centerTitle: true,
      ),
      body: tasks.isEmpty
          ? Center(child: Text("No tasks available"))
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return CardTodolist(
                  title: tasks[index]['title'] ?? '',
                  desc: tasks[index]['desc'] ?? '',
                  onDelete: () => deleteTask(tasks[index]['id'])
                );
              },
            ),
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
}
