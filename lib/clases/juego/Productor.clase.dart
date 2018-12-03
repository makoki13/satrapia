import './Recurso.clase.dart';
import './Punto.clase.dart';

class Productor {
  Punto _posicion;
  Recurso _recurso;
  num _cantidadInicial;
  num _cantidadMaxima;
  num _ratioProduccion;

  Productor (this._posicion, this._recurso, this._cantidadInicial, this._cantidadMaxima, this._ratioProduccion) {
    if (this._cantidadInicial > this._cantidadMaxima) { this._cantidadInicial = this._cantidadMaxima; }
  }

  num extrae ( num cantidad )  {
    cantidad *= this._ratioProduccion; // Para penalizaciones y bonus

    // Los productores con cantidadMaxima = 0 son inagotables.
    if (this._cantidadMaxima == 0) { return cantidad; }
    if (cantidad > this._cantidadInicial ) {
      //if (this._recurso == HIERRO ) { print('A: Cantidad B: $cantidad Cantidad maxima: ${this._cantidadInicial}'); }
      cantidad = this._cantidadInicial;
      this._cantidadInicial = 0;
    } else {
      this._cantidadInicial -= cantidad;
    }
    return cantidad;
  }

  num getStock() { return this._cantidadInicial; }
}