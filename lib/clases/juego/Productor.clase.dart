import './Recurso.clase.dart';
import './Punto.clase.dart';

class Productor {
  Punto _posicion;
  Recurso _recurso;
  int _stock;
  int _cantidadMaxima;
  
  Productor (this._posicion, this._recurso, this._stock, this._cantidadMaxima);

  int extrae (int cantidad)  {    
    // Los productores con cantidadMaxima = 0 son inagotables.
    if (this._cantidadMaxima == 0) { return cantidad; }    
    if (cantidad >  this._stock) {      
      cantidad = this._stock;
      this._stock = 0;
    } else {
      this._stock -= cantidad;
    }

    //if (_recurso.getNombre() == "HIERRO") print("Stock ${_recurso.getNombre()}  : ${this._stock}");

    return cantidad;
  }

  int getStock() { return this._stock; }
  bool estaAgotado() { return (this._stock == 0);}
}