import './Jugador.clase.dart';
import './Almacen.clase.dart';
import './Punto.clase.dart';
import './Productor.clase.dart';

class Imperio {
  int _id;
  String _nombre;
  Jugador _lider;
  bool _esTribu;
  Imperio (this._id, this._nombre, this._lider, this._esTribu) {}

  String getNombre() { return this._nombre; }
  int getID() { return this._id; }
  Jugador getJugador() { return this._lider;}
  bool esTribu() { return this._esTribu;}
}

class Provincia extends Imperio {
  int _id;
  String _nombre;
  Jugador _lider;
  bool _esTribu;
  bool _esSatrapia;

  Provincia (this._id, this._nombre, this._lider, this._esTribu, this._esSatrapia) : super (_id, _nombre, _lider, _esTribu) {}

  bool esSatrapia() { return this._esSatrapia;}
}

class Localidad {
  Productor _demografia;
  Almacen _poblacion;
  int _id;
  String _nombre;
  bool _esCapital;
  Provincia _provincia;
  int _numeroDeHabitantes;
  Punto _posicion;

  Localidad (this._id, this._nombre, this._esCapital, this._provincia, this._numeroDeHabitantes, this._posicion) {}

  int getID() { return this._id; }
  Punto getPosicion() { return this._posicion; }
  String getNombre() { return this._nombre; }
  int getNumeroHabitantes() { return this._numeroDeHabitantes; }
}
