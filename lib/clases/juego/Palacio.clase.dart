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

  Almacen almacen;
  Almacen poblacion;

  num _id;
  String _nombre;
  Capital _capital;
  Dispatcher _disp;

  //static Model model = new Model();

  Palacio (this._id, this._nombre, this._capital, this._disp) :  super (_id, _nombre, TipoEdificio.PALACIO, _capital.getPosicion(), 0, 0) {
    this._capital.setPalacio(this);

    num cantidadInicial = 2;
    this._impuestos = new Productor ( null, ORO, 2, 0, 1);
    this.almacen = new Almacen ( 66, 'Deposito de oro', ORO, _capital.getPosicion(), Parametros.MAX_ENTERO);
    this.almacen.addCantidad(Parametros.oroInicial);
    this._recaudador = new Extractor (this._impuestos, this.almacen, cantidadInicial);
    this._disp.addTareaRepetitiva(recaudaImpuestos, 1);

    cantidadInicial = 100; const cantidadMaxima = 0;
    this._alojamientos = new Productor ( null, POBLACION, cantidadInicial, cantidadMaxima, 1);
    this.poblacion = new Almacen ( 67, 'Población', POBLACION, _capital.getPosicion(), 1000);
    this._crecimientoDemografico = new Extractor (this._alojamientos, this.poblacion, 10);

    this._disp.addTareaRepetitiva(realizaCenso, 1);
  }

  String toString() { return this._nombre;}

  recaudaImpuestos ( ) {
    num cantidad = this._recaudador.getCantidad();
    this.almacen.addCantidad (cantidad);
    API.setOroActual();
  }

  realizaCenso ( ) {
    num cantidad = this._crecimientoDemografico.getCantidad();
    this.poblacion.addCantidad (cantidad);
    API.setPoblacionActual();
  }

  num getOroActual() { return this.almacen.getCantidad(); }
  num getPoblacionActual() { return this.poblacion.getCantidad(); }

  Almacen getAlmacen ()  { return this.almacen; }

  num gastaOro(num cantidad) {
    num cantidadActual = this.almacen.getCantidad();
    if ( cantidadActual < cantidad ) {cantidad = cantidadActual; }
    this.almacen.restaCantidad(cantidad);
    return cantidad;
  }

  entraOro(num cantidad) {
    this.almacen.addCantidad (cantidad);
  }
}