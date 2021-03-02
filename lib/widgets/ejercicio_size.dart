import 'package:animate_do/animate_do.dart';
import 'package:entrenamiento_usuario/preferencias_usuario/preferencias_usuario.dart';
import 'package:flutter/material.dart';

class EjercicioSizePreview extends StatelessWidget {

   final bool fullScreen;
   final bool activarBotonVolver;
   final String imagenSeleccionada;
   final String urlYoutube;
   final String idUnico;
   final Object argumentos;


  EjercicioSizePreview({
    this.fullScreen = false,
    this.activarBotonVolver = false,
   @required this.imagenSeleccionada,
    this.argumentos, this.urlYoutube, this.idUnico

    });

  final _prefs = PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTap: (){
            if ( !this.fullScreen ) {
               _prefs.urlVideoYoutube = urlYoutube;
              Navigator.pushNamed(context, 'MostrarEJercicioSeleccionado', arguments: argumentos );
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric( 
              horizontal: (this.fullScreen) ? 5: 30,
              vertical: (this.fullScreen) ? 5: 0,
            ),
            child: Container(
              width: double.infinity,
              height: (this.fullScreen) ? 410 : 270,
              decoration: BoxDecoration(
                color: Color(0xffFFCF53),
                borderRadius: 
                    (!this.fullScreen) 
                      ? BorderRadius.circular(50)
                      : BorderRadius.only( bottomLeft: Radius.circular(50),
                                          bottomRight: Radius.circular(50),
                                          topLeft: Radius.circular(40),
                                          topRight: Radius.circular(40))
              ),
              child: Column(
                children: <Widget>[
                      (!this.activarBotonVolver)
                      ? Container()
                      : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        child: Row( children: <Widget>[
                            Bounce(
                                   delay: Duration( seconds: 2 ),
                                   from: 14,
                                   child: IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: Icon(Icons.arrow_back_ios, size: 35,),
                                    color: Colors.white,
                                  ),
                            ),                          
                          ]),
                      ),
                  // Zapato con su sombra
                  Expanded(child: _ZapatoConSombra(imagen: imagenSeleccionada, identificador: idUnico,)),
                  
                  // if (!this.fullScreen)
                    // _ZapatoTallas() 
                ],
              ),
            ),
          ),
        );
  }
}
class _ZapatoConSombra extends StatelessWidget {

  final String imagen;
  final String identificador;

  const _ZapatoConSombra({
    this.imagen, this.identificador
     });


  @override
  Widget build(BuildContext context) {

    // final zapatoModel = Provider.of<ZapatoModel>(context);

    return Padding(
      padding: EdgeInsets.all(40),
      child: Stack(
        children: <Widget>[


          Hero(
            tag: identificador,
            child: Image( image: NetworkImage(imagen), ))

        ],
      ),
    );
  }
}