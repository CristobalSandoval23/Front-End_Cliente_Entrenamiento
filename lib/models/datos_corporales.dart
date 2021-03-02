import 'dart:convert';

DatosCorporalesModel datosCorporalesFromJson(String str) => DatosCorporalesModel.fromJson(json.decode(str));

String datosCorporalesToJson(DatosCorporalesModel data) => json.encode(data.toJson());

class DatosCorporalesModel {
    DatosCorporalesModel({
        this.datoAgregadoDeMedidasCorporales,
        this.dia,
        this.fechaDeAgregacionDeMedidasCorporales,
        this.idAdministrador,
        this.idCliente,
        this.nombreDatosMedidasCorporales,
    });

    int datoAgregadoDeMedidasCorporales;
    int dia;
    DateTime fechaDeAgregacionDeMedidasCorporales;
    String idAdministrador;
    String idCliente;
    String nombreDatosMedidasCorporales;

    factory DatosCorporalesModel.fromJson(Map<String, dynamic> json) => DatosCorporalesModel(
        datoAgregadoDeMedidasCorporales: json["datoAgregadoDeMedidasCorporales"],
        dia: json["dia"],
        fechaDeAgregacionDeMedidasCorporales: DateTime.parse(json["fechaDeAgregacionDeMedidasCorporales"]),
        idAdministrador: json["idAdministrador"],
        idCliente: json["idCliente"],
        nombreDatosMedidasCorporales: json["nombreDatosMedidasCorporales"],
    );

    Map<String, dynamic> toJson() => {
        "datoAgregadoDeMedidasCorporales": datoAgregadoDeMedidasCorporales,
        "dia": dia,
        "fechaDeAgregacionDeMedidasCorporales": "${fechaDeAgregacionDeMedidasCorporales.year.toString().padLeft(4, '0')}-${fechaDeAgregacionDeMedidasCorporales.month.toString().padLeft(2, '0')}-${fechaDeAgregacionDeMedidasCorporales.day.toString().padLeft(2, '0')}",
        "idAdministrador": idAdministrador,
        "idCliente": idCliente,
        "nombreDatosMedidasCorporales": nombreDatosMedidasCorporales,
    };
}