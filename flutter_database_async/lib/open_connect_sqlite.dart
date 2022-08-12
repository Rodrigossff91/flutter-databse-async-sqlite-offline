import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  final _databaseName = "test.db";
  final _databaseVersion = 1;

  final table = 'teste';

  final columnId = 'id';
  final columnName = 'name';
  final columnSobrenome = 'sobrenome';
  final columnEmail = 'email';
  final columnCfm = 'cfm';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnName TEXT NOT NULL,
            $columnSobrenome TEXT NOT NULL,
            $columnEmail TEXT NOT NULL,
            $columnCfm TEXT NOT NULL
          )
          ''');
  }

  Future<int> insert(
      {required String nome,
      required String sobrenome,
      required String email,
      required String cfm}) async {
    Database db = await instance.database;
    return await db.insert(table, {
      'name': nome,
      'sobrenome': sobrenome,
      'email': email,
      'cfm': cfm,
    });
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  // Future<int> update({required int id}) async {
  //   Database db = await instance.database;

  //   return await db
  //       .update(table, car.toMap(), where: '$columnId = ?', whereArgs: [id]);
  // }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
