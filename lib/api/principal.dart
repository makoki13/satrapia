import 'api.dart';
import '../clases/juego/Dispatcher.clase.dart';

import '../clases/juego/Punto.clase.dart';
import '../clases/juego/Granja.clase.dart';
import '../clases/juego/Serreria.clase.dart';
import '../clases/juego/Cantera.clase.dart';
import '../clases/juego/Mina.clase.dart';
import '../clases/juego/CentroDeInvestigacion.clase.dart';

import 'models.dart';

class Principal {
  static ModeloPrincipal _modelo;

  Principal() {
    _modelo = ModeloPrincipal();
    API.generaImperio(0, _modelo);

    Punto posicion = new Punto(105,103,0);
    API.creaGranja(posicion);
    posicion = new Punto(106,103,0);
    API.creaGranja(posicion);
    //API.destruyeGranja(1);

    posicion = new Punto(103,107,0);
    API.creaSerreria(posicion);
    posicion = new Punto(101,106,0);
    API.creaSerreria(posicion);
    //API.destruyeSerreria(1);

    posicion = new Punto(104,105,0);
    API.creaCantera(posicion);
    posicion = new Punto(105,104,0);
    API.creaCantera(posicion);
    //API.destruyeSerreria(1);

    posicion = new Punto(111,115,0);
    API.creaMinaDeHierro(posicion);
    posicion = new Punto(110,108,0);
    API.creaMinaDeHierro(posicion);
    //API.destruyeMinaDeHierro(1);

  }

  static ModeloPrincipal getModelo() => _modelo;
}