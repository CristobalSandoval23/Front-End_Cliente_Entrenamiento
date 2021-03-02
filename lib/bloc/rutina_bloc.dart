
import 'dart:io';

import 'package:entrenamiento_usuario/models/rutina_semanal_model.dart';
import 'package:entrenamiento_usuario/providers/rutina_providers.dart';
import 'package:rxdart/rxdart.dart';

class RutinaBloc {

  final _rutinaController = new BehaviorSubject<List<RutinaModel>>();
  final _cargandoController  = new BehaviorSubject<bool>();

  final _rutinaProvider   = new RutinaProviders();


  Stream<List<RutinaModel>> get rutinaStream => _rutinaController.stream;
  Stream<bool> get cargando => _cargandoController.stream;



  void cargarRutina(String dato) async {

    final rutinas = await _rutinaProvider.cargarRutina(dato);
    _rutinaController.sink.add( rutinas );
  }


  void agregarRutina( RutinaModel rutina ) async {

    _cargandoController.sink.add(true);
    await _rutinaProvider.crearRutina(rutina);
    _cargandoController.sink.add(false);

  }

  Future<String> subirFoto( File foto ) async {

    _cargandoController.sink.add(true);
    final fotoUrl = await _rutinaProvider.subirImagen(foto);
    _cargandoController.sink.add(false);

    return fotoUrl;

  }


   void editarRutina( RutinaModel rutina ) async {

    _cargandoController.sink.add(true);
    await _rutinaProvider.editarRutina(rutina);
    _cargandoController.sink.add(false);

  }

  void borrarRutina( String id ) async {

    await _rutinaProvider.borrarRutina(id);

  }


  dispose() {
    _rutinaController?.close();
    _cargandoController?.close();
  }

}