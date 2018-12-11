import 'dart:async';
import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import '../clases/tools/usuario.dart';

class BaseDeDatos {
  static Database _db;

  Future<Database> get db async {
    if(_db != null)
      return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);

    //await theDb.execute("CREATE TABLE Parametros(codigo TEXT, valor TEXT)");

    return theDb;
  }


  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE User(id INTEGER PRIMARY KEY, username TEXT, password TEXT)");
    await db.execute(
        "CREATE TABLE Parametros(codigo TEXT, valor TEXT)");
    print("Created tables");
  }

  Future<int> saveUser(Usuario user) async {
    var dbClient = await db;
    int res = await dbClient.insert("User", user.toMap());
    return res;
  }

  Future<int> deleteUsers() async {
    var dbClient = await db;
    int res = await dbClient.delete("User");
    return res;
  }

  Future<bool> isLoggedIn() async {
    var dbClient = await db;
    var res = await dbClient.query("User");
    return res.length > 0? true: false;
  }

  Future<String> usuario() async {
    var dbClient = await db;
    var res = await dbClient.query("User");
    return res.first['username'];
  }

/** Tutorial
 *
 */

  Future<int> saveTutorial() async {
    var dbClient = await db;

    var mapa = new Map<String, dynamic>();
    mapa["codigo"] = 'tutorial';
    mapa["valor"] = 'S';

    int res = await dbClient.insert("Parametros", mapa);
    print("Insertant tutorial : $res");
    return res;
  }

  Future<bool> empezadoTutorial() async {
    var dbClient = await db;
    var res = await dbClient.query("parametros",
        columns: ["valor"], //["title"],
        where: "codigo = 'tutorial'",
    );
    return res.length > 0? true: false;
  }

  Future<int> deleteTutorial() async {
    var dbClient = await db;

    int res = await dbClient.delete(
        "Parametros",
        where: "codigo = 'tutorial'",
    );
    return res;
  }

}