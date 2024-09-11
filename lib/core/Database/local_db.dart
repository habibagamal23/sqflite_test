
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

late Database database;

Future<void> createDatabase() async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, "tasks.db");

  database = await openDatabase(path, version: 2,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE Task (id INTEGER PRIMARY KEY, title TEXT, desc TEXT, date TEXT, status TEXT)',
        );
        print("Table created");
      }, onOpen: (database) {
        print("Database opened");
      });
}

Future<void> insertIntoDatabase({
  required String title,
  required String desc,
  required String date,
}) async {
  await database.transaction((txn) async {
    await txn.rawInsert(
      'INSERT INTO Task (title, desc, date, status) VALUES(?, ?, ?, ?)',
      [title, desc, date, "notDone"],
    );
    print("Task inserted");
  });
}

Future<void> updateTaskStatusToDone(int id) async {
  await database
      .rawUpdate('UPDATE Task SET status = ? WHERE id = ?', ['Done', id]);
  print("Task status updated to Done");
}

Future<void> deleteFromDatabase(int id) async {
  await database.rawDelete('DELETE FROM Task WHERE id = ?', [id]);
  print("Task deleted");
}

Future<List<Map<String, dynamic>>> getDataFromDatabase() async {
  return await database.rawQuery('SELECT * FROM Task');
}