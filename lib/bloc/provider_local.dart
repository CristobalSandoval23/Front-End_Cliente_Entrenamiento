import 'package:entrenamiento_usuario/bloc/datos_corporales_bloc.dart';
import 'package:entrenamiento_usuario/bloc/dia_bloc.dart';
import 'package:entrenamiento_usuario/bloc/microciclo_bloc.dart';
import 'package:entrenamiento_usuario/bloc/rutina_bloc.dart';
import 'package:entrenamiento_usuario/bloc/usuarios_bloc.dart';
import 'package:entrenamiento_usuario/bloc/ejercicio_bloc.dart';
import 'package:flutter/material.dart';

import 'package:entrenamiento_usuario/bloc/login_bloc.dart';
export 'package:entrenamiento_usuario/bloc/login_bloc.dart';

export 'package:entrenamiento_usuario/bloc/productos_bloc.dart';


class ProviderLocal extends InheritedWidget {

  final loginBloc      = new LoginBloc();
  final _rutinaBlog = new RutinaBloc();
  final _diaBlog = new DiaBloc();
  final _microcicloBlog = new MicrocicloBloc();
  final _datosUsuariosBlog = new UsuariosBloc();
    final _ejercicioBloc = new EjercicioBloc();
    final _datosCorporalesBloc = new DatosCorporalesBloc();

  static ProviderLocal _instancia;

  factory ProviderLocal({ Key key, Widget child }) {

    if ( _instancia == null ) {
      _instancia = new ProviderLocal._internal(key: key, child: child );
    }

    return _instancia;

  }

  ProviderLocal._internal({ Key key, Widget child })
    : super(key: key, child: child );


  

  // Provider({ Key key, Widget child })
  //   : super(key: key, child: child );

 
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of ( BuildContext context ) {
   return context.dependOnInheritedWidgetOfExactType<ProviderLocal>().loginBloc;
  }
    static EjercicioBloc ejerciciosBlog ( BuildContext context ) {
   return context.dependOnInheritedWidgetOfExactType<ProviderLocal>()._ejercicioBloc;
  }
    static DiaBloc diasBlog ( BuildContext context ) {
   return context.dependOnInheritedWidgetOfExactType<ProviderLocal>()._diaBlog;
  }
    static MicrocicloBloc microciclosBlog ( BuildContext context ) {
   return context.dependOnInheritedWidgetOfExactType<ProviderLocal>()._microcicloBlog;
  }
    static RutinaBloc rutinaBlog ( BuildContext context ) {
   return context.dependOnInheritedWidgetOfExactType<ProviderLocal>()._rutinaBlog;
  }
      static UsuariosBloc usuariosBlog ( BuildContext context ) {
   return context.dependOnInheritedWidgetOfExactType<ProviderLocal>()._datosUsuariosBlog;
  }
      static DatosCorporalesBloc datosCorporalesBlog ( BuildContext context ) {
   return context.dependOnInheritedWidgetOfExactType<ProviderLocal>()._datosCorporalesBloc;
  }
}