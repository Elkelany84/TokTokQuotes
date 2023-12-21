import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

//initiate the database
  initialDb() async {
//store database location
    String databasePath = await getDatabasesPath();
//join databasepath with its name
    String path = join(databasePath, 'elkelany.db');

    //create database for the first time
    Database mydb = await openDatabase(path, onCreate: _onCreate, version: 1);
    //OPTIONAL TO ADD MORE TABLES WHEN YOU CHANGE THE VERSION WHILE CREATING,onupgrade called when version changed
    // Database mydb = await openDatabase(path,
    //     onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);

    return mydb;
  }

  // _onUpgrade(Database db, int oldversion, int newversion) async {
  //   print('onupgrade==================');
  // await db.execute('ALTER TABLE notes ADD COLUMN color TEXT');
  // }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE favorites(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,title TEXT NOT NULL,category TEXT)');
    print('oncreate===============');
  }

  //PREFERED COMMAND TO CREATE MLUTIPLE/SINGLE/ADD ONE TABLE
  // _onCreate(Database db, int version) async {
  //   Batch batch = db.batch();
  //    batch.execute(
  //       'CREATE TABLE notes(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,title TEXT NOT NULL,details TEXT NOT NULL,color TEXT NOT NULL)');
  //        batch.execute(
  //       'CREATE TABLE students(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,title TEXT NOT NULL,details TEXT NOT NULL,color TEXT NOT NULL)');
  // await batch.commit();
  //   print('oncreate===============');
  // }

//SELECT
  readData(String sql) async {
    Database? mydb = await db;
    List<Map> respons = await mydb!.rawQuery(sql);
    return respons;
  }

//INSERT
  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

//UPDATE
  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

//DELETE
  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

//DELETE DATABASE
  deleteMyDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'elkelany.db');
    await deleteDatabase(path);
  }



//(SHORT FUNCTIONS)
  //SELECT
  readShort(String table) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.query(table);
    return response;
  }

//INSERT
  insertShort(String table,Map<String, Object?>values) async {
    Database? mydb = await db;
    int response = await mydb!.insert(table,values);
    return response;
  }

//UPDATE
  updateShort(String table,Map<String, Object?> values,String myWhere) async {
    Database? mydb = await db;
    int response = await mydb!.update(table,values,where: myWhere);
    return response;
  }

//DELETE
  deleteShort(String table,String myWhere) async {
    Database? mydb = await db;
    int response = await mydb!.delete(table,where: myWhere);
    return response;
  }
}



//EXAMPLES

//  Center(
//               child: MaterialButton(
//                 color: Colors.red,
//                 textColor: Colors.white,
//                 onPressed: () async {
//                   List<Map> response =
//                       await sqlDb.readData('SELECT * FROM notes');
//                   print(response);
//                 },
//                 child: Text('ReadData'),
//               ),
//             ),
//             Center(
//               child: MaterialButton(
//                 color: Colors.red,
//                 textColor: Colors.white,
//                 onPressed: () async {
//                   int response = await sqlDb.updateData("UPDATE 'notes' SET note = 'eight note' WHERE id = 4");
//                   print(response);
//                 },
//                 child: Text('UpdateData'),
//               ),
//             ),
//             Center(
//               child: MaterialButton(
//                 color: Colors.red,
//                 textColor: Colors.white,
//                 onPressed: () async {
//                   int response = await sqlDb.deleteData(
//                     'DELETE FROM notes WHERE id = 3',
//                   );
//                   print(response);
//                 },
//                 child: Text('deleteData'),
//               ),
//             ),