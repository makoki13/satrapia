///TODO
enum TipoRecurso { NATURAL, FABRICADO, MILITAR }

Recurso ORO = new Recurso (1, 'ORO', TipoRecurso.NATURAL);
Recurso POBLACION = new Recurso (2, 'POBLACION', TipoRecurso.MILITAR);
Recurso COMIDA = new Recurso (3, 'COMIDA', TipoRecurso.NATURAL);
Recurso MADERA = new Recurso (4, 'MADERA', TipoRecurso.NATURAL);
Recurso PIEDRA = new Recurso (4, 'PIEDRA', TipoRecurso.NATURAL);
Recurso HIERRO = new Recurso (5, 'HIERRO', TipoRecurso.NATURAL);

class Recurso {
  String _nombre;
  int _id;
  TipoRecurso _tipo;

  Recurso (this._id, this._nombre, this._tipo) {}

  String getNombre() { return this._nombre; }
  int getID() { return this._id; }
  TipoRecurso getTipo() { return this._tipo; }
}

class UnidadMilitar extends Recurso {
  int _danyoRecibido = 0;
  
  int _vidaInicial;
  int _danyoInflingido;
  int _fuerza;
  int _moral;
  int _costeUnitario;
  int maxUnidadesEnEntrenamiento;

  UnidadMilitar (int id, String nombre, this._vidaInicial, this._danyoInflingido, this._fuerza, this._moral, this._costeUnitario, this.maxUnidadesEnEntrenamiento) :
        super (id, nombre, TipoRecurso.MILITAR) {
  }

  int getVidaInicial() { return this._vidaInicial; }
  int getDanyoInflingido() { return this._danyoInflingido; }
  int getFuerza() { return this._fuerza; }
  int getMoral() { return this._moral; }

  int getCosteUnitario() { return this._costeUnitario; }
  int getMaxUnidadesEnEntrenamiento() { return this.maxUnidadesEnEntrenamiento; }

  void aumentaDanyoRecibido (int aumento) { this._danyoRecibido += aumento; }
}

class CivilConHonda extends UnidadMilitar {
  CivilConHonda (int vidaInicial, int danyoInflingido, int fuerza, int moral) :  super ( 1001, 'Civil con honda', vidaInicial, danyoInflingido, fuerza, moral, 1, 10) {}
}

class Soldado extends UnidadMilitar {
  Soldado (int vidaInicial, int danyoInflingido, int fuerza, int moral) : super ( 1002, 'Soldado', vidaInicial, danyoInflingido, fuerza, moral, 10, 10) {}
}

class Arquero extends UnidadMilitar {
  Arquero (int vidaInicial, int danyoInflingido, int fuerza, int moral) : super ( 1003, 'Arquero', vidaInicial, danyoInflingido, fuerza, moral, 5, 10) {}
}

class Lancero extends UnidadMilitar {
  Lancero (int vidaInicial, int danyoInflingido, int fuerza, int moral) : super ( 1002, 'Soldado', vidaInicial, danyoInflingido, fuerza, moral, 10, 10) {}
}