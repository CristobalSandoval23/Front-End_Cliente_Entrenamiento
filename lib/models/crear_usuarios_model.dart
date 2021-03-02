// To parse this JSON data, do
//
//     final productoModel = productoModelFromJson(jsonString);

import 'dart:convert';

UsuariosModel usuariosModelFromJson(String str) => UsuariosModel.fromJson(json.decode(str));

String usuariosModelToJson(UsuariosModel data) => json.encode(data.toJson());

class UsuariosModel {

    String idDelUsuario;
    String nombreUsuario;
    String apellido;
    String direccion;
    String email;
    String contrasena;
    String creador;
    var edad;
    String fotoUrl;
    String nombreApp;

    UsuariosModel({
        this.idDelUsuario,
        this.nombreUsuario = '',
        this.apellido = '',
        this.direccion = '',
        this.email  = '',
        this.contrasena  = '', 
        this.creador = '',    
        this.edad = '',
        this.nombreApp = '',
        this.fotoUrl,
    });

    factory UsuariosModel.fromJson(Map<String, dynamic> json) => new UsuariosModel(
        idDelUsuario         : json["idDelUsuario"],
        nombreUsuario     : json["nombreUsuario"],
        apellido     : json["apellido"],
        direccion     : json["direccion"],
        email      : json["email"],
        contrasena : json["contrasena"],  
        creador    : json["creador"],
        edad       : json["edad"],
        nombreApp       : json["nombreApp"],
        fotoUrl    : json["fotoUrl"],
    );

    Map<String, dynamic> toJson() => {
         "idDelUsuario"        : idDelUsuario,
        "nombreUsuario"     : nombreUsuario,
        "apellido"     : apellido,
        "direccion"     : direccion,
        "email"      : email,
        "contrasena" : contrasena,  
        "creador"    : creador,  
        "edad"       : edad,
        "nombreApp"       : nombreApp,
        "fotoUrl"    : fotoUrl,
    };
}
