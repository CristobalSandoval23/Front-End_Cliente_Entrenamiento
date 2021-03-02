import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';

import 'package:entrenamiento_usuario/bloc/datos_corporales_bloc.dart';
import 'package:entrenamiento_usuario/models/datos_corporales.dart';
import 'package:entrenamiento_usuario/bloc/provider_local.dart';

 class DatosCorporalesPage
  extends StatefulWidget {
  @override
  _HomeRutinaDelUsuarioSeleccionadoPageState createState() => _HomeRutinaDelUsuarioSeleccionadoPageState();
}

class _HomeRutinaDelUsuarioSeleccionadoPageState extends State<DatosCorporalesPage> {
    
  List<BarChartGroupData> _items;
  List datosTitles;
  bool showAvg = false;
      
  @override
  Widget build(BuildContext context ) {
    final datosCorporalesBloc = ProviderLocal.datosCorporalesBlog(context);
    datosCorporalesBloc.cargarDatosCorporales();
    return Column(
      children: <Widget>[
        SizedBox( height: 200),
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
              width: 500,
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

  Widget _crearListado(DatosCorporalesBloc datosCorporalesBloc){

    return StreamBuilder (
                      stream: datosCorporalesBloc.datosCorporalesStream,
                      builder: (BuildContext context, AsyncSnapshot<List<DatosCorporalesModel>> snapshot) {
                        if ( snapshot.hasData ) {
                      final datoscorporales = snapshot.data;
                      Comparator<DatosCorporalesModel> diaComparator = (a, b) => a.dia.compareTo(b.dia);
                      datoscorporales.sort(diaComparator);
                          return BarChart(
                            mainData(datoscorporales),
                          );
                        } else {
                          return Center( child: CircularProgressIndicator());
                        }
                      },
                    );

  }   

 BarChartData mainData(datoscorporales) {

    _items =  datoscorporales.map<BarChartGroupData>((item) => BarChartGroupData(
                x: int.parse(item.dia.toString()),
                barRods: [
                  BarChartRodData(y: double.parse(item.datoAgregadoDeMedidasCorporales.toString()), 
                                  colors: [Colors.lightBlueAccent, Colors.greenAccent])
              ],)).toList();         
                
    datosTitles =  datoscorporales.map((item) => item.dia.toString()).toList(); 

     return BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: 50,
            barTouchData: BarTouchData(
              enabled: false,
              touchTooltipData: BarTouchTooltipData(
                tooltipBgColor: Colors.transparent,
                tooltipPadding: const EdgeInsets.all(0),
                tooltipBottomMargin: 8,
                getTooltipItem: (
                  BarChartGroupData group,
                  int groupIndex,
                  BarChartRodData rod,
                  int rodIndex,
                ) {
                  return BarTooltipItem(
                    rod.y.round().toString(),
                    TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: SideTitles(
                showTitles: true,
                getTextStyles: (value) => const TextStyle(
                    color: Color(0xff7589a2), fontWeight: FontWeight.bold, fontSize: 14),
                margin: 20,
                getTitles: (double value) {
                     return "${datosTitles[value.toInt()-1]}";
                },
              ),
              leftTitles: SideTitles(showTitles: false),
            ),
            borderData: FlBorderData(
              show: false,
            ),
            barGroups: _items,
     );   
  }

} 
  
  

