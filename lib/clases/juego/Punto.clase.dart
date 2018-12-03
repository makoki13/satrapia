import './Edificio.clase.dart';

enum TipoTerreno {Sin_Definir, Prado, Bosque, Mar, Agua_Poco_Profunda}

class Punto {
  TipoTerreno _tipoDeTerreno;
  num _region; // Geografia fisica
  num _provincia; // Geografia politica
  TipoEdificio _edificio;

  static sonIguales(Punto p, Punto q)  {    
    return ( (p.getX() == q.getX()) && (p.getY() == q.getY()) );
  }

  num _x;
  num _y;
  num _z;

  Punto(this._x, this._y, this._z) { this._edificio = null; }

  setAltura (num z) { this._z = z; }

  setEdificio(TipoEdificio e) { this._edificio = e; }

  num getX() { return this._x; }
  num getY() { return this._y; }
  TipoEdificio getEdificio() { return this._edificio; }
  TipoTerreno getTerreno() { return this._tipoDeTerreno; }
}