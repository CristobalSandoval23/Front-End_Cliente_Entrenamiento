import 'package:intl/intl.dart' as intl;
import 'package:flutter/material.dart';

import 'package:entrenamiento_usuario/bloc/datos_corporales_bloc.dart';
import 'package:entrenamiento_usuario/models/datos_corporales.dart';
import 'package:entrenamiento_usuario/bloc/provider_local.dart';
import 'package:entrenamiento_usuario/preferencias_usuario/preferencias_usuario.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:bezier_chart/bezier_chart.dart';

 class DatosCorporalesPage
  extends StatefulWidget {
  @override
  _HomeRutinaDelUsuarioSeleccionadoPageState createState() => _HomeRutinaDelUsuarioSeleccionadoPageState();
}

class _HomeRutinaDelUsuarioSeleccionadoPageState extends State<DatosCorporalesPage> {
      List<DataPoint> _items;
            final _prefs = new PreferenciasUsuario();
    List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

    DateTime fromDate;
  DateTime toDate;

  bool showAvg = false;
 List<double> datosIn = [1, 2, 3];
 List<double> datosDos = [100, 200, 300];
   @override
  void initState() {
    super.initState();
    fromDate = DateTime(2021, 02, 01);
    toDate = DateTime.now();
  }

  @override
  void dispose() {
    super.dispose();
  }
      
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


  Widget _crearListado(DatosCorporalesBloc datosCorporalesBloc) {

    return StreamBuilder(
                      stream: datosCorporalesBloc.datosCorporalesStream,
                      builder: (BuildContext context, AsyncSnapshot<List<DatosCorporalesModel>> snapshot) {
                        if ( snapshot.hasData ) {

                          final datoscorporales = snapshot.data;

                        
                          return 
                            mainData(datoscorporales);

                        } else {
                          return Center( child: CircularProgressIndicator());
                        }
                      },
                    );

  }   

 BezierChart mainData(datoscorporales) {

    _items =  datoscorporales.map<DataPoint<DateTime>>((item) => DataPoint<DateTime>(
                                         value: double.parse(item.datoAgregadoDeMedidasCorporales.toString()),
                                         xAxis: item.fechaDeAgregacionDeMedidasCorporales)).toList();         

                return BezierChart(
            fromDate: fromDate,
            bezierChartScale: BezierChartScale.WEEKLY,
            toDate: toDate,
            onIndicatorVisible: (val) {
              print("Indicator Visible :$val");
            },
            onDateTimeSelected: (datetime) {
              print("selected datetime: $datetime");
            },
            selectedDate: toDate,
            //this is optional
            footerDateTimeBuilder:
                (DateTime value, BezierChartScale scaleType) {
              final newFormat = intl.DateFormat('dd/MMM');
              return newFormat.format(value);
            },
            bubbleLabelDateTimeBuilder:
                (DateTime value, BezierChartScale scaleType) {
              final newFormat = intl.DateFormat('EEE d');
              return "${newFormat.format(value)}\n";
            },
            series: [
              BezierLine(
                label: "Peso corporal",
                onMissingValue: (dateTime) {
                  return 0;
                },
                data: _items,
              ),
            ],
            config: BezierChartConfig(
              updatePositionOnTap: true,
              bubbleIndicatorValueFormat: intl.NumberFormat("###,##0.00", "en_US"),
              verticalIndicatorStrokeWidth: 1.0,
              verticalIndicatorColor: Colors.white30,
              showVerticalIndicator: true,
              verticalIndicatorFixedPosition: false,
              backgroundColor: Colors.transparent,
              footerHeight: 40.0,
            ),
          );
  }


} 
  
  

