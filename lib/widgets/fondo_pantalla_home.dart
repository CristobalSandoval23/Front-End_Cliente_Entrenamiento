import 'package:flutter/material.dart';

 class FondoDisenoHome extends StatelessWidget {

   final Color color1;
   final BuildContext contexto;
   final double altura; 

  FondoDisenoHome({
    this.color1 = Colors.white,
    @required this.contexto, this.altura,

    });
 
   @override
   Widget build( contexto) {
   
    final fondo = Column(
          children: <Widget>[  

       SizedBox(height: altura,),     
      Expanded(
        child: Container(
        padding: EdgeInsets.only(top: 30), 
          // height: MediaQuery.of(context).size.height-93,
      decoration: BoxDecoration(
        color: color1,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
      ),
       ),
      ),
          ],
        );

    return Stack(
      children: <Widget>[
          fondo,   
      ],
    );

   }
 
 }
 
