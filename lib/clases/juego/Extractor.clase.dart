import './Productor.clase.dart';
import './Almacen.clase.dart';

class Extractor {
  Productor _productor;
  Almacen _almacen;
  num _cantidad;

  Extractor (this._productor, this._almacen, this._cantidad) {}

  getCantidad( ) {
    num cantidad = this._cantidad;
    return this._productor.extrae(cantidad);
  }
}