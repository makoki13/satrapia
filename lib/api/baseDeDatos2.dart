import 'package:path/path.dart';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import '../clases/tools/usuario.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null)
      return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "satrapia_004.db");
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE User(id INTEGER PRIMARY KEY, username TEXT, password TEXT)");
      await db.execute("CREATE TABLE Parametros(codigo TEXT, valor TEXT)");

      await db.execute("CREATE TABLE Dispatcher(codigo INTEGER PRIMARY KEY, valor TEXT)");
      await db.execute("CREATE TABLE Jugador(id INTEGER PRIMARY KEY, usuario INTEGER, nombre TEXT, tipo INTEGER)");
      /* Tipo: 1: Imperio 2: Tribu */
      await db.execute("CREATE TABLE Imperio(id INTEGER PRIMARY KEY, jugador INTEGER, nombre TEXT, tipo INTEGER)");
      await db.execute("CREATE TABLE Provincia(id INTEGER PRIMARY KEY, jugador INTEGER, nombre TEXT, tribu INTEGER, satrapia INTEGER)");
      await db.execute("CREATE TABLE Capital(id INTEGER PRIMARY KEY, nombre TEXT, provincia INTEGER, x INTEGER, y INTEGER, z INTEGER)");
      await db.execute("CREATE TABLE Palacio(id INTEGER PRIMARY KEY, nombre TEXT, capital INTEGER)");
      await db.execute("""
        CREATE TABLE Silos(
          id INTEGER PRIMARY KEY, nombre TEXT, capital INTEGER, 
          comida_stock INTEGER, comida_capacidad INTEGER, 
          madera_stock INTEGER, madera_capacidad INTEGER, 
          piedra_stock INTEGER, piedra_capacidad INTEGER,
          hierro_stock INTEGER, hierro_capacidad INTEGER
        )
      """);
      await db.execute("CREATE TABLE Cuartel(id INTEGER PRIMARY KEY, nombre TEXT, capital INTEGER)");
      await db.execute("CREATE TABLE CentroDeInvestigacion(id INTEGER PRIMARY KEY, nombre TEXT, capital INTEGER)");

    });
  }

  Future<int> saveUser(Usuario user) async {
    var dbClient = await database;
    var res = await dbClient.rawInsert(
        "INSERT Into User (id,username,password)"
            " VALUES (1, '${user.username}','${user.password}')");
    return res;
  }

  Future<int> deleteUsers() async {
    var dbClient = await database;
    dbClient.rawDelete("Delete * from User");
  }

  Future<bool> isLoggedIn() async {
    var dbClient = await database;
    var res = await dbClient.query("User");
    return res.length > 0? true: false;
  }

  Future<String> usuario() async {
    var dbClient = await database;
    var table = await dbClient.rawQuery("SELECT username FROM User");
    String usuario = table.first["username"];
    return usuario;
  }

  /** Tutorial
   *
   */

  Future<int> saveTutorial() async {
    var dbClient = await database;

    var mapa = new Map<String, dynamic>();
    mapa["codigo"] = 'tutorial';
    mapa["valor"] = 'S';

    int res = await dbClient.insert("Parametros", mapa);
    print("Insertant tutorial : $res");
    return res;
  }

  Future<bool> empezadoTutorial() async {
    var dbClient = await database;
    var res = await dbClient.query("parametros",
      columns: ["valor"], //["title"],
      where: "codigo = 'tutorial'",
    );
    return res.length > 0? true: false;
  }

  Future<int> deleteTutorial() async {
    var dbClient = await database;

    int res = await dbClient.delete(
      "Parametros",
      where: "codigo = 'tutorial'",
    );
    return res;
  }

  /** Partida nueva
  *
  */
  Future<int> salvaPartidaNueva() async {
    var dbClient = await database;
    var res = await dbClient.rawInsert("INSERT Into Parametros (codigo,valor) VALUES ('Partida Nueva', 1)");
    return res;
  }

  Future<int> deletePartidaNueva() async {
    var dbClient = await database;
    dbClient.rawDelete("Delete from Parametros WHERE Codigo='Partida Nueva'");
  }

  Future<bool> hayPartidaNueva() async {
    var dbClient = await database;
    var table = await dbClient.rawQuery("SELECT COUNT(*) FROM Parametros WHERE Codigo='Partida Nueva'");
    int resultado = Sqflite.firstIntValue(table);
    print("Resultado: $resultado");
    return (resultado > 0);
  }
}