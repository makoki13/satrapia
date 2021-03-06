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

  static Future<void> _generaRegistros(jugador) async {
    ApiModelo.generaRegistroDispatcher();
    Estructura._dispatcher = new Dispatcher();

    Estructura._jugador = Jugador(jugador, 1, 'Makoki', TipoJugador.EMPERADOR);
    ApiModelo.generaRegistroJugador(Estructura._jugador);

    ApiModelo.generaRegistroImperio(Estructura._jugador);
    Estructura._imperio = new Imperio(1,'Imperio de Makoki',Estructura._jugador,false);

    ApiModelo.generaRegistroProvincia(Estructura._jugador);
    Estructura._provincia = new Provincia(1, 'Provincia de Makoki', Estructura._jugador, false, true);

    Punto _miPosicion = new Punto(100,100,0);
    ApiModelo.generaRegistroCiudad(Estructura._provincia, _miPosicion, true);
    Estructura._capital = new Capital(1, 'Capital de Makoki', Estructura._provincia, _miPosicion);
    Estructura._ciudades = new List<Localidad>();
    Estructura._ciudades.add(Estructura._capital);

    ApiModelo.generaRegistroPalacio(Estructura._capital);
    Estructura._palacio  = new Palacio(1,'Palacio de Makoki',Estructura._capital,Estructura._dispatcher);
    Estructura._capital.setPalacio(Estructura._palacio);

    ApiModelo.generaRegistroSilos(Estructura._capital);
    Estructura._silo = new Silos(1,'Silos',Estructura._capital,Estructura._dispatcher);
    Almacen miAlmacenDeComida = new Almacen(1, 'Silo de comida', COMIDA , _miPosicion, Parametros.MAX_ENTERO); Estructura._silo.addAlmacen(miAlmacenDeComida);
    Almacen miAlmacenDeMadera = new Almacen(2, 'Silo de madera', MADERA , _miPosicion, Parametros.MAX_ENTERO); Estructura._silo.addAlmacen(miAlmacenDeMadera);
    Almacen miAlmacenDePiedra = new Almacen(3, 'Silo de piedra', PIEDRA , _miPosicion, Parametros.MAX_ENTERO); Estructura._silo.addAlmacen(miAlmacenDePiedra);
    Almacen miAlmacenDeHierro = new Almacen(4, 'Silo de hierro', HIERRO , _miPosicion, Parametros.MAX_ENTERO); Estructura._silo.addAlmacen(miAlmacenDeHierro);
    Estructura._capital.setSilos(Estructura._silo);

    ApiModelo.generaRegistroCuartel(Estructura._capital);
    Estructura._cuartel = new Cuartel(1, 'Cuartel de Makoki', Estructura._capital, Estructura._dispatcher);

    ApiModelo.generaRegistroCentroDeInvestigacion(Estructura._capital);
    Estructura._centroDeInvestigacion = new CentroDeInvestigacion(1, 'Centro de investigación de Makoki', Estructura._capital, Estructura._dispatcher);

    ApiModelo.inicializaCentrosDeRecursos();
    Estructura.granjas = new List<Granja>();
    Estructura.serrerias = new List<Serreria>();
    Estructura.canteras = new List<Cantera>();
    Estructura.minasDeHierro = new List<MinaDeHierro>();
  }

  static Future<void> _cargaRegistros(int jugador) async {
    Estructura._dispatcher = ApiModelo.getDispatcher();

    Estructura._jugador = await ApiModelo.getJugador(jugador);

    Estructura._imperio = await ApiModelo.getImperio(Estructura._jugador);

    Estructura._provincia = await ApiModelo.getProvincia(Estructura._jugador);

    Estructura._capital = await ApiModelo.getCapital(Estructura._provincia);
    Estructura._ciudades = new List<Localidad>();
    Estructura._ciudades.add(Estructura._capital);

    Estructura._palacio  = await ApiModelo.getPalacio(Estructura._capital, Estructura._dispatcher);
    Estructura._capital.setPalacio(Estructura._palacio);

    Estructura._silo = await ApiModelo.getSilos(Estructura._capital, Estructura._dispatcher);
    Estructura._capital.setSilos(Estructura._silo);

    Estructura._cuartel = await ApiModelo.getCuartel(Estructura._capital, Estructura._dispatcher);

    Estructura._centroDeInvestigacion = await ApiModelo.getCentroDeInvestigacion(Estructura._capital, Estructura._dispatcher);

    Estructura.granjas = await ApiModelo.getGranjas(Estructura._capital, Estructura._dispatcher);
    Estructura.serrerias = await ApiModelo.getSerrerias(Estructura._capital, Estructura._dispatcher);
    Estructura.canteras = await ApiModelo.getCanteras(Estructura._capital, Estructura._dispatcher);
    Estructura.minasDeHierro = await ApiModelo.getMinasDeHierro(Estructura._capital, Estructura._dispatcher);
  }

  static void generaImperio(int jugador, Model modelo) {
    _modelo = modelo;

    _generaRegistros(jugador).then( (nada) { 
      //Estructura._palacio.iniciaCenso();
      //Estructura._palacio.iniciaRecaudacion();

      _pruebas();
      });    
  }

  static void cargaImperio(int jugador, Model modelo) {
    _modelo = modelo;

    _cargaRegistros(jugador).then( (nada) {
      //Estructura._palacio.iniciaCenso();
      //Estructura._palacio.iniciaRecaudacion();

      print("Num minas de hierro: ${Estructura.minasDeHierro.length}");
    });
  }

  static void _pruebas() {
    /* Proposito de pruebas */
    Punto posicion = new Punto(105, 103, 0);
    API.creaGranja(posicion);
    posicion = new Punto(106, 103, 0);
    API.creaGranja(posicion);
    //API.destruyeGranja(1);

    posicion = new Punto(103, 107, 0);
    API.creaSerreria(posicion);
    posicion = new Punto(101, 106, 0);
    API.creaSerreria(posicion);
    //API.destruyeSerreria(1);

    posicion = new Punto(104, 105, 0);
    API.creaCantera(posicion);
    posicion = new Punto(105, 104, 0);
    API.creaCantera(posicion);
    //API.destruyeSerreria(1);

    posicion = new Punto(111, 115, 0);
    API.creaMinaDeHierro(posicion);
    posicion = new Punto(110, 108, 0);
    API.creaMinaDeHierro(posicion);
    //API.destruyeMinaDeHierro(1);
  }

  static int getPoblacionActual() {
    if (Estructura._palacio!=null) return Estructura._palacio.getPoblacionActual(); else return 0;
  }

  static int getOroActual() {
    if (Estructura._palacio!=null) return Estructura._palacio.getOroActual(); else return 0;
  }

  static void setOroActual() {
    ApiModelo.setOro(API.getOroActual());
    _modelo.notifica();
  }

  static void setPoblacionActual() {
    ApiModelo.setPoblacion(API.getPoblacionActual());
    _modelo.notifica();
  }

  static int getStockComida() {
    if (Estructura._silo!=null ) return Estructura._silo.getAlmacenComida().getCantidad(); else return 0;
  }
  static int getStockMadera() {
    if (Estructura._silo!=null ) return Estructura._silo.getAlmacenMadera().getCantidad(); else return 0;
  }
  static int getStockPiedra() {
    if (Estructura._silo!=null ) return Estructura._silo.getAlmacenPiedra().getCantidad(); else return 0;
  }
  static int getStockHierro() {
    if (Estructura._silo!=null ) return Estructura._silo.getAlmacenHierro().getCantidad(); else return 0;
  }

  static void setStockComida() {
    int _comidaActual = API.getStockComida();
    ApiModelo.setComida(_comidaActual);
    _modelo.notifica();
  }

  static void setStockMadera() {
    ApiModelo.setMadera(API.getStockMadera());
    _modelo.notifica();
  }

  static void setStockPiedra() {
    ApiModelo.setPiedra(API.getStockPiedra());
    _modelo.notifica();
  }

  static void setStockHierro() {
    ApiModelo.setHierro(API.getStockHierro());
    _modelo.notifica();
  }

  /* GRANJAS */
  static int creaGranja(Punto posicion) {
    int indice = Estructura.granjas.length + 1;
    String nombre = 'Granja de Makoki $indice';

    /* El parámetro cantidad máxima será determinado por un valor aleatorio mejorado por la investigación correspondiente. De momento valor de parámetro */
    Granja _granja = new Granja(indice, nombre, posicion, Estructura._capital, Estructura._dispatcher, Parametros.Granja_Productor_CantidadMaxima);
    Estructura.granjas.add(_granja);

    ApiModelo.addGranja(indice, nombre, Estructura._capital, posicion, Parametros.Granja_Almacen_Capacidad, Parametros.Granja_Almacen_Capacidad, Parametros.Granja_Productor_Ratio,
        Parametros.Granja_Cosecha_Tamanyo, Parametros.Granja_Cosecha_Frecuencia, Estructura._capital.getProvincia().getJugador());

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
      ApiModelo.deleteGranja();
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
    String nombre = 'Serreria de Makoki $indice';
    /* El parámetro cantidad máxima será determinado por un valor aleatorio mejorado por la investigación correspondiente. De momento valor de parámetro */
    Serreria _serreria = new Serreria(indice, nombre, posicion, Estructura._capital, Estructura._dispatcher, Parametros.Serreria_Productor_CantidadMaxima);
    Estructura.serrerias.add(_serreria);
    ApiModelo.addSerreria(indice, nombre, Estructura._capital, posicion, Parametros.Serreria_Almacen_Capacidad, Parametros.Serreria_Almacen_Capacidad,
        Parametros.Serreria_Productor_Ratio, Parametros.Serreria_Cosecha_Tamanyo, Parametros.Serreria_Cosecha_Frecuencia, Estructura._capital.getProvincia().getJugador());
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
      ApiModelo.deleteSerreria();
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
    String nombre = 'Cantera de Makoki $indice';
    /* El parámetro cantidad máxima será determinado por un valor aleatorio mejorado por la investigación correspondiente. De momento valor de parámetro */
    Cantera _cantera = new Cantera(indice, nombre, posicion, Estructura._capital, Estructura._dispatcher, Parametros.Cantera_Productor_CantidadMaxima);
    Estructura.canteras.add(_cantera);
    ApiModelo.addCantera(indice, nombre, Estructura._capital, posicion, Parametros.Cantera_Almacen_Capacidad, Parametros.Cantera_Almacen_Capacidad,
        Parametros.Cantera_Productor_Ratio, Parametros.Cantera_Cosecha_Tamanyo, Parametros.Cantera_Cosecha_Frecuencia, Estructura._capital.getProvincia().getJugador());
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
      ApiModelo.deleteCantera();
      return 0;
    }

    return -1;
  }
  
  static void invadeCantera(int id) {} //Se cambia el jugador propietario
  static int  numCanteras() { return Estructura.canteras.length;}
  static List<Cantera> listaCanteras() { return Estructura.canteras;}
  static void setStockFilonCantera(Cantera cantera) {
    ApiModelo.setStockFilonCantera(cantera);
  }

  /* MINAS DE HIERRO */
  static int creaMinaDeHierro(Punto posicion) {
    int indice = Estructura.minasDeHierro.length + 1;
    String _nombre = 'Mina de hierro de Makoki $indice';
    /* El parámetro cantidad máxima será determinado por un valor aleatorio mejorado por la investigación correspondiente. De momento valor de parámetro */
    MinaDeHierro _minaDeHierro = new MinaDeHierro(indice, _nombre, posicion, Estructura._capital, Estructura._dispatcher, 
      Parametros.MinaDeHierro_Productor_CantidadMaxima, Parametros.MinaDeHierro_Almacen_Capacidad);
    Estructura.minasDeHierro.add(_minaDeHierro);
    ApiModelo.addMinaDeHierro(indice, _nombre, Estructura._capital, posicion, Parametros.MinaDeHierro_Almacen_Capacidad, Parametros.MinaDeHierro_Almacen_Capacidad,
        Parametros.MinaDeHierro_Productor_Ratio, Parametros.MinaDeHierro_Cosecha_Tamanyo, Parametros.Cantera_Cosecha_Frecuencia, Estructura._capital.getProvincia().getJugador());
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
      ApiModelo.deleteMinaDeHierro();
      return 0;
    }

    return -1;
  }
  
  static void invadeMinaDeHierro(int id) {} //Se cambia el jugador propietario
  static int  numMinasDeHierro() { return Estructura.canteras.length;}
  static List<MinaDeHierro> listaMinasDeHierro() { return Estructura.minasDeHierro;}
  static void setStockFilonMinaDeHierro(MinaDeHierro mina) {
    ApiModelo.setStockFilonMinaDeHierro(mina);
  }

  /* INVESTIGACIONES */
  static List<TipoInvestigacion> getListaInvestigaciones() {
    return Estructura._centroDeInvestigacion.getLista();
  }
}