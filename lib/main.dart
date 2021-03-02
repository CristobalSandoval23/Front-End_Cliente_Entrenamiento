import 'package:entrenamiento_usuario/pages/grafico_page_dos.dart';
import 'package:flutter/material.dart';

import 'package:entrenamiento_usuario/pages/home_lista_ejercicios_page.dart';
import 'package:entrenamiento_usuario/pages/sugerencia_de_los_clientes_page.dart';
import 'package:entrenamiento_usuario/pages/crear_datos_usuario_page.dart';
import 'package:entrenamiento_usuario/pages/seleccionar_rutina_asignada_page.dart';
import 'package:entrenamiento_usuario/pages/temporizador_page.dart';
import 'package:entrenamiento_usuario/pages/inicio_page.dart';
import 'package:entrenamiento_usuario/pages/grafico_page.dart';
import 'package:entrenamiento_usuario/pages/home_rutina_de_usuario_page.dart';
import 'package:entrenamiento_usuario/pages/presentacion_ejercicio_page.dart';
import 'package:entrenamiento_usuario/pages/mostrar_ejercicio_page.dart';
import 'package:entrenamiento_usuario/bloc/provider_local.dart';
import 'package:entrenamiento_usuario/pages/login_page.dart';
import 'package:entrenamiento_usuario/pages/registro_page.dart';
import 'package:entrenamiento_usuario/preferencias_usuario/preferencias_usuario.dart';
 
void main() async {
    WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();

  runApp(MyApp());

}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final prefs = new PreferenciasUsuario();

    print( prefs.token );
    
    return ProviderLocal(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'login',
        routes: {
          'login'                        : ( BuildContext context ) => LoginPage(),
          'registro'                     : ( BuildContext context ) => RegistroPage(),
          'inicio'                       : ( BuildContext context ) => EmergencyPage(),              
          'AutoEditarInfoUsuario'        : ( BuildContext context ) => PerfilPage(),
          'presentaciónEjercicio'        : ( BuildContext context ) => VideoPage(),
          'temporizador'                 : ( BuildContext context ) => Temporizador(),
          'HomeRutinaUsuario'            : ( BuildContext context ) => HomeRutinaDelUsuarioSeleccionadoPage(),
          'EjerciciosDelDiaSeleccionado' : ( BuildContext context ) => SegundaParteTresDeCreacionSesionPage(),
          'recomendaciones'              : ( BuildContext context ) => NotasPage(),
          'grafico'                      : ( BuildContext context ) => LineChartSample2(),
          'grafico2'                      : ( BuildContext context ) => DatosCorporalesPage(),
          'listaDeEjercicios'            : ( BuildContext context ) => HomeListaEjercicio(),
          'MostrarEJercicioSeleccionado' : ( BuildContext context ) => MostrarEjercicioPage(),

        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
        ),
      ),
    );
      
  }
}