import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDb {
  static Database? _database;

  Future<Database?> get database async {
    if (_database == null) {
      _database = await initialDb();
      return _database;
    } else {
      return _database;
    }
  }

  initialDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'sqldb.db');
    Database database = await openDatabase(path,
        version: 4, onCreate: onCreate, onUpgrade: onUpgrade);

    return database;
  }

  Future<void> onCreate(Database database, int version) async {
    Batch batch = database.batch();
    batch.execute('''
         
          CREATE TABLE IF NOT EXISTS notes(
            id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
            title TEXT NOT NULL,
            notes TEXT NOT NULL,
            color TEXT NOT NULL
           
            )
        ''');

    print('database sqldb created');

    await batch.commit();
  }

  onUpgrade(Database? db, int oldVersion, int newVersion) async {
    print('onUpgrade');
  }

  readData(String sql) async {
    final Database? db = await database;
    List<Map<String, Object?>> response = await db!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    final Database? db = await database;
    int response = await db!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    final Database? db = await database;
    int response = await db!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    final Database? db = await database;
    int response = await db!.rawDelete(sql);
    return response;
  }

  static deleteDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'sqldb.db');
    await deleteDatabase(path);
    print("database is deleted");
  }
}
