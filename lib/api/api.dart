import 'package:scoped_model/scoped_model.dart';

//import '../msr/msr.dart'; En un futuro muy lejano
import 'models.dart';
import 'apiModelo.dart';

import '../clases/juego/Dispatcher.clase.dart';
import '../clases/juego/Parametros.clase.dart';
import '../clases/juego/Recurso.clase.dart';
import '../clases/juego/Almacen.clase.dart';

import '../clases/juego/Jugador.clase.dart';
import '../clases/juego/Imperio.clase.dart';
import '../clases/juego/Punto.clase.dart';
import '../clases/juego/Capital.clase.dart';

import '../clases/juego/Palacio.clase.dart';
import '../clases/juego/Silos.clase.dart';
import '../clases/juego/Cuartel.clase.dart';
import '../clases/juego/CentroDeInvestigacion.clase.dart';


import '../clases/juego/Granja.clase.dart';
import '../clases/juego/Serreria.clase.dart';
import '../clases/juego/Cantera.clase.dart';
import '../clases/juego/Mina.clase.dart';

class Estructura { 
  static Dispatcher _dispatcher;
  static Jugador _jugador;
  static Imperio _imperio; 
  static Provincia _provincia;
  static Capital _capital;
  static List<Localidad> _ciudades;

  static Palacio _palacio;  
  static Silos _silo;
  static Cuartel _cuartel;
  static CentroDeInvestigacion _centroDeInvestigacion;
  
  static List<Granja> granjas;
  static List<Serreria> serrerias;
  static List<Cantera> canteras;
  static List<MinaDeHierro> minasDeHierro;
}

class API {  
  static ModeloPrincipal _modelo;

  static _generaRegistros(jugador) {
    ApiModelo.generaRegistroDispatcher();
    Estructura._dispatcher = new Dispatcher();

    ApiModelo.generaRegistroJugador();
    Estructura._jugador = new Jugador(jugador, 1, 'Makoki', TipoJugador.EMPERADOR);

    ApiModelo.generaRegistroImperio();
    Estructura._imperio = new Imperio(1,'Imperio de Makoki',Estructura._jugador,false);

    ApiModelo.generaRegistroProvincia();
    Estructura._provincia = new Provincia(1, 'Provincia de Makoki', Estructura._jugador, false, true);

    ApiModelo.generaRegistroCapital();
    Punto _miPosicion = new Punto(100,100,0);
    Estructura._capital = new Capital(1, 'Capital de Makoki', Estructura._provincia, _miPosicion);
    Estructura._ciudades = new List<Localidad>();
    Estructura._ciudades.add(Estructura._capital);

    ApiModelo.generaRegistroPalacio();
    Estructura._palacio  = new Palacio(1,'Palacio de Makoki',Estructura._capital,Estructura._dispatcher);
    Estructura._capital.setPalacio(Estructura._palacio);

    ApiModelo.generaRegistroSilos();
    Estructura._silo = new Silos(1,'Silos',Estructura._capital,Estructura._dispatcher);
    Almacen miAlmacenDeComida = new Almacen(1, 'Silo de comida', COMIDA , _miPosicion, Parametros.MAX_ENTERO); Estructura._silo.addAlmacen(miAlmacenDeComida);
    Almacen miAlmacenDeMadera = new Almacen(2, 'Silo de madera', MADERA , _miPosicion, Parametros.MAX_ENTERO); Estructura._silo.addAlmacen(miAlmacenDeMadera);
    Almacen miAlmacenDePiedra = new Almacen(3, 'Silo de piedra', PIEDRA , _miPosicion, Parametros.MAX_ENTERO); Estructura._silo.addAlmacen(miAlmacenDePiedra);
    Almacen miAlmacenDeHierro = new Almacen(4, 'Silo de hierro', HIERRO , _miPosicion, Parametros.MAX_ENTERO); Estructura._silo.addAlmacen(miAlmacenDeHierro);
    Estructura._capital.setSilos(Estructura._silo);

    ApiModelo.generaRegistroCuartel();
    Estructura._cuartel = new Cuartel(1, 'Cuartel de Makoki', Estructura._capital, Estructura._dispatcher);

    ApiModelo.generaRegistroCentroDeInvestigacion();
    Estructura._centroDeInvestigacion = new CentroDeInvestigacion(1, 'Centro de investigación de Makoki', Estructura._capital, Estructura._dispatcher);

    Estructura.granjas = new List<Granja>();
    Estructura.serrerias = new List<Serreria>();
    Estructura.canteras = new List<Cantera>();
    Estructura.minasDeHierro = new List<MinaDeHierro>();
  }

  static _cargaRegistros(jugador) {

  }

  static void generaImperio(int jugador, Model modelo) {
    _modelo = modelo;

    _generaRegistros(jugador);
    Estructura._palacio.iniciaCenso();
    Estructura._palacio.iniciaRecaudacion();
  }

  static void cargaImperio(int jugador, Model modelo) {
    return; //Pendiente
    _cargaRegistros(jugador);
    Estructura._palacio.iniciaCenso();
    Estructura._palacio.iniciaRecaudacion();
  }




