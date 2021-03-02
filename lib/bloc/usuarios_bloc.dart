
import 'dart:io';

// import 'package:mi_entrenamiento/src/models/entrenamiento_semanal_model.dart';
import 'package:entrenamiento_usuario/models/crear_usuarios_model.dart';
import 'package:entrenamiento_usuario/providers/datos_de_sus_usuarios_provider.dart';
// import 'package:mi_entrenamiento/src/models/respuesta_model.dart';

// import 'package:mi_entrenamiento/src/providers/entrenamiento_provider.dart';
// import 'package:mi_entrenamiento/src/providers/graficos_provider.dart';

// import 'package:mi_entrenamiento/src/providers/rutina_providers.dart';
import 'package:rxdart/rxdart.dart';

class UsuariosBloc {

  final _entrenamientoController = new BehaviorSubject<List<UsuariosModel>>();
  final _cargandoController  = new BehaviorSubject<bool>();

  final _entrenamientoProvider   = new DatosUsuariosProviders();


  Stream<List<UsuariosModel>> get entrenamientoStream => _entrenamientoController.stream;
  Stream<bool> get cargando => _cargandoController.stream;



  void cargarUsuarios() async {

    final rutinas = await _entrenamientoProvider.cargarUsuario();
    _entrenamientoController.sink.add( rutinas );
  }


  void agregarUsuario( UsuariosModel rutina ) async {

    _cargandoController.sink.add(true);
    await _entrenamientoProvider.crearUsuario(rutina);
    _cargandoController.sink.add(false);

  }

  Future<String> subirFoto( File foto ) async {

    _cargandoController.sink.add(true);
    final fotoUrl = await _entrenamientoProvider.subirImagen(foto);
    _cargandoController.sink.add(false);

    return fotoUrl;

  }


   void editarUsuario( UsuariosModel rutina ) async {

    _cargandoController.sink.add(true);
    await _entrenamientoProvider.editarUsuario(rutina);
    _cargandoController.sink.add(false);

  }

  void borrarUsuario( String id ) async {

    await _entrenamientoProvider.borrarRutina(id);

  }


  dispose() {
    _entrenamientoController?.close();
    _cargandoController?.close();
  }

}