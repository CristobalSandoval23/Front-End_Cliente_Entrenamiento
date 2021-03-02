
import 'dart:io';

import 'package:entrenamiento_usuario/models/crear_microciclo_del_usuario_model.dart';

import 'package:entrenamiento_usuario/providers/microciclo_provider.dart';


import 'package:rxdart/rxdart.dart';

class MicrocicloBloc {

  final _microciclosController = new BehaviorSubject<List<MicrocicloModel>>();
  final _cargandoController  = new BehaviorSubject<bool>();

  final _microciclosProvider   = new MicrocicloProviders();


  Stream<List<MicrocicloModel>> get microciclosStream => _microciclosController.stream;
  Stream<bool> get cargando => _cargandoController.stream;



  // void cargarmicrociclos(String filtro) async {
  void cargarmicrociclos() async {

    final microciclo = await _microciclosProvider.cargarMicrociclos();
    _microciclosController.sink.add(microciclo );
  }


  void agregarMicrociclos( MicrocicloModel microciclo ) async {

    _cargandoController.sink.add(true);
    await _microciclosProvider.crearMicrociclo(microciclo);
    _cargandoController.sink.add(false);

  }

  Future<String> subirFoto( File foto ) async {

    _cargandoController.sink.add(true);
    final fotoUrl = await _microciclosProvider.subirImagen(foto);
    _cargandoController.sink.add(false);

    return fotoUrl;

  }


   void editarMicrociclos( MicrocicloModel microciclo ) async {

    _cargandoController.sink.add(true);
    await _microciclosProvider.editarMicrociclo(microciclo);
    _cargandoController.sink.add(false);

  }

  void borrarMicrociclos( String id ) async {

    await _microciclosProvider.borrarMicrociclo(id);

  }


  dispose() {
    _microciclosController?.close();
    _cargandoController?.close();
  }

}