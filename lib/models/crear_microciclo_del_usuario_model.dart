import 'dart:convert';

MicrocicloModel microcicloModelFromJson(String str) => MicrocicloModel.fromJson(json.decode(str));

String microcicloModelToJson(MicrocicloModel data) => json.encode(data.toJson());

class MicrocicloModel {

    String id2;
    String dia;
    String idAdministrador;
    String idCliente;
    int numeroDelMicrociclo;
    String objetivoMicrociclo;
    // String from;
    // String to;

    MicrocicloModel({
        this.id2,
        this.dia        = '',
        this.idAdministrador = '',
        this.idCliente = '',
        this.numeroDelMicrociclo,
        this.objetivoMicrociclo  = '',
        // this.from       = '',
        // this.to         = '',
    });

    factory MicrocicloModel.fromJson(Map<String, dynamic> json) => new MicrocicloModel(
        id2            : json["id2"],
        dia           : json["día"],
        idAdministrador    : json["idAdministrador"],
        idCliente    : json["idCliente"],
        numeroDelMicrociclo      : json["numeroDelMicrociclo"],
        objetivoMicrociclo     : json["objetivoMicrociclo"],
        // from          : json["from"],    
        // to            : json["to"],    
    );

    Map<String, dynamic> toJson() => {
        //  "id"         : id,
        "día"         : dia,
        "idAdministrador"  : idAdministrador,
        "idCliente"  : idCliente,
        "numeroDelMicrociclo"    : numeroDelMicrociclo,
        "objetivoMicrociclo"   : objetivoMicrociclo,
        // "from"        : from,
        // "to"          : to,
    };
}
