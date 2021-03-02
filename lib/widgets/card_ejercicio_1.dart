import 'package:flutter/material.dart';

import 'package:entrenamiento_usuario/preferencias_usuario/preferencias_usuario.dart';

class CardEjercicio extends StatelessWidget {

    final String intensidad;
    final String series;
    final String repeticiones;
    final int descanso;
    final String nombreEjercicio;
    final String videoUrl;
    final String routerPagina;
    final String imagen;
    final String tituloCard;
    final Color colorCardVideoGuiado;
    final bool videoGuiado;
    final rutina;

    CardEjercicio({
     this.intensidad, 
     this.series, 
     this.repeticiones, 
     this.descanso, 
     this.nombreEjercicio, 
     this.videoUrl, 
     @required this.rutina, this.routerPagina, this.imagen, this.videoGuiado = false, 
     this.colorCardVideoGuiado = Colors.lime, this.tituloCard
     });
     
  final estiloTitulo2    = TextStyle( color:Colors.white, fontSize: 13.0, fontWeight: FontWeight.bold );
  final estiloTitulo3    = TextStyle( color:Colors.black, fontSize: 10.0, fontWeight: FontWeight.bold );

  final _prefs = new PreferenciasUsuario();
  
  @override
  // ignore: missing_return
  Widget build(BuildContext context) {


     return GestureDetector(
      onTap: () {
            _prefs.urlVideoYoutube = videoUrl;
           Navigator.pushNamed(context, routerPagina, arguments: rutina);
      },
      child:  Stack(
              children:<Widget>[
                Card( 
                  elevation: 20,   
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  ),            
                  color: (this.videoGuiado) ?  colorCardVideoGuiado : Colors.white,
                  child:
                    Column(
                      children: <Widget>[     
                                      SizedBox(height: 50),            
                                      ListTile(
                                              title: Column(
                                                children: <Widget>[
                                                  Align(
                                                    alignment: (this.videoGuiado) ?  Alignment.centerLeft : Alignment.centerRight,
                                                    child: Text( (this.videoGuiado) ?  'Activación' : '$nombreEjercicio',
                                                    style: TextStyle( 
                                                      color:(this.videoGuiado) ?  Colors.white : Colors.black, 
                                                      fontSize: 13.0, 
                                                      fontWeight: FontWeight.bold )
                                                      ),
                                                    ),
                                                   SizedBox(height: 40),
                                                ],
                                               
                                              ),
                                               subtitle: Text(' $series series x $repeticiones repeticiones con un descanso de ${(descanso /60).toString().replaceAll('.0', '')} minutos.', 
                                                    style: TextStyle( 
                                                      color:(this.videoGuiado) ?  Colors.white : Colors.black, 
                                                      fontSize: 13.0, 
                                                      fontWeight: FontWeight.bold )
                                                      ),                                  
                                                    ),
                                         SizedBox(height: 10), 
                                        ],
                            ),
                      ),
                Padding(
                 padding: EdgeInsets.symmetric(
                   horizontal: 9,
                   vertical: 9,),
                  child: Align(
                    alignment: (this.videoGuiado) ? Alignment.topRight: Alignment.topLeft,
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                          child: Hero(
                          tag: 'logo',
                          child: Container(
                            height: 100.0,
                            width: 100.0,
                            decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover, image: NetworkImage(imagen),
                                                          )
                                                      ),
                                            )
                                ),
                    ),
                  ),
                ),
              ] 
          ),
    );
    
  }


}
