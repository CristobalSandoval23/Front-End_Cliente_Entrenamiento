import 'package:flutter/material.dart';

import 'package:entrenamiento_usuario/widgets/custom_widgets.dart';
import 'package:entrenamiento_usuario/bloc/microciclo_bloc.dart';
import 'package:entrenamiento_usuario/bloc/provider_local.dart';
import 'package:entrenamiento_usuario/models/crear_microciclo_del_usuario_model.dart';
import 'package:entrenamiento_usuario/preferencias_usuario/preferencias_usuario.dart';

 class HomeRutinaDelUsuarioSeleccionadoPage
  extends StatefulWidget {
  @override
  _HomeRutinaDelUsuarioSeleccionadoPageState createState() => _HomeRutinaDelUsuarioSeleccionadoPageState();
}

class _HomeRutinaDelUsuarioSeleccionadoPageState extends State<HomeRutinaDelUsuarioSeleccionadoPage> {
  
            final _prefs = new PreferenciasUsuario();
      
  @override
  Widget build(BuildContext context ) {
    final microciclosBloc = ProviderLocal.microciclosBlog(context);
    microciclosBloc.cargarmicrociclos();
    return Scaffold(
        backgroundColor:  Color(0xFF7A9BEE),
      appBar: AppBar(
        backgroundColor: Color(0xFF7A9BEE),
        leading:  
        IconButton( 
          icon: Icon(Icons.keyboard_arrow_left),
          onPressed: (){
              Navigator.popAndPushNamed(context,'inicio');}
              ),
          elevation: 0.0,
          title: Text('Sus microciclos')
      ),
      body:
          Stack(
              children: <Widget>[
                FondoDisenoHome(contexto: context, altura: 10,),
                    SizedBox(height:100,),
                    _crearListado(microciclosBloc),     
              ]
          )
    );
  }

  Widget _crearListado(MicrocicloBloc microciclosBloc) {

    return StreamBuilder(
                      stream: microciclosBloc.microciclosStream,
                      builder: (BuildContext context, AsyncSnapshot<List<MicrocicloModel>> snapshot) {
                        if ( snapshot.hasData ) {

                          final microciclo = snapshot.data;
                           
                            return  ListView.builder(
                              padding: EdgeInsets.symmetric(
                                                horizontal: 20,
                                                vertical  : 30,),
                              itemCount: microciclo.length,
                              itemBuilder: (context, i) => _crearItem(context, microciclo[i] ),

                          );

                        } else {
                          return Center( child: CircularProgressIndicator());
                        }
                      },
                    );

  }   

  Widget _crearItem(BuildContext context , MicrocicloModel microciclo ) {

    return ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Card(
                shadowColor: Colors.black,
                elevation: 20,
            child: Column(
              children: <Widget>[
                
                ListTile(
                  
                  title: Text('Entrenamiento de la semana: ${ microciclo.numeroDelMicrociclo }'),

                  subtitle: Text( 'Objetivo de la semana: ${microciclo.objetivoMicrociclo}' ),
                  onTap: () {
                    if (microciclo.id2 != null) {
                        _prefs.diaSesion = microciclo.dia;
                        _prefs.numeroMicrociclo = microciclo.numeroDelMicrociclo.toString();
                        Navigator.pushNamed( context, 'EjerciciosDelDiaSeleccionado',);
                    } 
                } 
                ),

              ],
            ),
        ),
    );



  }


} 
  
  

