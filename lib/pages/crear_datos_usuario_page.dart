import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:entrenamiento_usuario/bloc/usuarios_bloc.dart';
import 'package:entrenamiento_usuario/bloc/provider_local.dart';
import 'package:entrenamiento_usuario/models/crear_usuarios_model.dart';
import 'package:entrenamiento_usuario/preferencias_usuario/preferencias_usuario.dart';
import 'package:entrenamiento_usuario/providers/datos_de_sus_usuarios_provider.dart';

class PerfilPage extends StatefulWidget {
  @override
  _RutinaPageState createState() => _RutinaPageState();
}

class _RutinaPageState extends State<PerfilPage> {

  final String dia = '';
  final formKey     = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  UsuariosBloc usuarioBloc;
  UsuariosModel usuario = new UsuariosModel();

  bool _guardando = false;
  File foto;
  final rutinaprovider = new DatosUsuariosProviders();
  final prefs = new PreferenciasUsuario();
    

  String opcionSeleccionada = 'Lunes';

  @override
  Widget build(BuildContext context) {

        usuarioBloc = ProviderLocal.usuariosBlog(context);
  
     final UsuariosModel prodData = ModalRoute.of(context).settings.arguments;
    if ( prodData != null ) {
      usuario = prodData;
    }
    
    return SafeArea(
          child: Scaffold(
        appBar: AppBar(
                    leading: IconButton(
              onPressed: () {
                  // Navigator.popAndPushNamed(context,'inicio');
                    Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.white,
            ),
             backgroundColor: Colors.blue,
          title: Text('Usuario'),
          actions: <Widget>[
            IconButton(
              icon: Icon( Icons.photo_size_select_actual ),
              onPressed: _seleccionarFoto,
            ),
            IconButton(
              icon: Icon( Icons.camera_alt ),
              onPressed: _tomarFoto,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                   SizedBox(height: 10.0),
                   _mostrarFoto(),
                  SizedBox(height: 10.0),
                  _crearNombre(),
                  _crearApellido(),
                  _crearNombreApodo(),
                  _crearEdad(),
                  _crearCorreo(),
                  _crearDireccion(),
                  _crearContrasena(),
                  _crearBoton()
                ],
              ),
            ),
          ),
        ),
      ),
    );

  }

  Widget _crearCorreo() {
  return TextFormField(
    
    initialValue: usuario.email,
    textCapitalization: TextCapitalization.sentences,
    decoration: InputDecoration(
      labelText: 'Su correo'
    ),
    onSaved: (value) => usuario.email = value,
    validator: (value) {
      if ( value.length < 3 ) {
        return 'Ingrese su correo';
      } else {
        return null;
      }
    }, onChanged: (valor){
      setState(() {
    //    _nombre = valor;
      });
    },
  );

  }

  Widget _crearEdad() {

  return TextFormField(
    
    initialValue: usuario.edad,
    textCapitalization: TextCapitalization.sentences,
    decoration: InputDecoration(
      labelText: 'Su edad'
    ),
    onSaved: (value) => usuario.edad = value,
    validator: (value) {
      if ( value.length < 1 ) {
        return 'Ingrese su edad';
      } else {
        return null;
      }
    }, onChanged: (valor){
      setState(() {
    //    _nombre = valor;
      });
    },
  );

  }

  Widget _crearNombre() {

  return TextFormField(
    
    initialValue: usuario.nombreUsuario,
    textCapitalization: TextCapitalization.sentences,
    decoration: InputDecoration(
      labelText: 'Su nombre'
    ),
    onSaved: (value) => usuario.nombreUsuario = value,
    validator: (value) {
      if ( value.length < 3 ) {
        return 'Ingrese su nombre';
      } else {
        return null;
      }
    }, onChanged: (valor){
      setState(() {
    //    _nombre = valor;
      });
    },
  );

  }

  Widget _crearApellido() {

  return TextFormField(
    
    initialValue: usuario.apellido,
    textCapitalization: TextCapitalization.sentences,
    decoration: InputDecoration(
      labelText: 'Su apellido'
    ),
    onSaved: (value) => usuario.apellido = value,
    validator: (value) {
      if ( value.length < 3 ) {
        return 'Ingrese su apellido';
      } else {
        return null;
      }
    }, onChanged: (valor){
      setState(() {
    //    _nombre = valor;
      });
    },
  );

  }

  Widget _crearNombreApodo() {

  return TextFormField(
    
    initialValue: usuario.nombreApp,
    textCapitalization: TextCapitalization.sentences,
    decoration: InputDecoration(
      labelText: 'Su apodo'
    ),
    onSaved: (value) => usuario.nombreApp = value,
    validator: (value) {
      if ( value.length < 3 ) {
        return 'Ingrese su apodo';
      } else {
        return null;
      }
    }, onChanged: (valor){
      setState(() {
    //    _nombre = valor;
      });
    },
  );

  }

  Widget _crearDireccion() {

  return TextFormField(
    
    initialValue: usuario.direccion,
    textCapitalization: TextCapitalization.sentences,
    decoration: InputDecoration(
      labelText: 'Su direcciòn'
    ),
    onSaved: (value) => usuario.direccion = value,
    validator: (value) {
      if ( value.length < 3 ) {
        return 'Ingrese su direcciòn';
      } else {
        return null;
      }
    }, onChanged: (valor){
      setState(() {
    //    _nombre = valor;
      });
    },
  );

  }

  Widget _crearContrasena() {

    return TextFormField(
    initialValue: usuario.contrasena,
    textCapitalization: TextCapitalization.sentences,
    decoration: InputDecoration(
      labelText: 'Su contraseña'
    ),
    onSaved: (value) => usuario.contrasena = value,
    validator: (value) {
      if ( value.length < 3 ) {
        return 'Su contraseña';
      } else {
        return null;
      }
    },
  );

  }

  Widget _crearBoton() {
  return RaisedButton.icon(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0)
    ),
    color: Colors.white,
    textColor: Colors.blue,
    label: Text('Guardar'),
    icon: Icon( Icons.save ),
    onPressed: ( _guardando ) ? null : _submit,
  );
  }

  void _submit() async {



  if ( !formKey.currentState.validate() ) return;

  formKey.currentState.save();
  usuario.creador = prefs.idLocalToken ;
  prefs.nombreDelCliente = usuario.nombreUsuario;

  setState(() {_guardando = true; });

  if ( foto != null ) {
    usuario.fotoUrl = await usuarioBloc.subirFoto(foto);
  }



  if ( usuario.idDelUsuario == null ) {
    usuarioBloc.agregarUsuario(usuario);
  } else {
    usuarioBloc.editarUsuario(usuario);
  }


  // setState(() {_guardando = false; });
  mostrarSnackbar('Registro guardado');

    Navigator.popAndPushNamed(context,'inicio');

  }

  void mostrarSnackbar(String mensaje) {

    final snackbar = SnackBar(
    backgroundColor: Colors.pink,
    content: Text('Registro guardado',textAlign: TextAlign.center,style: TextStyle( fontSize: 17.0, fontWeight: FontWeight.bold),),
    duration: Duration( milliseconds: 1500),
  );

  scaffoldKey.currentState.showSnackBar(snackbar);
  // esperar1();

  }

  Future esperar1() {
  return new Future.delayed(const Duration(milliseconds: 1800), () => Navigator.pop(context));
  }

  Widget _mostrarFoto() {

  if (usuario.fotoUrl != null) {

    return Container();

  } else {

    if( foto != null ){
      return Image.file(
        foto,
        fit: BoxFit.cover,
        width: 170.0,
        height: 170.0,
      );
    }
    return Image.asset('assets/no-image.png');
  }
  }

  _seleccionarFoto() async {

  _procesarImagen( ImageSource.gallery );

  }

  _tomarFoto() async {

  _procesarImagen( ImageSource.camera );

  }

  _procesarImagen( ImageSource origen ) async {

  foto = await ImagePicker.pickImage(
    source: origen
  );

  if ( foto != null ) {
    usuario.fotoUrl = null;
  }

  setState(() {});

  }


}



