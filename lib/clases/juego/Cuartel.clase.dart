import './Edificio.clase.dart';
import './Recurso.clase.dart';
import './CentroDeInvestigacion.clase.dart';
import './Capital.clase.dart';
import './Dispatcher.clase.dart';

class Cuartel extends Edificio {
  List<Unidades> _unidades;

  num id;
  String nombre;
  Capital _capital;
  Dispatcher _disp;

  Cuartel (this.id, this.nombre, this._capital, this._disp) : super (id, nombre, TipoEdificio.CUARTEL, _capital.getPosicion(), 0, 0) {
    this._capital.setCuartel(this);
    this._unidades = new  List< Unidades >();
  }

  List<Unidades> getTropas() { return this._unidades; }

  UnidadMilitar _tipoUnidad;
  num _cantidad;

  addUnidades () {
    UnidadMilitar tipo = this._tipoUnidad; num cantidad = this._cantidad;
    num indiceElemento = -1;
    num indice = 0;
    this._unidades.forEach( (x) {
      if (x.unidad.getID() == tipo.getID()) {indiceElemento = indice; }
      indice++;
    });

    if ( indiceElemento == -1) {
      Unidades nuevaUnidad = new Unidades(tipo, cantidad);
      this._unidades.add (nuevaUnidad);
    } else {
      this._unidades[indiceElemento].cantidad += cantidad;
    }

    this.setStatus ('Sin actividad');

    return -1;
  }

  List<Unidades> getTipoUnidadesPermitidas() {
    List<Unidades> lista = new List< Unidades >();
    // let unidadItem: UnidadMilitar;
    CentroDeInvestigacion myCI = this._capital.getCentroDeInvestigacion();

    myCI.getListaUnidadesMilitaresConseguidas().forEach ( (item) {
      num indice = item.getID();
      bool existe = false;
      switch (indice) {
        case 1:
          this._unidades.forEach( (x) {
            if (x.unidad.getID() == 1001) {lista.add (x); existe = true; }
          });
          if (existe == false ) {
            Unidades nuevaUnidad = new Unidades(new CivilConHonda(100, 1, 1, 100) , 0);
            this._unidades.add (nuevaUnidad);
            lista.add (nuevaUnidad);
          }
          break;

        case 2:
          this._unidades.forEach( (x) {
            if (x.unidad.getID() == 1002) {lista.add (x); existe = true; }
          });
          if (existe == false ) {
            Unidades nuevaUnidad = new Unidades(new Soldado (100, 1, 100, 100) , 0);
            this._unidades.add (nuevaUnidad);
            lista.add (nuevaUnidad);
          }
          break;

        default:
          // console.log ('UNIDAD 0:::: ' + indice);
      }
    });

    return lista;
  }

  num _entrenaCivilesConHonda([num cantidad = 0]) {
    CivilConHonda tipoUnidad = new CivilConHonda(100, 1, 1, 100);
    num maxUnidadesEnEntrenamiento = tipoUnidad.getMaxUnidadesEnEntrenamiento();
    if (cantidad == 0) { cantidad = maxUnidadesEnEntrenamiento; }
    if (cantidad > maxUnidadesEnEntrenamiento) { cantidad = maxUnidadesEnEntrenamiento; }
    CentroDeInvestigacion myCI = this._capital.getCentroDeInvestigacion();
    if (myCI.estaComprada(2, 1, 1)) {
      this.setStatus ('Entrenando');
      bool esCorrecto = true;
      this._unidades.forEach( (x) {
        if (x.unidad.getID() == 1001) {
          num precio = x.unidad.getCosteUnitario();
          num importeTotal = precio * cantidad;
          num cantidadObtenida = this._capital.getPalacio().gastaOro(importeTotal);
          if (cantidadObtenida < importeTotal ) {
            this._capital.getPalacio().entraOro(cantidadObtenida);
            esCorrecto = false;
            return; // (' Se aborta el reclutamiento de ' + cantidad + x.unidad.getNombre() + ': Oro insuficiente');
          }
        }
      });

      if (esCorrecto == false) return -1;

      this._tipoUnidad = tipoUnidad;
      this._cantidad = cantidad;

      this._disp.addTareaRepetitiva(addUnidades, 5);
    } else {
      // console.log(' No se puede entrenar "Civiles con honda". La investigación no está realizada.');
    }

    return 0;
  }

  num _entrenaSoldados([num cantidad = 0]) {
    Soldado tipoUnidad = new Soldado(100, 1, 100, 100);
    num maxUnidadesEnEntrenamiento = tipoUnidad.getMaxUnidadesEnEntrenamiento();
    if (cantidad == 0) { cantidad = maxUnidadesEnEntrenamiento; }
    if (cantidad > maxUnidadesEnEntrenamiento) { cantidad = maxUnidadesEnEntrenamiento; }
    CentroDeInvestigacion myCI = this._capital.getCentroDeInvestigacion();
    if (myCI.estaComprada(2, 1, 2)) {
      // console.log(' Se inicia reclutamiento de unidades de infanteria: "Civiles con honda".');
      this.setStatus ('Entrenando');
      bool esCorrecto = true;
      this._unidades.forEach( (x) {
        if (x.unidad.getID() == 1002) {
          num precio = x.unidad.getCosteUnitario();
          num importeTotal = precio * cantidad;
          num cantidadObtenida = this._capital.getPalacio().gastaOro(importeTotal);
          if (cantidadObtenida < importeTotal ) {
            this._capital.getPalacio().entraOro(cantidadObtenida);
            esCorrecto = false;
            return; //alert (' Se aborta el reclutamiento de ' + cantidad + x.unidad.getNombre() + ': Oro insuficiente');
          }
        }
      });

      if (esCorrecto == false) return -1;

      this._tipoUnidad = tipoUnidad;
      this._cantidad = cantidad;

      this._disp.addTareaRepetitiva(addUnidades, 5);
    } else {
      // console.log(' No se puede entrenar "Soldados". La investigación no está realizada.');
    }

    return 0;
  }

  num entrena( Unidades tipoUnidad) {
    num resp;
    switch (tipoUnidad.unidad.getID()) {
      case 1001:
        resp = this._entrenaCivilesConHonda();
        break;
      case 1002:
        resp = this._entrenaSoldados();
        break;
    }

    return resp;
  }
}

class Unidades {
  UnidadMilitar unidad;
  num cantidad;

  Unidades (this.unidad, this.cantidad);
}
