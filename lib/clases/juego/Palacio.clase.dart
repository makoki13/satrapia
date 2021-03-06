import './Edificio.clase.dart';
import './Extractor.clase.dart';
import './Productor.clase.dart';
import './Almacen.clase.dart';
import './Capital.clase.dart';
import './Dispatcher.clase.dart';
import './Recurso.clase.dart';
import './Parametros.clase.dart';

import '../../api/models.dart';
import '../../api/api.dart';

class Palacio extends Edificio {
  Extractor _recaudador;
  Extractor _crecimientoDemografico;

  Productor _impuestos;
  Productor _alojamientos;

  Almacen _oro;
  Almacen _poblacion;

  num _id;
  String _nombre;
  Capital _capital;
  Dispatcher _disp;

  //static Model model = new Model();

  Palacio (this._id, this._nombre, this._capital, this._disp) :  super (_id, _nombre, TipoEdificio.PALACIO, _capital.getPosicion(), 0, 0) {
    this._capital.setPalacio(this);
    
    this._impuestos = new Productor ( null, ORO, 0, 0);
    this._oro = new Almacen ( 66, 'Deposito de oro', ORO, _capital.getPosicion(), Parametros.MAX_ENTERO);
    this._oro.addCantidad(Parametros.oroInicial);

    this._alojamientos = new Productor ( null, POBLACION, Parametros.Poblacion_Cantidad_Inicial, Parametros.Poblacion_Cantidad_Maxima);
    this._poblacion = new Almacen ( 67, 'Población', POBLACION, _capital.getPosicion(), 1000);
    this._crecimientoDemografico = new Extractor (this._alojamientos, this._poblacion, 10);

    int tamanyoCosecha = (Parametros.Poblacion_Cantidad_Inicial * (Parametros.Poblacion_Productor_Ratio / 100)).toInt();
    this._recaudador = new Extractor (this._impuestos, this._oro, tamanyoCosecha);

    this._disp.addTareaRepetitiva(realizaCenso, 10);
  }

  String toString() { return this._nombre;}
/*
  recaudaImpuestos ( ) {
    num cantidad = this._recaudador.getCantidad();
    this._oro.addCantidad (cantidad);
    API.setOroActual();
  }
*/
  realizaCenso ( ) {
    num cantidad = this._crecimientoDemografico.getCantidad();
    this._poblacion.addCantidad (cantidad);
    API.setPoblacionActual();

    /* Poner aqui la recaudación de impuestos */
    int tamanyoCosecha = (this._poblacion.getCantidad() * (Parametros.Poblacion_Productor_Ratio / 100)).toInt();
    print("$tamanyoCosecha = (${this._poblacion.getCantidad()} * (${Parametros.Poblacion_Productor_Ratio} / 100))");
    this._oro.addCantidad (tamanyoCosecha);
    API.setOroActual();
  }

  num getOroActual() { return this._oro.getCantidad(); }
  num getPoblacionActual() { return this._poblacion.getCantidad(); }

  Almacen getAlmacen ()  { return this._oro; }

  num gastaOro(num cantidad) {
    num cantidadActual = this._oro.getCantidad();
    if ( cantidadActual < cantidad ) {cantidad = cantidadActual; }
    this._oro.restaCantidad(cantidad);
    return cantidad;
  }

  entraOro(num cantidad) {
    this._oro.addCantidad (cantidad);
  }


  setOro(num cantidad) {
    this._oro.restaCantidad(this._oro.getCantidad());
    entraOro(cantidad);
  }

  setPoblacion(num cantidad) {
    this._poblacion.restaCantidad(this._poblacion.getCantidad());
    this._poblacion.addCantidad(cantidad);
  }

  /*
  iniciaRecaudacion() {
    this._disp.addTareaRepetitiva(recaudaImpuestos, 1);
  }

  iniciaCenso() {
    this._disp.addTareaRepetitiva(realizaCenso, 1);
  }
  */
}