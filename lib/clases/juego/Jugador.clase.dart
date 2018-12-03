enum TipoJugador { SIN_JUEGO, EMPERADOR, SATRAPA, JEFE_DE_TRIBU }

class Jugador {
  int _idJugador;
  int _idUsuario;
  String _nombre;
  TipoJugador _tipo;
  Jugador (this._idJugador, this._idUsuario, this._nombre, this._tipo) {

  }

  int getID() { return this._idJugador; }
  int getUsuario() { return this._idUsuario; }
  String getNombre() { return this._nombre; }
  TipoJugador getTipo() { return this._tipo; }
}