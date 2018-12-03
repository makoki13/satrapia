import './Punto.clase.dart';
import './Recurso.clase.dart';

enum TipoEdificio {
    PALACIO, SILOS, CUARTEL, MERCADO, EMBAJADA, TABERNA, CENTRO_DE_INVESTIGACION,
    GRANJA, MINA_DE_ORO, SERRERIA, MINA_DE_HIERRO, CANTERA_DE_PIEDRA,
    EJERCITO
}

class Edificio {
  num _id;
  String nombre;
  TipoEdificio tipo;
  Punto posicion;
  num _costeConstruccion;
  num _tiempoConstruccion;

  String status = 'Sin actividad';
  bool hayEnvioEnMarcha = false;

  // Los dos ultimos parametros del constructor hay que quitarlos.
  Edificio ( this._id, this.nombre, this.tipo, this.posicion, this._costeConstruccion, this._tiempoConstruccion) {

  }

  /* Es posible que no se usen */
  setCosteConstruccion(num cantidad) { this._costeConstruccion = cantidad; }
  setTiempoConstruccion(num cantidad) { this._tiempoConstruccion = cantidad; }
  num getCosteConstruccion() { return this._costeConstruccion; }
  num getTiempoConstruccion() { return this._tiempoConstruccion; }

  num getID() { return this._id; }
  TipoEdificio getTipo() { return this.tipo; }
  Punto getPosicion() { return this.posicion; }
  setStatus( String mensaje ) { this.status = mensaje; }
  String getNombre() { return this.nombre; }
  String getStatus() { return this.status; }

  void enviadoRecursos(Recurso recurso) {}
}