import 'package:satrapia/clases/juego/Cantera.clase.dart';
import 'package:satrapia/clases/juego/Capital.clase.dart';
import 'package:satrapia/clases/juego/CentroDeInvestigacion.clase.dart';
import 'package:satrapia/clases/juego/Cuartel.clase.dart';
import 'package:satrapia/clases/juego/Dispatcher.clase.dart';
import 'package:satrapia/clases/juego/Granja.clase.dart';
import 'package:satrapia/clases/juego/Imperio.clase.dart';
import 'package:satrapia/clases/juego/Mina.clase.dart';
import 'package:satrapia/clases/juego/Palacio.clase.dart';
import 'package:satrapia/clases/juego/Punto.clase.dart';
import 'package:satrapia/clases/juego/Serreria.clase.dart';
import 'package:satrapia/clases/juego/Silos.clase.dart';

import 'baseDeDatos2.dart';
import '../clases/juego/Jugador.clase.dart';
import '../clases/juego/Parametros.clase.dart';

class ApiModelo {
  /* Estos registros inicializa (update) a valores iniciales */
  static generaRegistroDispatcher() {
    /* CREATE TABLE Dispatcher(codigo INTEGER PRIMARY KEY, valor TEXT) */
    DBProvider.db.borraDispatcher();
    DBProvider.db.insertaDispatcher(1,'Dispatcher');
  }
  static generaRegistroJugador(Jugador jugador) {
    /* CREATE TABLE Jugador(id INTEGER PRIMARY KEY, usuario INTEGER, nombre TEXT, tipo INTEGER) */
    DBProvider.db.borraJugador();
    DBProvider.db.insertaJugador(jugador,1,'Makoki',TipoJugador.EMPERADOR);
  }
  static generaRegistroImperio(Jugador jugador) {
    /* CREATE TABLE Imperio(id INTEGER PRIMARY KEY, jugador INTEGER, nombre TEXT, tipo INTEGER) */
    DBProvider.db.borraImperio();
    DBProvider.db.insertaImperio(1,'Imperio de Makoki',jugador,false);
  }
  static generaRegistroProvincia(Jugador jugador) {
    /* CREATE TABLE Provincia(id INTEGER PRIMARY KEY, jugador INTEGER, nombre TEXT, tribu INTEGER, satrapia INTEGER) */
    DBProvider.db.borraProvincia();
    DBProvider.db.insertaProvincia(1, 'Provincia de Makoki', jugador, false, true);
  }
  static generaRegistroCiudad(Provincia provincia, Punto posicion, bool esCapital) {
    /* CREATE TABLE Ciudad(id INTEGER PRIMARY KEY, nombre TEXT, provincia INTEGER, x INTEGER, y INTEGER, z INTEGER, esCapital INTEGER) */
    DBProvider.db.borraCiudad();
    DBProvider.db.insertaCiudad(1, 'Capital de Makoki', provincia, posicion, esCapital);
  }
  static generaRegistroPalacio(Capital capital) {
    /* CREATE TABLE Palacio(id INTEGER PRIMARY KEY, nombre TEXT, capital INTEGER) */
    DBProvider.db.borraPalacio();
    DBProvider.db.insertaPalacio(1,'Palacio de Makoki',capital);
  }
  static generaRegistroSilos(capital) {
    /*
     CREATE TABLE Silos(
          id INTEGER PRIMARY KEY, nombre TEXT, capital INTEGER,
          comida_stock INTEGER, comida_capacidad INTEGER,
          madera_stock INTEGER, madera_capacidad INTEGER,
          piedra_stock INTEGER, piedra_capacidad INTEGER,
          hierro_stock INTEGER, hierro_capacidad INTEGER
     */
    DBProvider.db.borraSilos();
    DBProvider.db.insertaSilos(1,'Palacio de Makoki',capital, 0, Parametros.MAX_ENTERO, 0, Parametros.MAX_ENTERO, 0, Parametros.MAX_ENTERO, 0, Parametros.MAX_ENTERO);
  }
  static generaRegistroCuartel(capital) {
    /* CREATE TABLE Cuartel(id INTEGER PRIMARY KEY, nombre TEXT, capital INTEGER) */
    DBProvider.db.borraCuartel();
    DBProvider.db.insertaCuartel(1, 'Cuartel de Makoki', capital);
  }
  static generaRegistroCentroDeInvestigacion(capital) {
    /* CREATE TABLE CentroDeInvestigacion(id INTEGER PRIMARY KEY, nombre TEXT, capital INTEGER) */
    DBProvider.db.borraCentroDeInvestigacion();
    DBProvider.db.insertaCentroDeInvestigacion(1, 'Centro de investigación de Makoki', capital);
  }
  
  
  
  
  
  

  static Dispatcher getDispatcher() {
    return Dispatcher();
  }

  static Future<Jugador> getJugador(int jugador) async {
    return DBProvider.db.getJugador(jugador);
  }

