import 'dart:convert';

DiaModel diaModelFromJson(String str) => DiaModel.fromJson(json.decode(str));

String diaModelToJson(DiaModel data) => json.encode(data.toJson());

class DiaModel {

    String id;
    String nombreDia;
    String idAdministrador;
    String idCliente;
    // String descanso;
    // String ejercicio;
    // String from;
    // String to;

    DiaModel({
        this.id,
        this.nombreDia        = '',
        this.idAdministrador = '',
        this.idCliente = '',
        // this.descanso   = '',
        // this.ejercicio  = '',
        // this.from       = '',
        // this.to         = '',
    });

    factory DiaModel.fromJson(Map<String, dynamic> json) => new DiaModel(
        id            : json["id"],
        nombreDia           : json["nombreDia"],
        idAdministrador    : json["idAdministrador"],
        idCliente    : json["idCliente"],
        // descanso      : json["descanso"],
        // ejercicio     : json["ejercicio"],
        // from          : json["from"],    
        // to            : json["to"],    
    );

    Map<String, dynamic> toJson() => {
        //  "id"         : id,
        "nombreDia"         : nombreDia,
        "idAdministrador"  : idAdministrador,
        "idCliente"  : idCliente,
        // "descanso"    : descanso,
        // "ejercicio"   : ejercicio,
        // "from"        : from,
        // "to"          : to,
    };
}
