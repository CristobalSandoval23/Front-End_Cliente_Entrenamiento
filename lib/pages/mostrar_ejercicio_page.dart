import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:entrenamiento_usuario/bloc/ejercicio_bloc.dart';
import 'package:entrenamiento_usuario/bloc/provider_local.dart';
import 'package:entrenamiento_usuario/models/crear_ejercicio_model.dart';
import 'package:entrenamiento_usuario/preferencias_usuario/preferencias_usuario.dart';
import 'package:entrenamiento_usuario/widgets/custom_widgets.dart';

class MostrarEjercicioPage extends StatefulWidget {
  MostrarEjercicioPage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<MostrarEjercicioPage> {

  var selectedCard = 'WEIGHT';
  EjercicioBloc ejercicioBloc;
  EjercicioModel ejercicio = new EjercicioModel();

  final estiloTitulo    = TextStyle( color:Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold );

  
 YoutubePlayerController youtubeControler;
  @override
  
  @override
    void initState() { 

           final _prefs = PreferenciasUsuario();

    youtubeControler = YoutubePlayerController(
                      initialVideoId: YoutubePlayer.convertUrlToId(_prefs.urlVideoYoutube),
                      flags: YoutubePlayerFlags(
                        autoPlay: false, 
                        mute: false,
                        isLive: false) ,
                    );
    super.initState();
  
  }

  @override
    void dispose() { 
      youtubeControler.dispose();
      super.dispose();
    }
  Widget build(BuildContext context,) {
    ejercicioBloc = ProviderLocal.ejerciciosBlog(context);
   final EjercicioModel prodData = ModalRoute.of(context).settings.arguments;
    if ( prodData != null ) {
      ejercicio = prodData;
    }


    return Scaffold(   
      body: Container(
                decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45.0),
                topRight: Radius.circular(45.0),
                        ),
                        color: Colors.white),
        height:double.infinity,
        child: SingleChildScrollView(
        child: SafeArea(
                  child: Column(
            children: <Widget>[
                        EjercicioSizePreview(
                          activarBotonVolver: true, 
                          fullScreen: true, 
                          imagenSeleccionada: 'https://i.pinimg.com/originals/dc/e3/bf/dce3bf93e7eec8a17ff8255c3ce1510f.png',
                          idUnico: ejercicio.id,
                          ),
                          ZapatoDescripcion(titulo: '${ejercicio.nombreEjercicio}', subtitulo: '${ejercicio.descripcion}',categoria: false,),
                    ],
                  ),
        ),
              ),
            ),
            floatingActionButton: Bounce(
                          delay: Duration( seconds: 1 ),
                          from: 14,
                          child: FloatingActionButton(
                          child: Icon(Icons.play_arrow),
                          onPressed: () {
                          _videoYoutube(context);
                          }),
            ),
          );
  }

    // ignore: missing_return
  Widget _videoYoutube(BuildContext contexto) {

  showDialog(context: contexto,
  barrierDismissible: true,
  builder: (contexto) {

      return AlertDialog(
               content: Container(
               height: 200,
               width: 600,
               child: ClipRRect(
               borderRadius: BorderRadius .circular(20),
               child: YoutubePlayer(
               controller:  youtubeControler,
               ),
                 ),
             ),
           );
  },);
  }
}