  static int getPoblacionActual() {
    return Estructura._palacio.getPoblacionActual();
  }

  static int getOroActual() {
    return Estructura._palacio.getOroActual();
  }

  static void setOroActual() {
    _modelo.notifica();
  }

  static void setPoblacionActual() {
    _modelo.notifica();
  }

  static int getStockComida() { return Estructura._silo.getAlmacenComida().getCantidad();}
  static int getStockMadera() { return Estructura._silo.getAlmacenMadera().getCantidad();}
  static int getStockPiedra() { return Estructura._silo.getAlmacenPiedra().getCantidad();}
  static int getStockHierro() { return Estructura._silo.getAlmacenHierro().getCantidad();}

  static void setStockComida() {
    _modelo.notifica();
  }

  static void setStockMadera() {
    _modelo.notifica();
  }

  static void setStockPiedra() {
    _modelo.notifica();
  }

  static void setStockHierro() {
    _modelo.notifica();
  }

  /* GRANJAS */
  static int creaGranja(Punto posicion) {
    int indice = Estructura.granjas.length + 1;
    Granja _granja = new Granja(indice, 'Granja de Makoki $indice', posicion, Estructura._capital, Estructura._dispatcher);
    Estructura.granjas.add(_granja);
    return indice;
  }

  static int destruyeGranja(int id) {
    Iterator i = Estructura.granjas.iterator;
    int indice = 0; 
    bool encontrado = false;
    while (i.moveNext()) {      
      if(i.current.getID() == id ) {encontrado = true; break;}
      indice++;
    }
    if (encontrado==true) {
      Estructura.granjas.removeAt(indice);
      return 0;
    }

    return -1;
  }

  static void invadeGranja(int id) {} //Se cambia el jugador propietario
  static int  numGranjas() { return Estructura.granjas.length;}
  static List<Granja> listaGranjas() { return Estructura.granjas;}

  /* SERRERIAS */
  static int creaSerreria(Punto posicion) {
    int indice = Estructura.serrerias.length + 1;
    Serreria _serreria = new Serreria(indice, 'Serreria de Makoki $indice', posicion, Estructura._capital, Estructura._dispatcher);
    Estructura.serrerias.add(_serreria);
    return indice;
  }

  static int destruyeSerreria(int id) {
    Iterator i = Estructura.serrerias.iterator;
    int indice = 0; 
    bool encontrado = false;
    while (i.moveNext()) {      
      if(i.current.getID() == id ) {encontrado = true; break;}
      indice++;
    }
    if (encontrado==true) {
      Estructura.serrerias.removeAt(indice);
      return 0;
    }

    return -1;
  }
  
  static void invadeSerreria(int id) {} //Se cambia el jugador propietario
  static int  numSerrerias() { return Estructura.serrerias.length;}
  static List<Serreria> listaSerrerias() { return Estructura.serrerias;}

  /* CANTERAS */
  static int creaCantera(Punto posicion) {
    int indice = Estructura.canteras.length + 1;
    Cantera _cantera = new Cantera(indice, 'Cantera de Makoki $indice', posicion, Estructura._capital, Estructura._dispatcher);
    Estructura.canteras.add(_cantera);
    return indice;
  }

  static int destruyeCantera(int id) {
    Iterator i = Estructura.canteras.iterator;
    int indice = 0; 
    bool encontrado = false;
    while (i.moveNext()) {      
      if(i.current.getID() == id ) {encontrado = true; break;}
      indice++;
    }
    if (encontrado==true) {
      Estructura.canteras.removeAt(indice);
      return 0;
    }

    return -1;
  }
  
  static void invadeCantera(int id) {} //Se cambia el jugador propietario
  static int  numCanteras() { return Estructura.canteras.length;}
  static List<Cantera> listaCanteras() { return Estructura.canteras;}

  /* MINAS DE HIERRO */
  static int creaMinaDeHierro(Punto posicion) {
    int indice = Estructura.minasDeHierro.length + 1;
    MinaDeHierro _minaDeHierro = new MinaDeHierro(indice, 'Mina de hierro de Makoki $indice', posicion, Estructura._capital, Estructura._dispatcher);
    Estructura.minasDeHierro.add(_minaDeHierro);
    return indice;
  }

  static int destruyeMinaDeHierro(int id) {
    Iterator i = Estructura.minasDeHierro.iterator;
    int indice = 0; 
    bool encontrado = false;
    while (i.moveNext()) {      
      if(i.current.getID() == id ) {encontrado = true; break;}
      indice++;
    }
    if (encontrado==true) {
      Estructura.minasDeHierro.removeAt(indice);
      return 0;
    }

    return -1;
  }
  
  static void invadeMinaDeHierro(int id) {} //Se cambia el jugador propietario
  static int  numMinasDeHierro() { return Estructura.canteras.length;}
  static List<MinaDeHierro> listaMinasDeHierro() { return Estructura.minasDeHierro;}

  /* INVESTIGACIONES */
  static List<TipoInvestigacion> getListaInvestigaciones() {
    return Estructura._centroDeInvestigacion.getLista();
  }
}