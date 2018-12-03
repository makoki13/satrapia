import './Edificio.clase.dart';
import './Espia.clase.dart';
import './Capital.clase.dart';
import './Dispatcher.clase.dart';
import './Imperio.clase.dart';

class Taberna extends Edificio {
  List<Espia> espias;

  num id;
  String nombre;
  Capital _capital;
  Dispatcher _disp;

  Taberna (this.id, this.nombre, this._capital, this._disp) :  super (id, nombre, TipoEdificio.TABERNA, _capital.getPosicion(), 0, 0) {
    this._capital.setTaberna(this);
    this.espias = new List<Espia>();
  }

  addEspia( Espia nuevoEspia) {
    this.espias.add( nuevoEspia );
  }

  List<Espia> getLista() {
    return this.espias;
  }
}