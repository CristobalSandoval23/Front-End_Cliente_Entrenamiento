
import 'dart:io';

import 'package:entrenamiento_usuario/models/crear_ejercicio_model.dart';
import 'package:entrenamiento_usuario/providers/ejercicios_provider.dart';

import 'package:rxdart/rxdart.dart';

class EjercicioBloc {

  final _ejerciciosController = new BehaviorSubject<List<EjercicioModel>>();
  final _cargandoController  = new BehaviorSubject<bool>();

  final _ejerciciosProvider   = new EjerciciosProvider();


  Stream<List<EjercicioModel>> get ejercicioStream => _ejerciciosController.stream;
  Stream<bool> get cargando => _cargandoController.stream;



  void cargarEjercicios() async {


    final ejercicios = await _ejerciciosProvider.cargarEjercicios();
    _ejerciciosController.sink.add( ejercicios );
  }
  void buscarEjercicios(String query) async {


    final ejercicios = await _ejerciciosProvider.buscarEjercicios(query);
    _ejerciciosController.sink.add( ejercicios );
  }


  void agregarEjercicio( EjercicioModel ejercicio ) async {

    _cargandoController.sink.add(true);
    await _ejerciciosProvider.crearEjercicio(ejercicio);
    _cargandoController.sink.add(false);

  }

  Future<String> subirFoto( File foto ) async {

    _cargandoController.sink.add(true);
    final fotoUrl = await _ejerciciosProvider.subirImagen(foto);
    _cargandoController.sink.add(false);

    return fotoUrl;

  }


   void editarEjercicio( EjercicioModel ejercicio ) async {

    _cargandoController.sink.add(true);
    await _ejerciciosProvider.editarEjercicio(ejercicio);
    _cargandoController.sink.add(false);

  }

  void borrarEjercicio( String id ) async {

    await _ejerciciosProvider.borrarEjercicio(id);

  }


  dispose() {
    _ejerciciosController?.close();
    _cargandoController?.close();
  }

}