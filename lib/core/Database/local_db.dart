import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
late Database database;



crateDataBase() async {
// Get a location using getDatabasesPath
  var databasesPath = await getDatabasesPath();
  print(databasesPath);
  String path = join(databasesPath, "taskes.db");
  print(path);

// open the database
  database = await openDatabase(path, version: 1,
      // crate table
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db
            .execute(
            'CREATE TABLE Task (id INTEGER PRIMARY KEY, title TEXT, desc TEXT, date TEXT ,status TEXT)')
            .then((value) {
          print("table crated");
        });
      },
      onOpen: (database) {
        print("hello table ");
        getDataBase(database);
      });
}


insertDataBase({
  String? title,
  String? time,
  String? date,
}) {
  database.transaction((txn) async {
    await txn
        .rawInsert(
        'INSERT INTO Task (title, time, date, status) VALUES("$title" , "$time", "$date", "notDone")')
        .then((value) {
      print("$value inserted Successfully");
      getDataBase(database);

    }).catchError((error){print(error);});
  });
}

updateDatabase({String? title , String? time, String? date , int? id}){
  database.rawUpdate('UPDATE Task SET title = ?, time = ? ,date = ?  WHERE id = ?',
      [title, time, date, id]).then((value){
    print("$value is updated");
    getDataBase(database);
  });
}

updateStatus({String? status , int? id}){
  database.rawUpdate('UPDATE Task SET status = ?  WHERE id = ?',
      [status]).then((value){
    print("$value status is updated");
    getDataBase(database);
  });
}

// crud
deleteDataBase({int? id }){
  database.rawDelete('DELETE FROM Test WHERE id = ?', [id]).then((value){
    print("$value is deleted ");
    getDataBase(database);
  });
}

List<Map> tasksList =[];
List<Map> doneTasks =[];
getDataBase(Database dataBase){
  dataBase.rawQuery('SELECT * FROM Task').then((value){
    for(Map<String, Object?> element in value ){
      tasksList.add(element);
      if(element['status']== "Done"){
        doneTasks.add(element);
      }
    }

  }).catchError((error){
    print(error);
  });
}
