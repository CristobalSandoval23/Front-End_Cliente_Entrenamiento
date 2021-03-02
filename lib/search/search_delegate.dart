
import 'package:entrenamiento_usuario/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

import 'package:entrenamiento_usuario/bloc/ejercicio_bloc.dart';
import 'package:entrenamiento_usuario/bloc/provider_local.dart';
import 'package:entrenamiento_usuario/models/crear_ejercicio_model.dart';

class DataSearch extends SearchDelegate {

  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones de nuestro AppBar
    return [
      IconButton(
        icon: Icon( Icons.clear ),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del AppBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
           query = '';
         close( context, null );
        //  Navigator.of(context).pop();
      },
    );
  }

  @override

  Widget buildResults(BuildContext context, ) {
      // Crea los resultados que vamos a mostrar
    
      final ejerciciosBloc = ProviderLocal.ejerciciosBlog(context);
      ejerciciosBloc.buscarEjercicios(query);
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
              return Center( child: CircularProgressIndicator(semanticsValue: 'No se encontro coincidencia evite los espacios y utilice Mayúsculas',));
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

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando la persona escribe

    final ejerciciosBloc = ProviderLocal.ejerciciosBlog(context);
    ejerciciosBloc.cargarEjercicios();
        return StreamBuilder(
        stream: ejerciciosBloc.ejercicioStream,
        builder: (BuildContext context, AsyncSnapshot<List<EjercicioModel>> snapshot) {
          if ( snapshot.hasData ) {

            final ejercicio = snapshot.data;
              
              return  ListView.builder(
                itemCount: ejercicio.length,
                itemBuilder: (context, i) => _crearItem2(context, ejerciciosBloc, ejercicio[i] ),

            );

          } else {
            return Center( child: CircularProgressIndicator());
          }
        },
      );
  }

  Widget _crearItem2(BuildContext context, EjercicioBloc ejerciciosBloc, EjercicioModel ejercicio ) {

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


