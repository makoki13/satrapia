import 'api.dart';
import '../clases/juego/Dispatcher.clase.dart';

import '../clases/juego/Punto.clase.dart';
import '../clases/juego/Granja.clase.dart';
import '../clases/juego/Serreria.clase.dart';
import '../clases/juego/Cantera.clase.dart';
import '../clases/juego/Mina.clase.dart';
import '../clases/juego/CentroDeInvestigacion.clase.dart';

import 'models.dart';
import 'baseDeDatos2.dart';

class Principal {
  static ModeloPrincipal _modelo;

  Principal() {
    _modelo = ModeloPrincipal();

    DBProvider.db.salvaPartidaNueva();
    API.generaImperio(0, _modelo);
    _pruebas();
  }

  static ModeloPrincipal getModelo() => _modelo;

  Future<bool> _hayPartidaNueva() async {
    bool _partidaNueva = await DBProvider.db.hayPartidaNueva();
    return _partidaNueva;
  }

  Future<void> cargaPartida() async {
    _hayPartidaNueva().then((resultado) async {
      resultado = false;
      if (resultado == false) {
        DBProvider.db.salvaPartidaNueva();
        var res = await API.generaImperio(0, _modelo);
      }
      else {
        API.cargaImperio(1, _modelo);
      }
    });
  }

  void _pruebas() {
    /* Proposito de pruebas */
    Punto posicion = new Punto(105, 103, 0);
    API.creaGranja(posicion);
    posicion = new Punto(106, 103, 0);
    API.creaGranja(posicion);
    //API.destruyeGranja(1);

    posicion = new Punto(103, 107, 0);
    API.creaSerreria(posicion);
    posicion = new Punto(101, 106, 0);
    API.creaSerreria(posicion);
    //API.destruyeSerreria(1);

    posicion = new Punto(104, 105, 0);
    API.creaCantera(posicion);
    posicion = new Punto(105, 104, 0);
    API.creaCantera(posicion);
    //API.destruyeSerreria(1);

    posicion = new Punto(111, 115, 0);
    API.creaMinaDeHierro(posicion);
    posicion = new Punto(110, 108, 0);
    API.creaMinaDeHierro(posicion);
    //API.destruyeMinaDeHierro(1);
  }
}