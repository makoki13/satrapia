import 'package:scoped_model/scoped_model.dart';
import 'dart:async';

/*
abstract class AbstractModel extends Model {
  void notifica();
}
*/

class ModeloPrincipal extends Model {
  void notifica() async {
    // Then notify all the listeners.
    notifyListeners();
  }
}