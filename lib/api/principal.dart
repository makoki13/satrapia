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
  }

  static ModeloPrincipal getModelo() => _modelo;

  /*
  static Future<void> cargaPrincipal() async {
    print("Antes de API");
    await API.cargaImperio(0, _modelo);
    print("Despues de API");
  }
  */
  
  static Future<bool> _hayPartidaNueva() async {
    bool _partidaNueva = await DBProvider.db.hayPartidaNueva();
    return _partidaNueva;
  }

  static Future<void> cargaPartida(bool esPartidanueva) async {
    /*
    _hayPartidaNueva().then((resultado) async {      
      if (resultado == false) {
        print("CREA PARTIDA");
        DBProvider.db.salvaPartidaNueva();
        var res = await API.generaImperio(0, _modelo);
      }
      else {
        print("CARGA PARTIDA");
        API.cargaImperio(0, _modelo);
      }
    });
    */
    if (esPartidanueva==true) {
      print("CREA PARTIDA");
      DBProvider.db.salvaPartidaNueva();
      var res = await API.generaImperio(0, _modelo);
    }
    else {
      print("CARGA PARTIDA");
      API.cargaImperio(0, _modelo);
    }
  }
}