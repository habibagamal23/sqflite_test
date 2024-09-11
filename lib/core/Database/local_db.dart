import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

late Database database;

Future<void> createDatabase() async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, "tasks.db");

  database = await openDatabase(path, version: 1,
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

updateDatabase({
  String? title,
  String? desc,
  String? date,
  int? id,
}) async {
  await database.rawUpdate(
      'UPDATE Task SET title = ?, desc = ?, date = ? WHERE id = ?',
      [title, desc, date, id]).then((value) {
    print("$value record updated");
    getDataFromDatabase();
  }).catchError((error) {
    print("Error updating data: $error");
  });
}

updateStatus({
  String? status,
  int? id,
}) async {
  await database.rawUpdate(
      'UPDATE Task SET status = ? WHERE id = ?', [status, id]).then((value) {
    print("$value status updated");
    getDataFromDatabase();
  }).catchError((error) {
    print("Error updating status: $error");
  });
}

deleteFromDatabase({int? id}) async {
  await database.rawDelete('DELETE FROM Task WHERE id = ?', [id]).then((value) {
    print("$value record deleted");
    getDataFromDatabase();
  }).catchError((error) {
    print("Error deleting data: $error");
  });
}

Future<List<Map<String, dynamic>>> getDataFromDatabase() async {
  return await database.rawQuery('SELECT * FROM Task');
}
