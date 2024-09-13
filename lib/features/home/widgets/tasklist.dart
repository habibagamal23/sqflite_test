import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/Provider/task_provider.dart';
import '../widgets/todo_card.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    if (taskProvider.tasks.isEmpty) {
      return const Center(
        child: Text("Welcome, add your task"),
      );
    }

    return ListView.builder(
      itemCount: taskProvider.tasks.length,
      itemBuilder: (context, index) {
        return CardTodolist(
          title: taskProvider.tasks[index]['title'] ?? '',
          desc: taskProvider.tasks[index]['desc'] ?? '',
          onDelete: () => taskProvider.deleteTask(taskProvider.tasks[index]['id']),
        );
      },
    );
  }
}
