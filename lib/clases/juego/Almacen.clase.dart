import './Punto.clase.dart';
import './Recurso.clase.dart';

class Almacen {
  int _cantidad;
  int _id;
  String _nombre;
  Recurso _tipo;
  Punto _posicion;
  int _maxCantidad;

  Almacen (this._id, this._nombre, this._tipo, this._posicion, this._maxCantidad) {
    this._cantidad = 0;
  }

  int getID() { return this._id; }

  String getNombre() { return this._nombre; }

  addCantidad (int cantidad) {
    if (this._cantidad + cantidad > this._maxCantidad)
      this._cantidad = this._maxCantidad;
    else
      this._cantidad = this._cantidad + cantidad;
  }

  restaCantidad ( int cantidad) {
    if (cantidad > this._cantidad) {
      cantidad = this._cantidad;
      this._cantidad = 0;
    } else {
      this._cantidad -= cantidad;
    }
    return cantidad;
  }

  Recurso getTipoRecurso() { return this._tipo; }

  int getCantidad () { return this._cantidad; }

  Punto getPosicion() { return this._posicion; }

  int getMaxCantidad() { return this._maxCantidad; }
}