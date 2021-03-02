import 'package:flutter/material.dart';

import 'package:entrenamiento_usuario/bloc/provider_local.dart';
import 'package:entrenamiento_usuario/bloc/rutina_bloc.dart';
import 'package:entrenamiento_usuario/models/rutina_semanal_model.dart';
import 'package:entrenamiento_usuario/preferencias_usuario/preferencias_usuario.dart';



class NotasPage extends StatefulWidget {
  NotasPage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<NotasPage> {

  RutinaBloc rutinaBloc;
  RutinaModel rutina = new RutinaModel();

  final estiloTitulo    = TextStyle( fontSize: 20.0, fontWeight: FontWeight.bold );
  final estiloSubTitulo = TextStyle( fontSize: 18.0, color: Colors.grey );
  final _prefs = PreferenciasUsuario();
  @override

  Widget build(BuildContext context,) {
    rutinaBloc = ProviderLocal.rutinaBlog(context);
   final RutinaModel prodData = ModalRoute.of(context).settings.arguments;
    if ( prodData != null ) {
      rutina = prodData;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
       title: Text('¿Qué opinas de la app?'),
       actions: [
              IconButton(
            onPressed: () {
              
            },
            icon: Icon(Icons.check),
            color: Colors.white,
          ),
       ],
      ),
      body: Container(
        child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
                      Divider(),
                      _crearTitulo(),
                      Divider(),
                        _crearNotas(),
                  ],
                ),
              ),
            ),
    );
  }


Widget _crearNotas() {
           return  TextField(
             
             keyboardType: TextInputType.multiline,
              maxLines: 10,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Que nos recomiendas que mejoremos',
                  hintText: 'El diseño, más funcionalidades, etc.'),
           );
}

Widget _crearTitulo() {
           return  TextField(
             
             keyboardType: TextInputType.multiline,
              // maxLines: 4,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Encabezado',
                  hintText: ''),
           );
}


}