  static Future<Imperio> getImperio(Jugador jugador) async {
    return DBProvider.db.getImperio(jugador);
  }

  static Future<Provincia> getProvincia(Jugador jugador) async {
    return DBProvider.db.getProvincia(jugador);
  }

  static Future<Capital> getCapital(Provincia provincia) async {
    return DBProvider.db.getCapital(provincia);
  }

  static Future<Palacio> getPalacio(Capital capital, Dispatcher dispatcher) async {
    return DBProvider.db.getPalacio(capital, dispatcher);
  }

  static Future<Silos> getSilos(Capital capital, Dispatcher dispatcher) async {
    return DBProvider.db.getSilos(capital, dispatcher);
  }

  static Future<Cuartel> getCuartel(Capital capital, Dispatcher dispatcher) {
    return DBProvider.db.getCuartel(capital, dispatcher);
  }

  static Future<CentroDeInvestigacion> getCentroDeInvestigacion(Capital capital, Dispatcher dispatcher) {
    return DBProvider.db.getCentroDeInvestigacion(capital, dispatcher);
  }

  static void setOro(int oroActual) {
    DBProvider.db.setOro(oroActual);
  }

  static void setPoblacion(int poblacionActual) {
    DBProvider.db.setPoblacion(poblacionActual);
  }

  static void setComida(int comidaActual) {
    DBProvider.db.setComida(comidaActual);
  }

  static void setMadera(int maderaActual) {
    DBProvider.db.setMadera(maderaActual);
  }

  static void setPiedra(int piedraActual) {
    DBProvider.db.setPiedra(piedraActual);
  }

  static void setHierro(int hierroActual) {
    DBProvider.db.setHierro(hierroActual);
  }
  
  static Future<List<Granja>> getGranjas(Capital capital, Dispatcher dispatcher) {
    return DBProvider.db.getGranjas(capital, dispatcher);
  }

  static Future<List<Serreria>> getSerrerias(Capital capital, Dispatcher dispatcher) {
    return DBProvider.db.getSerreria(capital, dispatcher);
  }

  static Future<List<Cantera>> getCanteras(Capital capital, Dispatcher dispatcher) {
    return DBProvider.db.getCantera(capital, dispatcher);
  }

  static Future<List<MinaDeHierro>> getMinasDeHierro(Capital capital, Dispatcher dispatcher) {
    return DBProvider.db.getMinaDeHierro(capital, dispatcher);
  }

  static void inicializaCentrosDeRecursos() {
    DBProvider.db.borraCentrosDeRecursos();
  }

  static void addGranja(int id, String nombre, Capital capital, Punto posicion, int cantidadFilon, int cantidadTopeAlmacen, int ratio,
      int tamanyoCosecha, int frecuenciaCosecha, Jugador propietario) {
    DBProvider.db.insertaGranja(id, nombre, capital, posicion, cantidadFilon, cantidadTopeAlmacen, ratio, tamanyoCosecha, frecuenciaCosecha, propietario);
  }

  /** TODO */
  static void deleteGranja() {}

  static void addSerreria(int id, String nombre, Capital capital, Punto posicion, int cantidadFilon, int cantidadTopeAlmacen, int ratio,
      int tamanyoCosecha, int frecuenciaCosecha, Jugador propietario) {
    DBProvider.db.insertaSerreria(id,nombre,capital,posicion,cantidadFilon,cantidadTopeAlmacen,ratio,tamanyoCosecha,frecuenciaCosecha,propietario);
  }

  /** TODO */
  static void deleteSerreria() {}

  static void addCantera(int id, String nombre, Capital capital, Punto posicion, int cantidadFilon, int cantidadTopeAlmacen, int ratio,
      int tamanyoCosecha, int frecuenciaCosecha, Jugador propietario) {
    DBProvider.db.insertaCantera(id,nombre,capital,posicion,cantidadFilon,cantidadTopeAlmacen,ratio,tamanyoCosecha,frecuenciaCosecha,propietario);
  }

  /** TODO */
  static void deleteCantera() {}

  static void setStockFilonCantera(Cantera cantera) {
    DBProvider.db.setStockFilonCantera(cantera);
  }


  static void addMinaDeHierro(int id, String nombre, Capital capital, Punto posicion, int cantidadFilon, int cantidadTopeAlmacen, int ratio,
      int tamanyoCosecha, int frecuenciaCosecha, Jugador propietario) {
    DBProvider.db.insertaMinaDeHierro(id,nombre,capital,posicion,cantidadFilon,cantidadTopeAlmacen,ratio,tamanyoCosecha,frecuenciaCosecha,propietario);
  }

  /** TODO */
  static void deleteMinaDeHierro() {}

  static void setStockFilonMinaDeHierro(MinaDeHierro mina) {
    DBProvider.db.setStockFilonHierro(mina);
  }

}