import './Punto.clase.dart';

class TomTom {
  static List<Punto> calculaViaje (Punto origen, Punto destino) {
    List<Punto> ruta = new List<Punto>();

    num x_actual = origen.getX();
    num y_actual = origen.getY();

    num x_destino = destino.getX();
    num y_destino = destino.getY();

    bool seguirCalculando = true;
    while (seguirCalculando) {
      if (x_actual > x_destino ) {        
        x_actual--;
      } else {        
        if (x_actual < x_destino ) {
          x_actual++;
        }
      }

      if (y_actual > y_destino ) {
        y_actual--;
      } else {
        if (y_actual < y_destino ) {
          y_actual++;
        }
      }
      
      Punto nuevoPunto = new Punto (x_actual, y_actual, 0);
      ruta.add ( nuevoPunto );

      if ( (x_actual == x_destino) && (y_actual == y_destino) ) {
        seguirCalculando = false;
      }
    }

    //Iterable listaReversed = ruta.reversed; ruta = listaReversed.toList(); //Darle la vuelta a la lista

    return ruta;
  }
}
