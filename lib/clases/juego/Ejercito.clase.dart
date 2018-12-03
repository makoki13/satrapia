import './Punto.clase.dart';
import './Imperio.clase.dart';
import './Dispatcher.clase.dart';

class Ejercito {
  num id;
  String nombre;
  Punto _posicion;
  Localidad ciudad;
  Dispatcher disp;

  Ejercito (this.id, this.nombre, this._posicion, this.ciudad, this.disp) {

  }

  Punto getPosicion() { return this._posicion; }
}
