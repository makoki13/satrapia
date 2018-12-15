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

    //API.generaImperio(0, _modelo);


    print("Antes de cargaPrincipal");
    cargaPrincipal().then( (valor) {
      //_pruebas();
    });
    print("Despues de cargaPrincipal");



  }

  Future<void> cargaPrincipal() async {
    print("Antes de API");
    await API.cargaImperio(0, _modelo);
    print("Despues de API");
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
}