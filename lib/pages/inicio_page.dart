import 'package:entrenamiento_usuario/preferencias_usuario/preferencias_usuario.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
  
import 'package:entrenamiento_usuario/bloc/provider_local.dart';
import 'package:entrenamiento_usuario/bloc/usuarios_bloc.dart';
import 'package:entrenamiento_usuario/models/crear_usuarios_model.dart';
import 'package:entrenamiento_usuario/providers/datos_de_sus_usuarios_provider.dart';
import 'package:entrenamiento_usuario/widgets/custom_widgets.dart';

class ItemBoton {

  final IconData icon;
  final String texto;
  final Color color1;
  final Color color2;
  final String onPress;

  ItemBoton( this.icon, this.texto, this.color1, this.color2, this.onPress);
}

class EmergencyPage extends StatefulWidget {
  @override
  _EmergencyPageState createState() => _EmergencyPageState();
}

class _EmergencyPageState extends State<EmergencyPage> {

    final usuarioProvider= new DatosUsuariosProviders();

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();


  @override
  void initState() { 
    super.initState();
    
    // initializing();
     const AndroidInitializationSettings  initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');
  const IOSInitializationSettings initializationSettingsIOs = IOSInitializationSettings();
  const InitializationSettings initSetttings = InitializationSettings(
           android: initializationSettingsAndroid,
           iOS: initializationSettingsIOs);

  flutterLocalNotificationsPlugin.initialize(initSetttings,
      onSelectNotification: onSelectNotification);
  }


showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'your channel id', 'your channel name', 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'plain title', 'plain body', platformChannelSpecifics,
        payload: 'item x'); 
  }


  // ignore: missing_return
  Future onSelectNotification(String payLoad) {
    if (payLoad != null) {
      print(payLoad);
    }

  //   // we can set navigator to navigate another screen
  }


  Widget build(BuildContext context) {

    final items = <ItemBoton>[
      new ItemBoton( FontAwesomeIcons.calendar, 'Su plan de entrenamiento', Color(0xff6989F5), Color(0xff906EF5), 'HomeRutinaUsuario', ),
      new ItemBoton( FontAwesomeIcons.list, 'Lista de ejercicios', Color(0xff66A9F2), Color(0xff536CF6), 'listaDeEjercicios',  ),
      new ItemBoton( FontAwesomeIcons.edit, 'Perfil', Color(0xff317183), Color(0xff46997D), 'AutoEditarInfoUsuario',  ),
      new ItemBoton( FontAwesomeIcons.memory, 'Ayudanos a mejorar', Color(0xffF2D572), Color(0xffE06AA3), 'grafico2',  ),

    ];

    List<Widget> itemMap = items.map(
      (item) => FadeInLeft(
        duration: Duration( milliseconds: 250 ),
        child: BotonGordo(
          icon: item.icon,
          texto: item.texto,
          color1: item.color1,
          color2: item.color2,
          onPress: () { 


            Navigator.pushNamed(context, '${item.onPress}');},
        ),
      )
    ).toList();

    final usuarioBloc = ProviderLocal.usuariosBlog(context);
    usuarioBloc.cargarUsuarios();
    return SafeArea(
          child: Scaffold(
        body: Container(
          child: Stack(
            children: <Widget>[        
              Container(
                margin: EdgeInsets.only( top: 200 ),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: <Widget>[

                    ...itemMap,

                  ],
                ),
              ),
              // _Encabezado(),

               Container(
                 height: 235,
                 child: Column(
                   children: <Widget>[
                     _crearListado(usuarioBloc),
                   ],
                 )),
            ],
          ),
        ),
   ),
    );
  }

    Widget _crearListado(UsuariosBloc usuarioBloc) {

    return FutureBuilder(
      future: usuarioProvider.cargarUsuario(),
      builder: (BuildContext context, AsyncSnapshot<List<UsuariosModel>> snapshot) {
        if ( snapshot.hasData ) {

          final productos = snapshot.data;

              return 
              Expanded(
                child: ListView.builder(
              
                itemCount: productos.length,
                
                itemBuilder: (context, i) => _crearItem(context, usuarioBloc, productos[i] ),
            ),
              );



        
        } else {
          return Center( child: CircularProgressIndicator());
        }
      },
    );

  }

  Widget _crearItem(BuildContext context, UsuariosBloc usuarioBloc, UsuariosModel usuario) {

        final _prefs = PreferenciasUsuario();

    _prefs.correoUsuario = usuario.email;

    return Stack(
      children: <Widget>[
        IconHeader(
          icon: FontAwesomeIcons.user, 
          titulo: '', 
          subtitulo: '${usuario.nombreUsuario}',
          color1: Color(0xff536CF6),
          color2: Color(0xff66A9F2),
        ),
      ],
    );


  }

}
