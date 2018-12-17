import './Extractor.clase.dart';
import './Productor.clase.dart';
import './Almacen.clase.dart';
import './Edificio.clase.dart';
import './Capital.clase.dart';
import './Dispatcher.clase.dart';
import './Recurso.clase.dart';
import './Transporte.clase.dart';
import './Punto.clase.dart';
import './Parametros.clase.dart';

class Mina extends Edificio {
  num _costeConstruccion;
  num _tiempoConstruccion;

  Extractor mineros;
  Productor filon;
  Almacen almacen;

  num id;
  String _nombre;
  Capital capital;  
  TipoEdificio _tipoEdificio;
  Recurso _recurso;
  Almacen almacenDestino;
  Capital _capital;
  Dispatcher _disp;
  Punto _posicion;

  Mina (this.id, this._nombre, this._tipoEdificio, this._recurso, this._posicion, this._capital, this._disp, this._costeConstruccion, this._tiempoConstruccion, cantidadMaxima,
    int capacidadAlmacen, int cosechaTamanyo, int productorRatio ) : 
    super (id, _nombre, _tipoEdificio, _posicion, _costeConstruccion, _tiempoConstruccion) {
  
    this.filon = new Productor ( null, this._recurso, cantidadMaxima, cantidadMaxima);

    this.almacen = new Almacen ( 67, 'Filón de ' + this._recurso.getNombre() , this._recurso, _posicion, capacidadAlmacen);

    int tamanyoCosecha = (cosechaTamanyo * (productorRatio / 100)).toInt();    
    this.mineros = new Extractor (this.filon, this.almacen, tamanyoCosecha);

    this._disp.addTareaRepetitiva(extrae, 1);
    this.setStatus ('Sin envios actuales');

    this.almacenDestino = this._capital.getSilos().getAlmacenHierro(); if (this._recurso == ORO) this.almacenDestino =  this._capital.getPalacio().getAlmacen();
  }

  Mina.fromDB (this.id, this._nombre, this._tipoEdificio, this._recurso, this._posicion, this._capital, this._disp, this._costeConstruccion, this._tiempoConstruccion,
      int stockProductor, int productorCantidadMaxima,       
      int tamanyoCosecha, int frecuenciaCosecha, int ratio,
      int stockAlmacen, int topeAlmacen)
      :  super (id, _nombre, _tipoEdificio, _posicion, _costeConstruccion, _tiempoConstruccion) {
  
    this.filon = new Productor ( null, this._recurso, stockProductor, productorCantidadMaxima);

    this.almacen = new Almacen ( 67, 'Filón de ' + this._recurso.getNombre(), this._recurso, this._posicion, topeAlmacen);
    this.almacen.setCantidad(stockAlmacen);
  
    tamanyoCosecha = (tamanyoCosecha * (ratio / 100)).toInt();
    this.mineros = new Extractor (this.filon, this.almacen, tamanyoCosecha);
    this._disp.addTareaRepetitiva(extrae, frecuenciaCosecha);

    this.setStatus ('Sin envios actuales');

    this.almacenDestino = this._capital.getSilos().getAlmacenHierro(); if (this._recurso == ORO) this.almacenDestino =  this._capital.getPalacio().getAlmacen();
  }

  String toString() { return this._nombre;}

  extrae() {
    num cantidad = this.mineros.getCantidad();

    this.almacen.addCantidad (cantidad);

    /* Si el almacen alcanza el tope enviar un transporte de recursos a palacio */
    //print("$cantidad __ Cantidad: ${this.almacen.getCantidad()} vs ${this.almacen.getMaxCantidad()}");
    if (this.almacen.getCantidad() >= this.almacen.getMaxCantidad()) {
      if (this.hayEnvioEnMarcha == false) {
        this.hayEnvioEnMarcha = true;
        this.enviaRecursosHaciaPalacio(almacenDestino);
      }
    }
  }

  enviaRecursosHaciaPalacio(almacenDestino) {
    num cantidad = this.almacen.restaCantidad(this.almacen.getCantidad());

    Edificio edificioDestino = this._capital.getSilos(); if (this._recurso == ORO) this._capital.getPalacio();
    Transporte transporteDeRecurso = new Transporte (this.almacen, almacenDestino, this._recurso, cantidad, this, edificioDestino );

    transporteDeRecurso.calculaViaje();
    this.setStatus ('Enviando ' + this._recurso.getNombre() + '...');
    this._disp.addTareaRepetitiva(transporteDeRecurso.envia, 1);
  }

  num getCantidadAlmacenActual() { return this.almacen.getCantidad(); }
  num getMaxAlmacen() { return this.almacen.getMaxCantidad(); }

  String getStatus() { return this.status; }
  
  bool estaActiva() { return this.filon.estaAgotado(); }
}


/* *************************************************************************************** */
/* CLASE MINA DE ORO */
class MinaDeOro extends Mina {
  static num costeConstruccion = 250;
  static num tiempoContruccion = 5;

  num id;
  String nombre;

  MinaDeOro (this.id, this.nombre, Punto posicion, Capital capital, Dispatcher disp, int cantidadMaxima, int capacidadAlmacen) : 
    super (id, nombre, TipoEdificio.MINA_DE_ORO, ORO, posicion, capital, disp, Parametros.MinaDeOro_Construccion_Coste, Parametros.MinaDeOro_Construccion_Tiempo, cantidadMaxima,
    capacidadAlmacen, Parametros.MinaDeOro_Cosecha_Tamanyo, Parametros.MinaDeOro_productor_ratio) {
    capital.addMinaDeOro(this);
  }

  num getOroActual() { return this.almacen.getCantidad(); }

  bool estaActiva() { return (this.filon.getStock() > 0); }
}

/* *****************************************************************************************/
/* CLASE MINA DE HIERRO */
class MinaDeHierro extends Mina {
  static num costeConstruccion = 250;
  static num tiempoContruccion = 5;

  num id;
  String nombre;

  MinaDeHierro (this.id, this.nombre, Punto posicion, Capital capital, Dispatcher disp, int cantidadMaxima, int capacidadAlmacen) : 
    super (id, nombre, TipoEdificio.MINA_DE_HIERRO, HIERRO, posicion, capital, disp, Parametros.MinaDeHierro_Construccion_Coste, Parametros.MinaDeHierro_Construccion_Tiempo, cantidadMaxima,
    capacidadAlmacen, Parametros.MinaDeHierro_Cosecha_Tamanyo, Parametros.MinaDeHierro_Productor_Ratio) {
    capital.addMinaDeHierro(this);
  }

  MinaDeHierro.fromDB (this.id, String nombre, Punto posicion, Capital capital, Dispatcher dispatcher, costeConstruccion, tiempoConstruccion,
      int stockProductor, int productorCantidadMaxima,       
      int tamanyoCosecha, int frecuenciaCosecha, int ratio,
      int stockAlmacen, int topeAlmacen) :
      super.fromDB (id, nombre, TipoEdificio.MINA_DE_HIERRO, HIERRO, posicion, capital, dispatcher, costeConstruccion, tiempoConstruccion,
          stockProductor, productorCantidadMaxima, tamanyoCosecha, frecuenciaCosecha, ratio, stockAlmacen, topeAlmacen){
    capital.addMinaDeHierro(this);
  }

  num getHierroActual() { return this.almacen.getCantidad(); }

  bool estaActiva() { return (this.filon.getStock() > 0); }
}
