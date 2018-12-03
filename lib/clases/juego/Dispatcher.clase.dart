import 'dart:async';

class Tarea {  
  Function _funcion;
  DateTime _vencimiento;
  num _delta;
  bool _eliminada = false;

  Tarea (this._funcion, this._vencimiento, this._delta) {}

  DateTime getVencimiento() {return this._vencimiento; }

  setVencimiento () {
    this._vencimiento.add(new Duration(seconds: this._delta));
  }

  String getNombreFuncion() { return this._funcion.toString(); }

  int execFuncion() {
    int valor = this._funcion();  
    return valor;
  }
}

class Dispatcher {
  List<Tarea> listaDeTareas = new List<Tarea>();

  Dispatcher() {
    const oneSec = const Duration(seconds:1);
    new Timer.periodic(oneSec, (Timer t) => this.ejecuta(this.listaDeTareas.toList()));
  }

  addTareaRepetitiva(Function f, num tiempo) {
    DateTime nuevoVencimiento;
    Tarea t;

    nuevoVencimiento = new DateTime.now();
    nuevoVencimiento.add(new Duration(seconds: tiempo));

    t = new Tarea(f, nuevoVencimiento, tiempo);

    this.listaDeTareas.add(t);
  }

  nada() {}

  ejecuta(List<Tarea> lista) {    
    DateTime horaActual = new DateTime.now();
    num numTareas = lista.length;

    if (numTareas > 0) {      
      lista.forEach((tarea) {
        if (tarea._eliminada == false) {
          if (tarea.getVencimiento().isBefore(horaActual)) {
            tarea.setVencimiento();
            num rt = tarea.execFuncion();
            if (rt == -1) {
              //print("Eliminamos tarea ${tarea.getNombreFuncion()}");
              tarea._eliminada = true;
            }            
          }
        }
      });
    }
  }
}