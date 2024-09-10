import 'package:flutter/material.dart';

import '../add_task/add_task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
        body: Center(
          child: Text("no task here "),
        ),
        floatingActionButton: FloatingActionButton(
            child:  Icon(Icons.add),
            onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddTaskScreen()));
        }
        )
    );
  }
}
