//import 'package:sembast/sembast.dart';

//import './../tools/Persistencia.clase.dart';

class Parametros {
  static final num MAX_ENTERO = 1000000000000;
  static final MinaDeOro_Num_Total = 10;

  static num Granja_Construccion_Coste = 50;
  static num Granja_Construccion_Tiempo = 10;
  static num Granja_Productor_CantidadInicial = 0;
  static num Granja_Productor_CantidadMaxima = 0; // Ilimitado
  static num Granja_Productor_Ratio = 1;
  static num Granja_Almacen_Capacidad = 3;
  static num Granja_Cosecha_Tamanyo = 1;
  static num Granja_Cosecha_Frecuencia = 1;
  static num Granja_Num_Total = 10;

  static num Serreria_Construccion_Coste = 110;
  static num Serreria_Construccion_Tiempo = 10;
  static num Serreria_Productor_CantidadInicial = 0;
  static num Serreria_Productor_CantidadMaxima = 0; // Ilimitado
  static num Serreria_Productor_Ratio = 1;
  static num Serreria_Almacen_Capacidad = 5;
  static num Serreria_Cosecha_Tamanyo = 1;
  static num Serreria_Cosecha_Frecuencia = 1;
  static num Serreria_Num_Total = 10;

  static num Cantera_Construccion_Coste = 110;
  static num Cantera_Construccion_Tiempo = 10;
  static num Cantera_Productor_CantidadInicial = 10000;
  static num Cantera_Productor_CantidadMaxima = 10000;
  static num Cantera_Productor_Ratio = 1;
  static num Cantera_Almacen_Capacidad = 5;
  static num Cantera_Cosecha_Tamanyo = 1;
  static num Cantera_Cosecha_Frecuencia = 1;
  static num Cantera_Num_Total = 10;

  static num MinaDeHierro_Num_Total = 10;

  static num Transporte_Tiempo_Recalculo_Ruta = 1;
  static num Transporte_Velocidad = 0.83; // m/s

  static num Filon_Vacio = 0;

  static num oroInicial = 5000;

  static num IDpartida = null;

  Parametros() {

  }

  inicializa() {
    /*
    _doc = _db.getRegistro('parametros');
    Parametros.Granja_Construccion_Coste = _doc['Granja_Construccion_Coste'];
    Parametros.Granja_Construccion_Tiempo = _doc['Granja_Construccion_Tiempo'];
    Parametros.Granja_Productor_CantidadInicial = _doc['Granja_Productor_CantidadInicial'];
    Parametros.Granja_Productor_CantidadMaxima = _doc['Granja_Productor_CantidadMaxima'];
    Parametros.Granja_Productor_Ratio = _doc['Granja_Productor_Ratio'];
    Parametros.Granja_Almacen_Capacidad = _doc['Granja_Almacen_Capacidad'];
    Parametros.Granja_Cosecha_Tamanyo = _doc['Granja_Cosecha_Tamanyo'];
    Parametros.Granja_Cosecha_Frecuencia = _doc['Granja_Cosecha_Frecuencia'];
    Parametros.Granja_Num_Total = _doc['Granja_Num_Total'];

    Parametros.Serreria_Num_Total = _doc['Serreria_Num_Total'];

    Parametros.oroInicial = _doc['Oro_Inicial'];
    */
  }

  /** getters */
  static num getGranjaConstruccionCoste() {
    return Parametros.Granja_Construccion_Coste;
  }
  static num getGranjaConstruccionTiempo() {
    return Parametros.Granja_Construccion_Tiempo;
  }
  static num getGranjaProductorCantidadInicial() {
    return Parametros.Granja_Productor_CantidadInicial;
  }
  static num getGranjaProductorCantidadMaxima() {
    return Parametros.Granja_Productor_CantidadMaxima;
  }
  static num getGranjaProductorRatio() {
    return Parametros.Granja_Productor_Ratio;
  }
  static num getGranjaAlmacenCapacidad() {
    return Parametros.Granja_Almacen_Capacidad;
  }
  static num getGranjaCosechaTamanyo() {
    return Parametros.Granja_Cosecha_Tamanyo;
  }
  static num getGranjaCosechaFrecuencia() {
    return Parametros.Granja_Cosecha_Frecuencia;
  }
  static num getGranjaNumTotal() {
    return Parametros.Granja_Num_Total;
  }

  static num getSerreriaNumTotal() {
    return Parametros.Serreria_Num_Total;
  }

  static num getOroInicial() {
    return Parametros.oroInicial;
  }

  /** setters */
  setGranjaConstruccionCoste(num valor) {
    Parametros.Granja_Construccion_Coste = valor;
    /*
    _doc['Granja_Construccion_Coste'] = valor;
    _db.putRegistro(_doc);
    */
  }

  static setGranjaConstruccionTiempo(num valor) {
    Parametros.Granja_Construccion_Tiempo = valor;
    /*
    _doc['Granja_Construccion_Tiempo'] = valor;
    _db.putRegistro(_doc);
    */
  }

  static setGranjaProductorCantidadInicial(num valor) {
    Parametros.Granja_Productor_CantidadInicial = valor;
    /*
    _doc['Granja_Productor_CantidadInicial'] = valor;
    _db.putRegistro(_doc);
    */
  }

  static setGranjaProductorCantidadMaxima(num valor) {
    Parametros.Granja_Productor_CantidadMaxima = valor;
    /*
    _doc['Granja_Productor_CantidadMaxima'] = valor;
    _db.putRegistro(_doc);
    */
  }

  static setGranjaProductorRatio(num valor) {
    Parametros.Granja_Productor_Ratio = valor;
    /*
    _doc['Granja_Productor_Ratio'] = valor;
    _db.putRegistro(_doc);
    */
  }

  static setGranjaAlmacenCapacidad(num valor) {
    Parametros.Granja_Almacen_Capacidad = valor;
    /*
    _doc['Granja_Almacen_Capacidad'] = valor;
    _db.putRegistro(_doc);
    */
  }

  static setGranjaCosechaTamanyo(num valor) {
    Parametros.Granja_Cosecha_Tamanyo = valor;
    /*
    _doc['Granja_Cosecha_Tamanyo'] = valor;
    _db.putRegistro(_doc);
    */
  }

  static setGranjaCosechaFrecuencia(num valor) {
    Parametros.Granja_Cosecha_Frecuencia = valor;
    /*
    _doc['Granja_Cosecha_Frecuencia'] = valor;
    _db.putRegistro(_doc);
    */
  }

  static setGranjaNumTotal(num valor) {
    Parametros.Granja_Num_Total = valor;
    /*
    _doc['Granja_Num_Total'] = valor;
    _db.putRegistro(_doc);
    */
  }

  static setSerreriaNumTotal(num valor) {
    Parametros.Serreria_Num_Total = valor;
    /*
    _doc['Serreria_Num_Total'] = valor;
    _db.putRegistro(_doc);
    */
  }

  static setOroInicial(num valor) {
    Parametros.oroInicial = valor;
    /*
    _doc['Oro_Inicial'] = valor;
    _db.putRegistro(_doc);
    */
  }
}
