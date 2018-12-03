import './Edificio.clase.dart';
import './Imperio.clase.dart';
import './Capital.clase.dart';
import './Dispatcher.clase.dart';

class Embajada extends Edificio {
  List<Imperio> imperios;

  num id;
  String nombre;
  Capital _capital;
  Dispatcher _disp;

  Embajada (this.id, this.nombre, this._capital, this._disp) :  super (id, nombre, TipoEdificio.EMBAJADA, _capital.getPosicion(), 0, 0) {
    this._capital.setEmbajada(this);
    this.imperios = new List<Imperio>();
  }

  addImperio ( Imperio nuevoImperio) {
    this.imperios.add ( nuevoImperio );
  }

  List<Imperio> getLista() { return this.imperios; }
}