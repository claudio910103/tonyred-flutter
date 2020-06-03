import 'package:cloud_firestore/cloud_firestore.dart';

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

    factory ClienteModel.fromFirestore(DocumentSnapshot doc) {
      Map data = doc.data;

      return ClienteModel(
        id: doc.documentID,
        nombre: data['nombre'] ?? '',
        modeloAntena: data['modeloAntena'] ?? '',
        telefono: data['telefono'] ?? '',
        urlFachada: data['urlFachada'] ?? '',
        latitud: data['latitud'] ?? '',
        longitud: data['longitud'] ?? '',
        direccionIP: data['direccionIP'] ?? '',
        costoMensualidad: data['costoMensualidad'] ?? 0,
      );

    }

}
