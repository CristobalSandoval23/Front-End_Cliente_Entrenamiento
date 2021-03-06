import 'package:flutter/material.dart';

import 'package:entrenamiento_usuario/bloc/provider_local.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:entrenamiento_usuario/bloc/datos_corporales_bloc.dart';
import 'package:entrenamiento_usuario/models/datos_corporales.dart';

 class DatosCorporalesPage
  extends StatefulWidget {
  @override
  _HomeRutinaDelUsuarioSeleccionadoPageState createState() => _HomeRutinaDelUsuarioSeleccionadoPageState();
}

class _HomeRutinaDelUsuarioSeleccionadoPageState extends State<DatosCorporalesPage> {
      List<FlSpot> _items;
      List _datosTitles;
      List _datos;

    List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context ) {
    final datosCorporalesBloc = ProviderLocal.datosCorporalesBlog(context);
    datosCorporalesBloc.cargarDatosCorporales();
    return Column(
      children: <Widget>[
        SizedBox( height: 200, ),
        Stack(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.70,
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(25), // bordes del chart 
                    ),
                    color: Color(0xff232d37)
                    ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 18.0, left: 12.0, top: 24, bottom: 12),
                  child: _crearListado(datosCorporalesBloc),
                ),
              ),
            ),
            SizedBox(
              width: 400,
              height: 18,
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    showAvg = !showAvg;
                  });
                },
                child: Text(
                  'Evolución ',
                  style: TextStyle(
                      fontSize: 16, color: showAvg ? Colors.white.withOpacity(0.5) : Colors.white),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }


  Widget _crearListado(DatosCorporalesBloc datosCorporalesBloc) {

    return StreamBuilder(
                      stream: datosCorporalesBloc.datosCorporalesStream,
                      builder: (BuildContext context, AsyncSnapshot<List<DatosCorporalesModel>> snapshot) {
                        if ( snapshot.hasData ) {

                          final datosCorporales = snapshot.data;
                          Comparator<DatosCorporalesModel> diaComparator = (a, b) => a.dia.compareTo(b.dia);
                          datosCorporales.sort(diaComparator);
                        
                          return LineChart(
                            mainData(datosCorporales),
                          );

                        } else {
                          return Center( child: CircularProgressIndicator());
                        }
                      },
                    );

  }   

  LineChartData mainData(datosCorporales) {

               _items =  datosCorporales.map<FlSpot>((item) => FlSpot(
              double.parse(item.dia.toString()),
              double.parse(item.datoAgregadoDeMedidasCorporales.toString()))).toList();
               _datosTitles =  datosCorporales.map((item) => item.dia.toString()).toList();         
              Comparator<DatosCorporalesModel> datoComparator = (a, b) => b.datoAgregadoDeMedidasCorporales.compareTo(a.datoAgregadoDeMedidasCorporales);
                          datosCorporales.sort(datoComparator);
               _datos =  datosCorporales.map((item) => item.datoAgregadoDeMedidasCorporales).toList();         
                return LineChartData(
                  gridData: FlGridData(
                    show: true, // elimina las rayas que estan detras del grafico 
                    drawVerticalLine: true, // si esta en false elimina las lineas verticales
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: const Color(0xff37434d),
                        strokeWidth: 1, // amplia el tamaño de las lineas  horizontales del fondo del grafico
                      );
                    },
                    getDrawingVerticalLine: (value) {
                      return FlLine(
                        color: const Color(0xff37434d),
                        strokeWidth: 1, // amplia el tamaño de las lineas  verticales del fondo del grafico
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true, // si este esta en false elimina los datos tanto de la left como de down del grafico
                    bottomTitles: SideTitles(
                      showTitles: true, // si esta en false elimina los datos del lado down del grafico
                      reservedSize: 22, // le da el alto al grafico si se reduce y al contrario si se aumenta se achica el chart
                      getTextStyles: (value) => 
                          const TextStyle(color: Color(0xff68737d), fontWeight: FontWeight.bold, fontSize: 16),
                      getTitles: (value) {
                        return "${_datosTitles[value.toInt()-1]}";
                      },
                      margin: 8,
                    ),
                    leftTitles: SideTitles(
                      showTitles: true, // si esta en false elimina los datos del lado left del grafico
                      getTextStyles: (value) =>
                      const TextStyle(
                        color: Color(0xff67727d), // cambia el color de los datos de la left
                        fontWeight: FontWeight.bold, // el ancho de las letras
                        fontSize: 15, // tamaño de las letras del lado left
                      ),
                      getTitles: (value) {
                        // aqui se carga los datos automaticamente
                        if(value == double.parse(_datos[0].toString())){
                            return '${_datos[0]}.0';
                        }else if(value == double.parse(_datos[0].toString())/2){
                        return '${_datos[0]/2}';
                        // return '${_datos[0]/2}';
                        } else{
                        return '';

                        }                    
                      },
                      reservedSize: 28,
                      margin: 12,
                    ),
                  ),
                  borderData:
                      FlBorderData(
                        // le da el color al fondo del grafico
                        show: true, border: Border.all(color: const Color(0xff37434d), width: 1) 
                      ),
                      // los datos de abajo permiten alterar el grafico 
                  minX: 1,
                  maxX: _datosTitles.length.toDouble(), // aqui puedo colocar length para designar la máxima cantidad de datos
                  minY: 0,
                  maxY: double.parse(_datos[0].toString())+20, // aqui puedo colocar length para designar la máxima cantidad de datos
                  lineBarsData: [
                    LineChartBarData(
                      spots: _items,
          isCurved: false, // le da la curva a la linea del grafico
          colors: gradientColors, // color de la linea del grafico 
          barWidth: 5, // grosor de la linea del grafico
          isStrokeCapRound: true, // si es falso indica que no se debe sobresalir del la ubicación del dato
          dotData: FlDotData(
            show: true, // si se coloca en true es para colocar los puntos de los datos
          ),
          belowBarData: BarAreaData(
            show: true, // este al estar en true da la sombra del grafico hacia abajo
            colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(), // le asigna un color a la sombra del grafico
          ),
        ),
      ],
    );
  }


} 
  
  

