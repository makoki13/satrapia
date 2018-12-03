import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../api/models.dart';
import '../../api/api.dart';

class PartidaHome extends StatelessWidget {
  final String title;

  PartidaHome(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Cantidad de oro:',
            ),
            // Create a ScopedModelDescendant. This widget will get the
            // CounterModel from the nearest parent ScopedModel<CounterModel>.
            // It will hand that CounterModel to our builder method, and
            // rebuild any time the CounterModel changes (i.e. after we
            // `notifyListeners` in the Model).
            ScopedModelDescendant<ModeloPrincipal>(
              builder: (context, child, model) => Text(API.getOroActual().toString(),
                  style: Theme.of(context).textTheme.display1),
            ),
            Text(
              'Cantidad de población:',
            ),
            ScopedModelDescendant<ModeloPrincipal>(
              builder: (context, child, model) => Text(API.getPoblacionActual().toString(),
                  style: Theme.of(context).textTheme.display1),
            ),
            Text(
              'Comida:',
            ),
            ScopedModelDescendant<ModeloPrincipal>(
              builder: (context, child, model) => Text(API.getStockComida().toString(),
                  style: Theme.of(context).textTheme.display1),
            ),
            Text(
              'Madera:',
            ),
            ScopedModelDescendant<ModeloPrincipal>(
              builder: (context, child, model) => Text(API.getStockMadera().toString(),
                  style: Theme.of(context).textTheme.display1),
            ),
            Text(
              'Piedra:',
            ),
            ScopedModelDescendant<ModeloPrincipal>(
              builder: (context, child, model) => Text(API.getStockPiedra().toString(),
                  style: Theme.of(context).textTheme.display1),
            ),
            Text(
              'Hierro:',
            ),
            ScopedModelDescendant<ModeloPrincipal>(
              builder: (context, child, model) => Text(API.getStockHierro().toString(),
                  style: Theme.of(context).textTheme.display1),
            ),
          ],
        ),
      ),

      // Use the ScopedModelDescendant again in order to use the increment
      // method from the CounterModel
      floatingActionButton: ScopedModelDescendant<ModeloPrincipal>(
        builder: (context, child, model) => FloatingActionButton(
          onPressed: ()
          {
            model.notifica();
            //model.setCounterPoblacion(0);
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),

    );
  }
}