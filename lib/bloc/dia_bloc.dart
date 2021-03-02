
import 'dart:io';

import 'package:entrenamiento_usuario/models/crear_dia_del_usuario_model.dart';
import 'package:entrenamiento_usuario/providers/dia_provider.dart';


import 'package:rxdart/rxdart.dart';

class DiaBloc {

  final _diaController = new BehaviorSubject<List<DiaModel>>();
  final _cargandoController  = new BehaviorSubject<bool>();

  final _diaProvider   = new DiaProviders();


  Stream<List<DiaModel>> get diaStream => _diaController.stream;
  Stream<bool> get cargando => _cargandoController.stream;



  void cargarDia() async {

    final dia = await _diaProvider.cargarDias();
    _diaController.sink.add( dia );
  }


  void agregarDia( DiaModel dia ) async {

    _cargandoController.sink.add(true);
    await _diaProvider.crearDia(dia);
    _cargandoController.sink.add(false);

  }

  Future<String> subirFoto( File foto ) async {

    _cargandoController.sink.add(true);
    final fotoUrl = await _diaProvider.subirImagen(foto);
    _cargandoController.sink.add(false);

    return fotoUrl;

  }


   void editarDia( DiaModel dia ) async {

    _cargandoController.sink.add(true);
    await _diaProvider.editarDia(dia);
    _cargandoController.sink.add(false);

  }

  void borrarDia( String id ) async {

    await _diaProvider.borrarDia(id);

  }


  dispose() {
    _diaController?.close();
    _cargandoController?.close();
  }

}