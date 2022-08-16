import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  final _databaseName = "test.db";
  final _databaseVersion = 1;

  final table = 'teste';

  final columnId = 'id';
  final columnName = 'name';
  final columnCodigoBene = 'codigoBene';
  final columnDataNasc = 'dataNasc';
  final columnSexo = 'sexo';
  final columnTelefone = 'telefone';
  final columnCidade = 'cidade';

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
            $columnCodigoBene TEXT NOT NULL,
            $columnDataNasc TEXT NOT NULL,
            $columnSexo TEXT NOT NULL,
            $columnTelefone TEXT NOT NULL,
            $columnCidade TEXT NOT NULL
          )
          ''');
  }

  Future<int> insert(
      {required String nome,
      required String codigoBene,
      required String dataNasc,
      required String sexo,
      required String telefone,
      required String cidade}) async {
    Database db = await instance.database;
    return await db.insert(table, {
      'name': nome,
      'codigoBene': codigoBene,
      'dataNasc': dataNasc,
      'sexo': sexo,
      'telefone': telefone,
      'cidade': cidade
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
