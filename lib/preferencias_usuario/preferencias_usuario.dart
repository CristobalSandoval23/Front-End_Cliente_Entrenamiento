import 'package:shared_preferences/shared_preferences.dart';

/*
  Recordar instalar el paquete de:
    shared_preferences:

  Inicializar en el main
    final prefs = new PreferenciasUsuario();
    prefs.initPrefs();

*/

class PreferenciasUsuario {

  static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET de la última página
  get token {
    return _prefs.getString('token') ?? '';
  }

  set token( String value ) {
    _prefs.setString('token', value);
  }
  get idLocal {
    return _prefs.getString('localId') ?? '';
  }

  set idLocal( String value ) {
    _prefs.setString('localId', value);
  }
  

  // GET y SET de la última página
  get ultimaPagina {
    return _prefs.getString('ultimaPagina') ?? 'login';
  }

  set ultimaPagina( String value ) {
    _prefs.setString('ultimaPagina', value);
  }
    get idLocalToken {
    return _prefs.getString('localId') ?? '';
  }

  set idLocalToken( String value ) {
    _prefs.setString('localId', value);
  }
      get idCliente {
    return _prefs.getString('idDelUsuario') ?? '';
  }

  set idCliente( String value ) {
    _prefs.setString('idDelUsuario', value);
  }
    get numeroMicrociclo {
    return _prefs.getString('numeroDelMicrociclo') ?? '';
  }

  set numeroMicrociclo( String value ) {
    _prefs.setString('numeroDelMicrociclo', value);
  }
        get diaSesion {
    return _prefs.getString('nombreDia') ?? '';
  }

  set diaSesion( String value ) {
    _prefs.setString('nombreDia', value);
  }
        get correoUsuario {
    return _prefs.getString('email') ?? '';
  }

  set correoUsuario( String value ) {
    _prefs.setString('email', value);
  }
  //       get contrasenaRestaurar {
  //   return _prefs.getString('id') ?? '';
  // }

  // set contrasenaRestaurar( String value ) {
  //   _prefs.setString('email', value);
  // }
        get temporizador {
    return _prefs.getInt('descanso') ?? '';
  }

  set temporizador( int value ) {
    _prefs.setInt('descanso', value);
  }
        get nombreDelCliente {
    return _prefs.getString('nombreUsuario') ?? '';
  }

  set nombreDelCliente( String value ) {
    _prefs.setString('nombreUsuario', value);
  }
        get urlVideoYoutube {
    return _prefs.getString('urlVideoYoutube') ?? '';
  }

  set urlVideoYoutube( String value ) {
    _prefs.setString('urlVideoYoutube', value);
  }
}

