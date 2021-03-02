
import 'dart:io';

import 'package:entrenamiento_usuario/models/datos_corporales.dart';
import 'package:entrenamiento_usuario/providers/datos_corporales_provider.dart';

import 'package:rxdart/rxdart.dart';

class DatosCorporalesBloc {

  final _datosCorporalesController = new BehaviorSubject<List<DatosCorporalesModel>>();
  final _cargandoController  = new BehaviorSubject<bool>();

  final _datosCorporalesProvider   = new DatosCorporalesProviders();


  Stream<List<DatosCorporalesModel>> get datosCorporalesStream => _datosCorporalesController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  // void cargarmicrociclos(String filtro) async {
  void cargarDatosCorporales() async {

    final microciclo = await _datosCorporalesProvider.cargarDatosCorporales();
    _datosCorporalesController.sink.add(microciclo );
  }

  Future<String> subirFoto( File foto ) async {

    _cargandoController.sink.add(true);
    final fotoUrl = await _datosCorporalesProvider.subirImagen(foto);
    _cargandoController.sink.add(false);

    return fotoUrl;

  }

  dispose() {
    _datosCorporalesController?.close();
    _cargandoController?.close();
  }

}