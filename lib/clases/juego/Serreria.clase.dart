import './Edificio.clase.dart';
import './Parametros.clase.dart';
import './Extractor.clase.dart';
import './Productor.clase.dart';
import './Almacen.clase.dart';
import './Capital.clase.dart';
import './Dispatcher.clase.dart';
import './Recurso.clase.dart';
import './Transporte.clase.dart';
import './Punto.clase.dart';

class Serreria extends Edificio {
  //static num costeConstruccion = Parametros.Serreria_Construccion_Coste;
  //static num tiempoContruccion = Parametros.Serreria_Construccion_Tiempo;
  //num cantidadInicial = Parametros.Serreria_Productor_CantidadInicial;
  //num cantidadMaxima = Parametros.Serreria_Productor_CantidadMaxima;
  //num maximoItems = Parametros.Serreria_Num_Total;

  Extractor _lenyadores;
  Productor _filon;
  Almacen _almacen;

  num id;
  String _nombre;
  Punto _posicion;
  Capital _capital;
  Dispatcher _disp;

  Serreria (this.id, this._nombre, this._posicion, this._capital, this._disp, cantidadMaxima) : super (id, _nombre, TipoEdificio.SERRERIA, _posicion, 
    Parametros.Serreria_Construccion_Coste, Parametros.Serreria_Construccion_Tiempo) {
    this._capital.addSerreria(this);

    this._filon = new Productor ( null, MADERA, cantidadMaxima, cantidadMaxima);
    
    this._almacen = new Almacen ( 67, 'Silo de madera', MADERA, this._posicion, Parametros.Serreria_Almacen_Capacidad);    

    int tamanyoCosecha = (Parametros.Serreria_Cosecha_Tamanyo * (Parametros.Serreria_Productor_Ratio / 100)).toInt();
    this._lenyadores = new Extractor (this._filon, this._almacen, tamanyoCosecha);
    this._disp.addTareaRepetitiva(extrae, Parametros.Serreria_Cosecha_Frecuencia);

    this.setStatus ('Sin envios actuales');
  }

  Serreria.fromDB (this.id, this._nombre, this._posicion, this._capital, this._disp, 
      int stockProductor, int productorCantidadMaxima,       
      int tamanyoCosecha, int frecuenciaCosecha, int ratio,
      int stockAlmacen, int topeAlmacen)
      :  super (id, _nombre, TipoEdificio.SERRERIA, _posicion, Parametros.Serreria_Construccion_Coste, Parametros.Serreria_Construccion_Tiempo) {
    this._capital.addSerreria(this);
    
    this._filon = new Productor ( null, MADERA, stockProductor, productorCantidadMaxima);
    
    this._almacen = new Almacen ( 67, 'Silo de madera', MADERA, this._posicion, topeAlmacen);
    _almacen.setCantidad(stockAlmacen);
    
    tamanyoCosecha = (tamanyoCosecha * (ratio / 100)).toInt();
    this._lenyadores = new Extractor (this._filon, this._almacen, tamanyoCosecha);
    this._disp.addTareaRepetitiva(extrae, frecuenciaCosecha);

    this.setStatus ('Sin envios actuales');
  }

  String toString() { return this._nombre;}

  extrae() {
    num cantidad = this._lenyadores.getCantidad();
    //print("Serria extrae: $cantidad");
    this._almacen.addCantidad (cantidad);
    //print("Serria cantidad: ${this._almacen.getCantidad()}");

    /* Si el almacen alcanza el tope enviar un transporte de comida a palacio */
    //print("${this._almacen.getCantidad()} vs ${this._almacen.getMaxCantidad()}");
    if (this._almacen.getCantidad() >= this._almacen.getMaxCantidad()) {
      if (this.hayEnvioEnMarcha == false) {
        this.hayEnvioEnMarcha = true;
        this.enviaMaderaHaciaCiudad();
      }
    }
  }

  enviaMaderaHaciaCiudad() {
    num cantidad = this._almacen.restaCantidad(this._almacen.getCantidad());
    Transporte transporteDeMadera = new Transporte (this._almacen, this._capital.getSilos().getAlmacenMadera(), MADERA, cantidad, this, this._capital.getSilos() );

    transporteDeMadera.calculaViaje();
    this.setStatus ('Enviando madera...');
    this._disp.addTareaRepetitiva(transporteDeMadera.envia, Parametros.Transporte_Tiempo_Recalculo_Ruta);
  }

  num getMaderaActual() { return this._almacen.getCantidad(); }
  num getMaxAlmacen() { return this._almacen.getMaxCantidad(); }

  String getStatus() { return this.status; }

  bool estaActiva() { return this._filon.estaAgotado(); }
}
