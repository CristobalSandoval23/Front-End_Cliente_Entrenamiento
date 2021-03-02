import 'package:flutter/material.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:entrenamiento_usuario/bloc/provider_local.dart';
import 'package:entrenamiento_usuario/bloc/rutina_bloc.dart';
import 'package:entrenamiento_usuario/models/rutina_semanal_model.dart';
import 'package:entrenamiento_usuario/preferencias_usuario/preferencias_usuario.dart';



class VideoPage extends StatefulWidget {
  VideoPage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<VideoPage> {

  var selectedCard = 'WEIGHT';
  RutinaBloc rutinaBloc;
  RutinaModel rutina = new RutinaModel();

  final estiloTitulo    = TextStyle( color:Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold );

  final _prefs = PreferenciasUsuario();
  
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
    rutinaBloc = ProviderLocal.rutinaBlog(context);
   final RutinaModel prodData = ModalRoute.of(context).settings.arguments;
    if ( prodData != null ) {
      rutina = prodData;
    }


    return SafeArea(
          child: Scaffold(
        backgroundColor: Color(0xFF7A9BEE),
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.white,
            ),
            backgroundColor: Color(0xFF7A9BEE),
            elevation: 0.0,
            title: Text('${rutina.ejercicio}',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 18.0,
                    color: Colors.white)),
            centerTitle: true,
          ),
        body: Container(
                              decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(45.0),
                            topRight: Radius.circular(45.0),
                          ),
                          color: Colors.white),
          height:double.infinity,
          // color: Color(0xFF7A9BEE),
          child: SingleChildScrollView(

          child: Column(
            children: <Widget>[
                _mostrarImagen(),
                _crearTitulo(),     
                // _crearTexto(),
                // _crearTexto2(),
                     SizedBox(width: 10.0),
                Container(
                  
                        height: 150.0,
                        
                        child: ListView(
                          
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            SizedBox(width: 34.0),
                            _buildInfoCard('Series', '3', '-----------------------'),
                            SizedBox(width: 10.0),
                              _buildInfoCard('Repeticiones', '10', '-----------------------'),
                          ],
                        ),
                      ),
                         SizedBox( height: 10, ),
                Column(
                  children: <Widget>[
                _descanso(),   
                  ],
                ),
                    ],
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.play_arrow),
                onPressed: () {
                  _mostrarEjercicio(context);
                }),
            ),
    );
  }

  Widget _descanso() {
   return  Container(
     padding: EdgeInsets.symmetric( horizontal: 100.0, vertical: 15.0),
     child: RaisedButton(
       child: Text('Descansar'),
       color: Colors.red,
       textColor: Colors.white,
       shape: StadiumBorder(),
       onPressed: () {
         _prefs.temporizador = rutina.descanso;
        //  Navigator.popAndPushNamed(context, 'temporizador');
        //  Navigator.of(context).pop('temporizador');
        //  Navigator.pushNamed(context, );
        Navigator.pushNamed(context, 'temporizador');
         },
     ),
   );
  }

Widget _crearNotas() {
           return  TextField(
             
             keyboardType: TextInputType.multiline,
              maxLines: 4,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Observaciones del ejercicio',
                  hintText: 'Agregar'),
           );
}
  
// ignore: missing_return
Widget _mostrarEjercicio(BuildContext context) {

  showDialog(context: context,
  barrierDismissible: true,
  builder: (context) {

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
  
  Widget _crearTitulo() {

    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Prescripción del ejercicio', style: estiloTitulo ),
                  SizedBox( height: 7.0 ),
                ],
              ),
            ),

            Icon( Icons.fitness_center, color: Colors.red, size: 30.0 ),

          ],
        ),
      ),
    );
  }

    Widget _mostrarImagen() {


      return Container(
        width: 390,
        child: Hero(
          tag: 'logo',
                child: ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40),),
            child: Image(image: NetworkImage('https://es.theepochtimes.com/assets/uploads/2019/12/Chevrolet-Corvette_C8_Stingray-2020.jpg'),
            )
            ),
        ),
      );
    

  }
  
   Widget _crearTexto2() {

    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric( horizontal: 40.0 ),
        child: Text(
          'Intensidad del ejercicio: ${rutina.intensidad} ',
          textAlign: TextAlign.start,
        ),
      ),
    );
  }

 Widget _buildInfoCard(String cardTitle, String info, String unit) {
    return InkWell(
      onTap: () {
        selectCard(cardTitle);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: cardTitle == selectedCard ? Color(0xFF7A9BEE) : Colors.white,
          border: Border.all(
            color: cardTitle == selectedCard ? 
            Colors.transparent :
            Colors.grey.withOpacity(0.3),
            style: BorderStyle.solid,
          width: 0.75
          ),
        ),
        height: 100.0,
        width: 140.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 15.0),
              child: Center(
                child: Text(cardTitle,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 12.0,
                      color:
                          cardTitle == selectedCard ? Colors.white : Colors.grey.withOpacity(0.7),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, bottom: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(info,
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 14.0,
                            color: cardTitle == selectedCard
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold)),
                  ),
                  Center(
                    child: Text(unit,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 12.0,
                          color: cardTitle == selectedCard
                              ? Colors.white
                              : Colors.black,
                        )),
                  )
                ],
              ),
            )
          ]
        )
      )
    );
  }

  selectCard(cardTitle) {
    setState(() {
      selectedCard = cardTitle;
    });
  }

}
