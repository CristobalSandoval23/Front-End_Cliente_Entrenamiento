import 'dart:async';
import 'package:entrenamiento_usuario/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {


  final _emailController    = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _displayNameController = BehaviorSubject<String>();

  // Recuperar los datos del Stream
  Stream<String> get emailStream    => _emailController.stream.transform( validarEmail );
  Stream<String> get passwordStream => _passwordController.stream.transform( validarPassword );
  Stream<String> get displayNameStream => _displayNameController.stream.transform( validardisplayName );

  Stream<bool> get formValidStream => 
      CombineLatestStream.combine3(emailStream, passwordStream, displayNameStream, (e, p, d) => true );
  Stream<bool> get formValidStreamLogin => 
      CombineLatestStream.combine2(emailStream, passwordStream, (e, p,) => true );



  // Insertar valores al Stream
  Function(String) get changeEmail    => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeDisplayName => _displayNameController.sink.add;


  // Obtener el último valor ingresado a los streams
  String get email    => _emailController.value;
  String get password => _passwordController.value;
  String get displayName => _displayNameController.value;

  dispose() {
    _emailController?.close();
    _passwordController?.close();
    _displayNameController?.close();
  }

}

