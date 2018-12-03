import './Edificio.clase.dart';
import './Parametros.clase.dart';
import './Capital.clase.dart';
import './Dispatcher.clase.dart';
import './Extractor.clase.dart';
import './Productor.clase.dart';
import './Almacen.clase.dart';
import './Recurso.clase.dart';
import './Transporte.clase.dart';
import './Punto.clase.dart';

class Cantera extends Edificio {
  int costeConstruccion = Parametros.Cantera_Construccion_Coste;
  int tiempoConstruccion = Parametros.Cantera_Construccion_Tiempo;
  int cantidadInicial = Parametros.Cantera_Productor_CantidadInicial;
  int cantidadMaxima = Parametros.Cantera_Productor_CantidadMaxima;

  int _id;
  String _nombre;
  Punto _posicion;
  Capital _capital;
  Dispatcher _disp;
  Extractor _canteros;
  Productor _filon;
  Almacen _almacen;
  
  Cantera (this._id, this._nombre, this._posicion, this._capital, this._disp) :  super (_id, _nombre, TipoEdificio.CANTERA_DE_PIEDRA, _posicion,
      Parametros.Cantera_Construccion_Coste, Parametros.Cantera_Construccion_Tiempo) {

    this._capital.addCantera(this);

    this._filon = new Productor ( null, PIEDRA, this.cantidadInicial, this.cantidadMaxima, Parametros.Cantera_Productor_Ratio);
    this._almacen = new Almacen ( 68, 'Cantera de piedra', PIEDRA, this._posicion, Parametros.Cantera_Almacen_Capacidad);
    this._canteros = new Extractor (this._filon, this._almacen, Parametros.Cantera_Cosecha_Tamanyo);

    this._disp.addTareaRepetitiva(extrae, Parametros.Cantera_Cosecha_Tamanyo);

    this.setStatus ('Sin envios actuales');
  }

  int getID() { return this._id; }

  String getNombre() { return this._nombre; }


  String toString() { return this._nombre;}

  extrae() {
    int cantidad = this._canteros.getCantidad();
    this._almacen.addCantidad (cantidad);

    /* Si el almacen alcanza el tope enviar un transporte de piedra a palacio */
    if (this._almacen.getCantidad() >= this._almacen.getMaxCantidad()) {      
      if (this.hayEnvioEnMarcha == false) {        
        this.hayEnvioEnMarcha = true;
        this.enviaPiedraHaciaCiudad();
      }
    }
  }

  enviaPiedraHaciaCiudad() {
    int cantidad = this._almacen.restaCantidad(this._almacen.getCantidad());
    Transporte transporteDePiedra = new Transporte (this._almacen, this._capital.getSilos().getAlmacenPiedra(), PIEDRA, cantidad, this, this._capital.getSilos() );

    transporteDePiedra.calculaViaje();
    this.setStatus ('Enviando piedra...');
    this._disp.addTareaRepetitiva(transporteDePiedra.envia, Parametros.Transporte_Tiempo_Recalculo_Ruta);
  }

  int getPiedraActual() { return this._almacen.getCantidad(); }
  int getMaxAlmacen() { return this._almacen.getMaxCantidad(); }

  String getStatus() { return this.status; }
  setStatus( String mensaje ) { super.setStatus(mensaje); }

  bool estaActiva() { return (this._filon.getStock() > Parametros.Filon_Vacio); }
}
