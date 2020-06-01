// To parse this JSON data, do
//
//     final productoModel = productoModelFromJson(jsonString);

import 'dart:convert';

ClienteModel clienteModelFromJson(String str, String id) => ClienteModel.fromJson(json.decode(str), id);

String clienteModelToJson(ClienteModel data) => json.encode(data.toJson());

class ClienteModel {

    String id;
    String nombre;
    String modeloAntena;
    String telefono;
    String urlFachada;
    String latitud;
    String longitud;
    String direccionIP;
    int costoMensualidad;

    ClienteModel({
        this.id,
        this.nombre = '',
        this.modeloAntena  = '',
        this.telefono = '',
        this.urlFachada = '',
        this.latitud = '',
        this.longitud = '',
        this.direccionIP = '',
        this.costoMensualidad = 0,
    });

    factory ClienteModel.fromJson(Map<String, dynamic> json, dynamic documentID) => new ClienteModel(
        id            : documentID,
        nombre        : json["nombre"],
        modeloAntena  : json["modeloAntena"],
        telefono      : json["telefono"],
        urlFachada    : json["urlFachada"],
        latitud       : json["latitud"],
        longitud      : json["longitud"],
        direccionIP   : json["direccionIP"],
        costoMensualidad  : json["costoMensualidad"],
    );

    Map<String, dynamic> toJson() => {
        // "id"         : id,
        "nombre"        : nombre,
        "modeloAntena"  : modeloAntena,
        "telefono"      : telefono,
        "urlFachada"    : urlFachada,
        "latitud"       : latitud,
        "longitud"      : longitud,
        "direccionIP"   : direccionIP,
        "costoMensualidad"  : costoMensualidad,
    };
}
