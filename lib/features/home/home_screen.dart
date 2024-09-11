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
  //1-
  List<Map<String, dynamic>> tasks = [];

  @override
  void initState() {
    super.initState();
    _initializeDatabaseAndGetTasks();
  }

  Future<void> _initializeDatabaseAndGetTasks() async {
    await createDatabase();
    await getTask();
  }

  //2
  Future<void> getTask() async {
    tasks = await getDataFromDatabase();
    setState(() {});
  }

  Future<void> delteTask(int id) async {
    await updateTaskStatusToDone(id);
    await deleteFromDatabase(id);
    await getTask();
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
            ? Center(
                child: Text("no tasks"),
              )
            : Padding(
                padding: EdgeInsets.all(16),
                child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return CardTodolist(
                        title: tasks[index]['title'] ?? '',
                        desc: tasks[index]['description'] ?? '',
                        onDelete: () => delteTask(tasks[index]['id']),
                      );
                    }),
              ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () async {
              final res = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddTaskScreen()));

              if (res != null) {
                //3
                insertIntoDatabase(
                    title: res['title'],
                    desc: res['description'],
                    date: DateTime.now().toString());
                await getTask();
              }
            }));
  }
}
