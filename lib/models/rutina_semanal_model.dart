import 'dart:convert';

RutinaModel rutinaModelFromJson(String str) => RutinaModel.fromJson(json.decode(str));

String rutinaModelToJson(RutinaModel data) => json.encode(data.toJson());

class RutinaModel {

    String id;
    String dia;
    String microciclo;
    String intensidad;
    int descanso;
    String ejercicio;
    String urlVideoYoutube;
    String idAdministrador;
    String to;

    RutinaModel({
        this.id,
        this.dia        = '',
        this.microciclo = '',
        this.intensidad = '',
        this.descanso ,
        this.ejercicio  = '',
        this.urlVideoYoutube  = '',
        this.idAdministrador       = '',
        this.to         = '',
    });

    factory RutinaModel.fromJson(Map<String, dynamic> json) => new RutinaModel(
        id            : json["id"],
        dia           : json["dia"],
        microciclo    : json["microciclo"],
        intensidad    : json["intensidad"],
        descanso      : json["descanso"],
        ejercicio     : json["ejercicio"],
        urlVideoYoutube     : json["urlVideoYoutube"],
        idAdministrador          : json["idAdministrador"],    
        to            : json["to"],    
    );

    Map<String, dynamic> toJson() => {
        //  "id"         : id,
        "dia"         : dia,
        "microciclo"  : microciclo,
        "intensidad"  : intensidad,
        "descanso"    : descanso,
        "ejercicio"   : ejercicio,
        "urlVideoYoutube"   : urlVideoYoutube,
        "idAdministrador"        : idAdministrador,
        "to"          : to,
    };
}
