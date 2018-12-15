import 'package:path/path.dart';
import 'package:satrapia/clases/juego/Almacen.clase.dart';
import 'package:satrapia/clases/juego/Capital.clase.dart';
import 'package:satrapia/clases/juego/CentroDeInvestigacion.clase.dart';
import 'package:satrapia/clases/juego/Cuartel.clase.dart';
import 'package:satrapia/clases/juego/Dispatcher.clase.dart';
import 'package:satrapia/clases/juego/Imperio.clase.dart';
import 'package:satrapia/clases/juego/Jugador.clase.dart';
import 'package:satrapia/clases/juego/Palacio.clase.dart';
import 'package:satrapia/clases/juego/Parametros.clase.dart';
import 'package:satrapia/clases/juego/Punto.clase.dart';
import 'package:satrapia/clases/juego/Recurso.clase.dart';
import 'package:satrapia/clases/juego/Silos.clase.dart';
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
    String path = join(documentsDirectory.path, "satrapia_007.db");
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE User(id INTEGER PRIMARY KEY, username TEXT, password TEXT)");
      await db.execute("CREATE TABLE Parametros(codigo TEXT, valor TEXT)");

      await db.execute("CREATE TABLE Dispatcher(codigo INTEGER PRIMARY KEY, valor TEXT)");
      await db.execute("CREATE TABLE Jugador(id INTEGER PRIMARY KEY, usuario INTEGER, nombre TEXT, tipo INTEGER)");
      /* Tipo: 1: Imperio 2: Tribu */
      await db.execute("CREATE TABLE Imperio(id INTEGER PRIMARY KEY, jugador INTEGER, nombre TEXT, tipo INTEGER)");
      await db.execute("CREATE TABLE Provincia(id INTEGER PRIMARY KEY, jugador INTEGER, nombre TEXT, tribu INTEGER, satrapia INTEGER)");
      await db.execute("CREATE TABLE Ciudad(id INTEGER PRIMARY KEY, nombre TEXT, provincia INTEGER, x INTEGER, y INTEGER, z INTEGER, esCapital INTEGER)");
      await db.execute("CREATE TABLE Palacio(id INTEGER PRIMARY KEY, nombre TEXT, capital INTEGER, oro INTEGER, poblacion INTEGER)");
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
    return dbClient.rawDelete("Delete from Parametros WHERE Codigo='Partida Nueva'");
  }

  Future<bool> hayPartidaNueva() async {
    var dbClient = await database;
    var table = await dbClient.rawQuery("SELECT COUNT(*) FROM Parametros WHERE Codigo='Partida Nueva'");
    int resultado = Sqflite.firstIntValue(table);
    print("Resultado: $resultado");
    return (resultado > 0);
  }

  /* Dispatcher */
  Future<int> borraDispatcher() async {
    var dbClient = await database;
    return dbClient.rawDelete("Delete from Dispatcher");
  }

  Future<int> insertaDispatcher(int i, String s) async {
    var dbClient = await database;
    var res = await dbClient.rawInsert("INSERT Into Dispatcher (codigo,valor) VALUES ($i, '$s')");
    return res;
  }

  /* Jugador */

  Future<int> borraJugador() async {
    var dbClient = await database;
    return dbClient.rawDelete("Delete from Jugador");
  }

  Future<int> insertaJugador(Jugador jugador, int i, String s, TipoJugador emperador) async {
    var dbClient = await database;
    var res = await dbClient.rawInsert("INSERT Into Jugador (id, usuario, nombre, tipo) VALUES (${jugador.getID()}, $i, '$s', ${emperador.index})");
    return res;
  }

  /* Imperio */

  Future<int> borraImperio() async {
    var dbClient = await database;
    return dbClient.rawDelete("Delete from Imperio");
  }

  Future<int> insertaImperio(int i, String s, Jugador jugador, bool param3) async {
    var dbClient = await database;

    int tipo = 0; if (param3==true) tipo = 1;

    var res = await dbClient.rawInsert("INSERT Into Imperio (id, jugador, nombre, tipo) VALUES ($i, ${jugador.getID()}, '$s', $tipo)");
    return res;
  }

  /* Provincia */

  Future<int> borraProvincia() async {
    var dbClient = await database;
    return dbClient.rawDelete("Delete from Provincia");
  }

  Future<int> insertaProvincia(int i, String s, Jugador jugador, bool param3, bool param4) async {
    var dbClient = await database;

    int tribu = 0; if (param3==true) tribu = 1;
    int satrapia = 0; if (param4==true) satrapia = 1;

    var res = await dbClient.rawInsert("INSERT Into Provincia (id, jugador, nombre, tribu, satrapia) VALUES ($i, ${jugador.getID()}, '$s', $tribu, $satrapia)");
    return res;
  }

  /* Ciudad */

  Future<int> borraCiudad() async {
    var dbClient = await database;
    return dbClient.rawDelete("Delete from Ciudad");
  }

  Future<int> insertaCiudad(int i, String s, Provincia provincia, Punto posicion, esCapital) async {
    var dbClient = await database;

    int _esCapital = 0; if (esCapital==true) _esCapital = 1;

    var res = await dbClient.rawInsert("""
      INSERT Into Ciudad (id, nombre, provincia, x, y, z, esCapital) VALUES ($i, '$s', ${provincia.getID()}, ${posicion.getX()}, ${posicion.getY()}, ${posicion.getZ()}, $_esCapital )
      """);
    return res;
  }

  /* Palacio */

  Future<int> borraPalacio() async {
    var dbClient = await database;
    return dbClient.rawDelete("Delete from Palacio");
  }

  Future<int> insertaPalacio(int i, String s, Capital capital) async {
    var dbClient = await database;
    var res = await dbClient.rawInsert("INSERT Into Palacio (id, nombre, capital, oro, poblacion) VALUES ($i, '$s', ${capital.getID()}, ${Parametros.oroInicial}, 0)");
    return res;
  }

  /* Silos */

  Future<int> borraSilos() async {
    var dbClient = await database;
    return dbClient.rawDelete("Delete from Silos");
  }

  Future<int> insertaSilos(int i, String s, Capital capital, int comidaStock, num comidaCapacidad, int maderaStock, num maderaCapacidad, int piedraStock, num piedraCapacidad,
      int hierroStock, num hierroCapacidad) async {
    var dbClient = await database;
    var res = await dbClient.rawInsert("""
      INSERT Into Silos (id, nombre, capital, comida_stock, comida_capacidad, madera_stock, madera_capacidad, piedra_stock, piedra_capacidad, hierro_stock, hierro_capacidad) 
      VALUES ($i, '$s', ${capital.getID()}, $comidaStock, $comidaCapacidad, $maderaStock, $maderaCapacidad, $piedraStock, $piedraCapacidad, $hierroStock, $hierroCapacidad)
      """);
    return res;
  }

  /* Cuartel */
  Future<int> borraCuartel() async {
    var dbClient = await database;
    return dbClient.rawDelete("Delete from Cuartel");
  }

  Future<int> insertaCuartel(int i, String s, Capital capital) async {
    var dbClient = await database;
    var res = await dbClient.rawInsert("INSERT Into Cuartel (id, nombre, capital) VALUES ($i, '$s', ${capital.getID()})");
    return res;
  }

  /* Centro de investigación */

  Future<int> borraCentroDeInvestigacion() async {
    var dbClient = await database;
    return dbClient.rawDelete("Delete from CentroDeInvestigacion");
  }

  Future<int> insertaCentroDeInvestigacion(int i, String s, Capital capital) async {
    var dbClient = await database;
    var res = await dbClient.rawInsert("INSERT Into CentroDeInvestigacion (id, nombre, capital) VALUES ($i, '$s', ${capital.getID()})");
    return res;
  }








  /* CREATE TABLE Jugador(id INTEGER PRIMARY KEY, usuario INTEGER, nombre TEXT, tipo INTEGER) */
  Future<Jugador> getJugador(int id) async {
    TipoJugador _tipoJugador;

    var dbClient = await database;
    String sql = "SELECT Usuario,Nombre,Tipo FROM Jugador WHERE ID=$id";
    var table = await dbClient.rawQuery(sql);
    print ("SQL $sql : filas $table");
    print("Jugador: ${table.first}");
    int _usuario = table.first["usuario"];
    String _nombre = table.first["nombre"];
    int _tipo = table.first["tipo"];
    switch(_tipo) {
      case 0:
        _tipoJugador = TipoJugador.SIN_JUEGO;
        break;
      case 1:
        _tipoJugador = TipoJugador.EMPERADOR;
        break;
      case 2:
        _tipoJugador = TipoJugador.SATRAPA;
        break;
      case 3:
        _tipoJugador = TipoJugador.JEFE_DE_TRIBU;
        break;
    }

    Jugador _jugador = Jugador(id, _usuario, _nombre, _tipoJugador);

    return _jugador;
  }

  /* CREATE TABLE Imperio(id INTEGER PRIMARY KEY, jugador INTEGER, nombre TEXT, tipo INTEGER) */
  Future<Imperio> getImperio(Jugador jugador) async {
    var dbClient = await database;
    var table = await dbClient.rawQuery("SELECT Id,Nombre,Tipo FROM Imperio WHERE Jugador=${jugador.getID()}");
    print("Imperio: ${table.first}");
    int _id = table.first["id"];
    String _nombre = table.first["nombre"];
    int _tipo = table.first["tipo"]; bool _esTribu = false; if (_tipo==1) _esTribu = true;

    Imperio _imperio = Imperio(_id, _nombre, jugador, _esTribu);
    return _imperio;
  }

  /* CREATE TABLE Provincia(id INTEGER PRIMARY KEY, jugador INTEGER, nombre TEXT, tribu INTEGER, satrapia INTEGER) */
  Future<Provincia> getProvincia(Jugador jugador) async {
    var dbClient = await database;

    String _sql="SELECT Id,Nombre,Tribu,Satrapia FROM Provincia WHERE jugador=${jugador.getID()}";

    var table = await dbClient.rawQuery(_sql);
    print("Provincia: ${table.first}");
    int _id = table.first["id"];
    String _nombre = table.first["nombre"];
    int _tribu = table.first["tribu"]; bool _esTribu = false; if (_tribu==1) _esTribu = true;
    int _satrapia = table.first["satrapia"]; bool _esSatrapia = false; if (_satrapia==1) _esSatrapia = true;

    Provincia _provincia = Provincia(_id, _nombre, jugador, _esTribu, _esSatrapia);
    return _provincia;
  }

  /* CREATE TABLE Ciudad(id INTEGER PRIMARY KEY, nombre TEXT, provincia INTEGER, x INTEGER, y INTEGER, z INTEGER, esCapital INTEGER) */
  Future<Capital> getCapital(Provincia provincia) async {
    var dbClient = await database;

    var table = await dbClient.rawQuery("SELECT id,nombre,x,y,z FROM Ciudad WHERE Provincia=${provincia.getID()} AND esCapital=1");
    print("Capital: ${table.first}");
    int _id = table.first["id"];
    String _nombre = table.first["nombre"];
    int _x = table.first["x"];
    int _y = table.first["y"];
    int _z = table.first["z"];

    Punto _posicion = Punto (_x, _y, _z);

    Capital _capital = Capital(_id, _nombre, provincia, _posicion);
    return _capital;
  }

  /* CREATE TABLE Palacio(id INTEGER PRIMARY KEY, nombre TEXT, capital INTEGER, oro INTEGER, poblacion INTEGER) */
  Future<Palacio> getPalacio(Capital capital, Dispatcher dispatcher) async {
    var dbClient = await database;
    var table = await dbClient.rawQuery("SELECT Id,Nombre,oro,poblacion FROM Palacio WHERE Capital=${capital.getID()}");
    print("Palacio: ${table.first}");
    int _id = table.first["id"];
    String _nombre = table.first["nombre"];
    int _oro = table.first["oro"];
    int _poblacion = table.first["poblacion"];

    Palacio _palacio = Palacio(_id, _nombre, capital, dispatcher);
    _palacio.setOro(_oro);
    _palacio.setPoblacion(_poblacion);
    return _palacio;
  }

  /*
     CREATE TABLE Silos(
          id INTEGER PRIMARY KEY, nombre TEXT, capital INTEGER,
          comida_stock INTEGER, comida_capacidad INTEGER,
          madera_stock INTEGER, madera_capacidad INTEGER,
          piedra_stock INTEGER, piedra_capacidad INTEGER,
          hierro_stock INTEGER, hierro_capacidad INTEGER
     */
  Future<Silos> getSilos(Capital capital, Dispatcher dispatcher) async {
    var dbClient = await database;
    var table = await dbClient.rawQuery("""
      SELECT Id,Nombre,Comida_Stock,Comida_Capacidad,Madera_Stock,Madera_Capacidad,Piedra_Stock,Piedra_Capacidad,Hierro_Stock,Hierro_Capacidad 
      FROM Silos WHERE Capital=${capital.getID()}
    """);
    print("Silos: ${table.first}");
    int _id = table.first["id"];
    String _nombre = table.first["nombre"];
    int _comidaStock = table.first["comida_stock"];
    int _comidaCapacidad = table.first["comida_capacidad"];
    int _maderaStock = table.first["madera_stock"];
    int _maderaCapacidad = table.first["madera_capacidad"];
    int _piedraStock = table.first["piedra_stock"];
    int _piedraCapacidad = table.first["piedra_capacidad"];
    int _hierroStock = table.first["hierro_stock"];
    int _hierroCapacidad = table.first["hierro_capacidad"];

    Silos _silos = Silos(_id, _nombre, capital, dispatcher);

    Almacen _almacenComida = Almacen(1,'Almacen de Comida',COMIDA, _silos.getPosicion(), _comidaCapacidad);
    _almacenComida.addCantidad(_comidaStock);
    _silos.addAlmacen(_almacenComida);

    Almacen _almacenMadera = Almacen(2,'Almacen de Madera',MADERA, _silos.getPosicion(), _maderaCapacidad);
    _almacenMadera.addCantidad(_maderaStock);
    _silos.addAlmacen(_almacenMadera);

    Almacen _almacenPiedra = Almacen(3,'Almacen de Piedra',PIEDRA, _silos.getPosicion(), _piedraCapacidad);
    _almacenPiedra.addCantidad(_piedraStock);
    _silos.addAlmacen(_almacenPiedra);

    Almacen _almacenHierro = Almacen(4,'Almacen de Hierro',HIERRO, _silos.getPosicion(), _hierroCapacidad);
    _almacenHierro.addCantidad(_hierroStock);
    _silos.addAlmacen(_almacenHierro);

    return _silos;
  }

  /* CREATE TABLE Cuartel(id INTEGER PRIMARY KEY, nombre TEXT, capital INTEGER) */
  Future<Cuartel> getCuartel(Capital capital, Dispatcher dispatcher) async {
    var dbClient = await database;
    var table = await dbClient.rawQuery("SELECT Id,Nombre FROM Cuartel WHERE Capital=${capital.getID()}");
    print("Cuartel: ${table.first}");
    int _id = table.first["Id"];
    String _nombre = table.first["Nombre"];

    Cuartel _cuartel = Cuartel(_id, _nombre, capital, dispatcher);
    return _cuartel;
  }

  /* CREATE TABLE CentroDeInvestigacion(id INTEGER PRIMARY KEY, nombre TEXT, capital INTEGER) */
  Future<CentroDeInvestigacion> getCentroDeInvestigacion(Capital capital, Dispatcher dispatcher) async {
    var dbClient = await database;
    var table = await dbClient.rawQuery("SELECT Id,Nombre FROM CentroDeInvestigacion WHERE Capital=${capital.getID()}");
    print("Centro de Investigacion: ${table.first}");
    int _id = table.first["Id"];
    String _nombre = table.first["Nombre"];

    CentroDeInvestigacion _centroDeInvestigacion = CentroDeInvestigacion(_id, _nombre, capital, dispatcher);
    return _centroDeInvestigacion;
  }

  Future<int> setOro(int oroActual) async {
    var dbClient = await database;
    return dbClient.rawUpdate("UPDATE Palacio SET Oro = $oroActual");
  }
}