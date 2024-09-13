import 'package:flutter/material.dart';
import '../../../core/Database/local_db.dart';  // Ensure your local DB helper is correctly imported

class TaskProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _tasks = [];

  List<Map<String, dynamic>> get tasks => _tasks;

  Future<void> loadTasks() async {
    _tasks = await getDataFromDatabase();
    notifyListeners();  // Notify the UI to rebuild when tasks change
  }

  Future<void> addTask(String title, String desc) async {
    await insertIntoDatabase(
      title: title,
      desc: desc,
      date: DateTime.now().toString(),
    );
    await loadTasks();  // Refresh task list
  }

  Future<void> deleteTask(int id) async {
    await deleteFromDatabase(id);
    await loadTasks();  // Refresh task list
  }

  Future<void> deleteAllTasks() async {
    await deleteAllTasks();
    _tasks.clear();  // Clear local tasks list
    notifyListeners();  // Notify the UI
  }
}
