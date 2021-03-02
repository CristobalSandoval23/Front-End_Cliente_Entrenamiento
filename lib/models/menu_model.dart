

import 'package:flutter/widgets.dart';

class MenuModel with ChangeNotifier {

  int _itemSeleccionado = 0;

  // Color backgroundColor = Colors.white;
  // Color activeColor     = Colors.black;
  // Color inactiveColor   = Colors.blueGrey;


  int get itemSeleccionado => this._itemSeleccionado;

  set itemSeleccionado( int index ) {
    this._itemSeleccionado = index;
    notifyListeners();
  }

}