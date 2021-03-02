// To parse this JSON data, do
//
//     final productoModel = productoModelFromJson(jsonString);

import 'dart:convert';

EjercicioModel ejercicioModelFromJson(String str) => EjercicioModel.fromJson(json.decode(str));

String ejercicioModelToJson(EjercicioModel data) => json.encode(data.toJson());

class EjercicioModel {

    String id;
    String nombreEjercicio;
    String descripcion;
    String videoUrlYoutube;
    String email;    
    String creador;
    String clasificacion;
    String fotoUrl;

    EjercicioModel({
        this.id,
        this.nombreEjercicio = '',
        this.descripcion  = '',
        this.videoUrlYoutube  = '',
        this.creador = '',    
        this.email  = '',        
        this.clasificacion = '',
        this.fotoUrl,
    });

    factory EjercicioModel.fromJson(Map<String, dynamic> json) => new EjercicioModel(
        id         : json["id"],
        nombreEjercicio     : json["nombreEjercicio"],
        descripcion: json["descripcion"],
        videoUrlYoutube: json["videoUrlYoutube"],
        clasificacion : json["clasificacion"],
        creador    : json["creador"],
        email : json["email"],        
        fotoUrl    : json["fotoUrl"],
    );

    Map<String, dynamic> toJson() => {
        //  "id"         : id,
        "nombreEjercicio"     : nombreEjercicio,
        "descripcion": descripcion,
        "videoUrlYoutube": videoUrlYoutube,
        "email": email,        
        "creador"    : creador,  
        "clasificacion" : clasificacion,
        "fotoUrl"    : fotoUrl,
    };
}
