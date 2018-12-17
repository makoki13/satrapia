import './Extractor.clase.dart';
import './Productor.clase.dart';
import './Almacen.clase.dart';
import './Edificio.clase.dart';
import './Capital.clase.dart';
import './Dispatcher.clase.dart';
import './Recurso.clase.dart';
import './Transporte.clase.dart';
import './Punto.clase.dart';

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

  Mina (this.id, this._nombre, this._tipoEdificio, this._recurso, this._posicion, this._capital, this._disp, this._costeConstruccion, this._tiempoConstruccion) : 
    super (id, _nombre, _tipoEdificio, _posicion, _costeConstruccion, _tiempoConstruccion) {

    this.filon = new Productor ( null, this._recurso, 20000, 20000, 1);
    this.almacen = new Almacen ( 67, 'Filón de ' + this._recurso.getNombre() , this._recurso, _posicion, 10);
    const cantidadInicial = 1;
    this.mineros = new Extractor (this.filon, this.almacen, cantidadInicial);
    this._disp.addTareaRepetitiva(extrae, 1);
    this.setStatus ('Sin envios actuales');

    this.almacenDestino = this._capital.getSilos().getAlmacenHierro(); if (this._recurso == ORO) this.almacenDestino =  this._capital.getPalacio().getAlmacen();
  }

  Mina.fromDB (this.id, this._nombre, this._tipoEdificio, this._recurso, this._posicion, this._capital, this._disp, this._costeConstruccion, this._tiempoConstruccion,
      int filonCantidad, int topeAlmacen, int cantidadActual, int ratio, int tamanyoCosecha, int frecuenciaCosecha)
      :  super (id, _nombre, _tipoEdificio, _posicion, _costeConstruccion, _tiempoConstruccion) {

    this.filon = new Productor ( null, this._recurso, 20000, 20000, 1);
    this.almacen = new Almacen ( 67, 'Filón de ' + this._recurso.getNombre(), this._recurso, this._posicion, topeAlmacen);

    this.almacen.setCantidad(cantidadActual);

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
  
  bool estaActiva() { return (this.filon.getStock() > 0); }
}


/* *************************************************************************************** */
/* CLASE MINA DE ORO */
class MinaDeOro extends Mina {
  static num costeConstruccion = 250;
  static num tiempoContruccion = 5;

  num id;
  String nombre;
  
  MinaDeOro (this.id, this.nombre, Punto posicion, Capital capital, Dispatcher disp) : super (id, nombre, TipoEdificio.MINA_DE_ORO, ORO, posicion, capital, disp, 
    MinaDeOro.costeConstruccion, MinaDeOro.tiempoContruccion) {
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
  
  MinaDeHierro (this.id, this.nombre, Punto posicion, Capital capital, Dispatcher disp) : super (id, nombre, TipoEdificio.MINA_DE_HIERRO, HIERRO, posicion, capital, disp,
    MinaDeHierro.costeConstruccion, MinaDeHierro.tiempoContruccion) {
    capital.addMinaDeHierro(this);
  }

  MinaDeHierro.fromDB (this.id, String nombre, Punto posicion, Capital capital, Dispatcher dispatcher, costeConstruccion, tiempoConstruccion,
      int filonCantidad, int topeAlmacen, int cantidadActual, int ratio, int tamanyoCosecha, int frecuenciaCosecha) :
      super.fromDB (id, nombre, TipoEdificio.MINA_DE_HIERRO, HIERRO, posicion, capital, dispatcher, costeConstruccion, tiempoConstruccion,
          filonCantidad, topeAlmacen, cantidadActual, ratio, tamanyoCosecha, frecuenciaCosecha){
    capital.addMinaDeHierro(this);
  }

  num getHierroActual() { return this.almacen.getCantidad(); }

  bool estaActiva() { return (this.filon.getStock() > 0); }
}
