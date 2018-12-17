import './Edificio.clase.dart';
import './Parametros.clase.dart';
import './Extractor.clase.dart';
import './Productor.clase.dart';
import './Almacen.clase.dart';
import './Recurso.clase.dart';
import './Transporte.clase.dart';
import './Capital.clase.dart';
import './Dispatcher.clase.dart';
import './Punto.clase.dart';

class Granja extends Edificio {
  //static num costeConstruccion = Parametros.Granja_Construccion_Coste;
  //static num tiempoContruccion = Parametros.Granja_Construccion_Tiempo;
  //static num cantidadInicial = Parametros.Granja_Productor_CantidadInicial;
  //static num cantidadMaxima = Parametros.Granja_Productor_CantidadMaxima;
  //static num ratio = Parametros.Granja_Productor_Ratio;
  //static num capacidadAlmacen = Parametros.Granja_Almacen_Capacidad;
  //static num tamanyoCosecha = Parametros.Granja_Cosecha_Tamanyo;
  //static num cosechaFrecuencia = Parametros.Granja_Cosecha_Frecuencia;
  //static num maximoItems = Parametros.Granja_Num_Total;

  Extractor _granjeros;
  Productor _filon;
  Almacen _almacen;

  num id;
  String _nombre;
  Punto _posicion;
  Capital _capital;
  Dispatcher _disp;

  Granja (this.id, this._nombre, this._posicion, this._capital, this._disp, int cantidadMaxima) :  super (id, _nombre, TipoEdificio.GRANJA, _posicion, 
    Parametros.Granja_Construccion_Coste, Parametros.Granja_Construccion_Tiempo) {
    this._capital.addGranja(this);

    this._filon = new Productor ( null, COMIDA, cantidadMaxima, cantidadMaxima);
    
    this._almacen = new Almacen ( 67, 'Silo de comida', COMIDA, this._posicion, Parametros.Granja_Almacen_Capacidad);
    
    int tamanyoCosecha = (Parametros.Granja_Cosecha_Tamanyo * (Parametros.Granja_Productor_Ratio / 100)).toInt();
    this._granjeros = new Extractor (this._filon, this._almacen, tamanyoCosecha);
    this._disp.addTareaRepetitiva(extrae, Parametros.Granja_Cosecha_Frecuencia);

    this.setStatus ('Sin envios actuales');
  }

  Granja.fromDB (this.id, this._nombre, this._posicion, this._capital, this._disp, 
      int stockProductor, int productorCantidadMaxima,       
      int tamanyoCosecha, int frecuenciaCosecha, int ratio,
      int stockAlmacen, int topeAlmacen)
      :  super (id, _nombre, TipoEdificio.GRANJA, _posicion, Parametros.Granja_Construccion_Coste, Parametros.Granja_Construccion_Tiempo) {
    this._capital.addGranja(this);

    this._filon = new Productor ( null, COMIDA, stockProductor, productorCantidadMaxima);

    this._almacen = new Almacen ( 67, 'Silo de comida', COMIDA, this._posicion, topeAlmacen);
    _almacen.setCantidad(stockAlmacen);

    tamanyoCosecha = (tamanyoCosecha * (ratio / 100)).toInt();
    this._granjeros = new Extractor (this._filon, this._almacen, tamanyoCosecha);
    this._disp.addTareaRepetitiva(extrae, frecuenciaCosecha);

    this.setStatus ('Sin envios actuales');
  }

  String toString() { return this._nombre;}

  extrae() {
    num cantidad = this._granjeros.getCantidad();

    this._almacen.addCantidad (cantidad);

    /* Si el almacen alcanza el tope enviar un transporte de comida a palacio */
    if (this._almacen.getCantidad() >= this._almacen.getMaxCantidad()) {
      if (this.hayEnvioEnMarcha == false) {        
        this.hayEnvioEnMarcha = true;
        this.enviaComidaHaciaCiudad();        
      }
    }
  }

  enviaComidaHaciaCiudad() {
    num cantidad = this._almacen.restaCantidad(this._almacen.getCantidad());
    Transporte transporteDeComida = new Transporte (this._almacen, this._capital.getSilos().getAlmacenComida(), COMIDA, cantidad, this, this._capital.getSilos() );

    transporteDeComida.calculaViaje();
    this.setStatus ('Enviando comida...');
    this._disp.addTareaRepetitiva(transporteDeComida.envia, Parametros.Transporte_Tiempo_Recalculo_Ruta);
  }

  num getComidaActual() { return this._almacen.getCantidad(); }
  num getMaxAlmacen() { return this._almacen.getMaxCantidad(); }

  String getStatus() { return this.status; }
  
  bool estaActiva() { return this._filon.estaAgotado(); }
}