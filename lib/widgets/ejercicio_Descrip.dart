import 'package:flutter/material.dart';

class ZapatoDescripcion extends StatelessWidget {
  
  final String titulo;
  final String subtitulo;
  final bool categoria;

  const ZapatoDescripcion({
    @required this.titulo,
    @required this.subtitulo, this.categoria
  });

  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric( horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox( height: 20 ),
          Text( this.titulo, style: TextStyle( fontSize: 30, fontWeight: FontWeight.w700 ), ),
          SizedBox( height: 20 ),
          (!this.categoria)
          ? Text( '${this.subtitulo}', style: TextStyle( color: Colors.black54, height: 1.6 ) )
          : Text( 'Categoria: ${this.subtitulo}', style: TextStyle( color: Colors.black54, height: 1.6 ) ),

        ],
      ),
    );
  }
}