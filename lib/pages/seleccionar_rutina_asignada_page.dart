
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:entrenamiento_usuario/widgets/custom_widgets.dart';
import 'package:entrenamiento_usuario/models/menu_model.dart';
import 'package:entrenamiento_usuario/bloc/provider_local.dart';
import 'package:entrenamiento_usuario/bloc/rutina_bloc.dart';
import 'package:entrenamiento_usuario/models/rutina_semanal_model.dart';
import 'package:entrenamiento_usuario/preferencias_usuario/preferencias_usuario.dart';


class SegundaParteTresDeCreacionSesionPage extends StatefulWidget {

  @override
  _SegundaParteTresDeCreacionSesionPageState createState() => _SegundaParteTresDeCreacionSesionPageState();
}

class _SegundaParteTresDeCreacionSesionPageState extends State<SegundaParteTresDeCreacionSesionPage> {
  
  final formKey     = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final estiloTitulo    = TextStyle( color:Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold );

  RutinaBloc rutinasBloc;
  RutinaModel rutina = new RutinaModel();

      final _prefs = new PreferenciasUsuario();
      String dia = '';
      List<String> dias = ['Lunes','Martes','Miércoles','Jueves','Viernes','Sábado','Domingo',];
  @override
  Widget build(BuildContext context) {

    rutinasBloc = ProviderLocal.rutinaBlog(context);
   final RutinaModel prodData = ModalRoute.of(context).settings.arguments;
    if ( prodData != null ) {
      rutina = prodData;
    }
        String dia = 'Lunes';
        final referencia = _prefs.idCliente;
        _prefs.idCliente = referencia;
        rutinasBloc.cargarRutina(dia);
    return ChangeNotifierProvider(
         create: (_) => new MenuModel(),
          child: SafeArea(
                      child: Scaffold(
              key: scaffoldKey,
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
            title: Text('Programación',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 18.0,
                    color: Colors.white)),
            centerTitle: true,
        ),
        body: 
        Column(
        children: <Widget>[
                              _SemanaDeEntrenamiento( dia, dias, rutinasBloc),
                              SizedBox(height:10,),
                              _crearListado(rutinasBloc),
                            ],
                          ),
      ),
          ),
    );
  }

  Widget _crearListado(RutinaBloc rutinasBloc) {

    return StreamBuilder(
      stream: rutinasBloc.rutinaStream,
      builder: (BuildContext context, AsyncSnapshot<List<RutinaModel>> snapshot) {
        if ( snapshot.hasData ) {

          final rutina = snapshot.data;
          if (rutina.length == 0) {
             return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Su rutina del día: ${_prefs.diaSesion} ', style: estiloTitulo ),
                    SizedBox( height: 7.0 ),
                  ],
                ),
              ),

              Icon( Icons.fitness_center, color: Colors.red, size: 30.0, ),

            ],
          ),
        ),
       Center( 
            child: Column(
              children: <Widget>[
                SizedBox( height: 150 ),
                Center(child: Text('Hoy ${_prefs.diaSesion} descansa estimado...')),
              ],
            )),
      ],
    );        
          } else {
          return 
             Expanded(
                  child: ListView.builder(           
                  itemCount: rutina.length,   
                  itemBuilder: (context, i) => _crearItem(context, rutinasBloc, rutina[i] ),
            ),
          );
          
          }

        } else {
                
            return Center( child: CircularProgressIndicator());
        }
      },
    );

  }

  Widget _crearItem(BuildContext context, RutinaBloc rutinasBloc, RutinaModel rutina ) {

    return CardEjercicio(
      rutina: rutina, 
      intensidad: rutina.intensidad, 
      series: '3', 
      repeticiones: '10', 
      descanso: rutina.descanso, 
      nombreEjercicio: rutina.ejercicio, 
      videoUrl: rutina.urlVideoYoutube,
      imagen: 'https://es.theepochtimes.com/assets/uploads/2019/12/Chevrolet-Corvette_C8_Stingray-2020.jpg',
      videoGuiado: true,
      routerPagina: 'presentaciónEjercicio',
      tituloCard: 'Activación general',
      );
  }

}


// ignore: must_be_immutable
class _SemanaDeEntrenamiento extends StatelessWidget {
  
  //  final int index;
   String diaSelecionado;
   List<String> diasDeLaSemana;
   RutinaBloc rutinasBloc;

  _SemanaDeEntrenamiento( this.diaSelecionado, this.diasDeLaSemana, this.rutinasBloc );

  final _prefs = new PreferenciasUsuario();
    @override


  Widget build(BuildContext context) {
    

  final itemSeleccionado = Provider.of<MenuModel>(context).itemSeleccionado;

   return   Container(
              color: Color(0xFF7A9BEE),
                       height: 70,
                       child: Column(
                         children: <Widget>[
                           SizedBox( height: 2, ),
                           Expanded(
                               child: ListView.builder(

                               scrollDirection: Axis.horizontal,
                               itemCount: diasDeLaSemana.length,                      
                               itemBuilder: (BuildContext context, int index){
                     
                                 return Container(
                                   width: 130,
                                   child: Card(
                                     shadowColor: Colors.black,
                                    color:  ( itemSeleccionado == index ) ? Colors.white : Colors.blueGrey,
                                       child: ListTile(
                                         title: Text('${diasDeLaSemana[index]}', style: TextStyle(fontSize:15, fontStyle: FontStyle.italic,color: ( itemSeleccionado == index ) ? Colors.blueGrey : Colors.white,), textAlign: TextAlign.center),
                                         onTap: () {
                                              diaSelecionado = diasDeLaSemana[index];
                                               _prefs.diaSesion = diaSelecionado;
                                               diaSelecionado = diaSelecionado;
                                               rutinasBloc.cargarRutina(diaSelecionado);
                                              Provider.of<MenuModel>(context, listen: false ).itemSeleccionado = index;
                                         },
                                       ),
                                   ),
                                 );
                               },
                             
                             ),
                           ),
                           SizedBox( height: 2, ),
                         ],
                       ),
                     );

  }

}

