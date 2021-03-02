import 'package:flutter/material.dart';

import 'package:entrenamiento_usuario/search/search_delegate.dart';
import 'package:entrenamiento_usuario/widgets/custom_widgets.dart';
import 'package:entrenamiento_usuario/bloc/ejercicio_bloc.dart';
import 'package:entrenamiento_usuario/bloc/provider_local.dart';
import 'package:entrenamiento_usuario/models/crear_ejercicio_model.dart';

 class HomeListaEjercicio
  extends StatefulWidget {
  @override
  _HomeListaEjercicioState createState() => _HomeListaEjercicioState();
}

class _HomeListaEjercicioState extends State<HomeListaEjercicio> {

  @override
  Widget build(BuildContext context ) {
    final ejerciciosBloc = ProviderLocal.ejerciciosBlog(context);
    ejerciciosBloc.cargarEjercicios();
    return Scaffold(
      backgroundColor:  Color(0xFF7A9BEE),
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
          ),
         actions: <Widget>[
                      IconButton(
                        icon: Icon( Icons.search ),
                        onPressed: () {
                          showSearch(
                            context: context, 
                            delegate: DataSearch(),
                            // query: 'Hola'
                            );
                        },
                      )
                    ],
          backgroundColor: Color(0xFF7A9BEE),
          elevation: 0.0,
          title: Text('Lista de ejercicios',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18.0,
                  color: Colors.white)),
          centerTitle: true,
        ),
        
      body: 
      Stack(
        children: <Widget>[
          FondoDisenoHome(contexto: context,),
           _crearListado(ejerciciosBloc),
        ],
      ),      
      // // floatingActionButton: _crearBoton( context ),
    );
  }
  


  Widget _crearListado(EjercicioBloc ejerciciosBloc) {

    return StreamBuilder(
        stream: ejerciciosBloc.ejercicioStream,
        builder: (BuildContext context, AsyncSnapshot<List<EjercicioModel>> snapshot) {
          if ( snapshot.hasData ) {

            final ejercicio = snapshot.data;
              
              return  ListView.builder(
                itemCount: ejercicio.length,
                itemBuilder: (context, i) => _crearItem(context, ejerciciosBloc, ejercicio[i] ),

            );

          } else {
            return Center( child: CircularProgressIndicator());
          }
        },
      );

  }

  Widget _crearItem(BuildContext context, EjercicioBloc ejerciciosBloc, EjercicioModel ejercicio ) {

    return SingleChildScrollView(
      child: Column(
      children: <Widget>[
         SizedBox(height: 60),
        EjercicioSizePreview(
            argumentos: ejercicio,
            imagenSeleccionada: 'https://i.pinimg.com/originals/dc/e3/bf/dce3bf93e7eec8a17ff8255c3ce1510f.png',
            urlYoutube: ejercicio.videoUrlYoutube,
            idUnico: ejercicio.id,      
            ),
          
        SizedBox(height: 20,),
        ZapatoDescripcion(
          titulo: ejercicio.nombreEjercicio, 
          subtitulo: ejercicio.clasificacion,
          categoria: true,
          ),
           SizedBox(height: 20),
      ], 
     ),
   );
  }

 

} 
  
  

