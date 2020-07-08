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
  String diaPago;
  int costoMensualidad;
  int year;
  int month;

    ClienteModel({
        this.id,
        this.nombre = '',
        this.modeloAntena  = '',
        this.telefono = '',
        this.urlFachada = '',
        this.latitud = '',
        this.longitud = '',
        this.direccionIP = '',
        this.diaPago = '',
        this.costoMensualidad = 0,
        this.year,
        this.month,
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
        diaPago: data['diaPago'] ?? '',
        costoMensualidad: data['costoMensualidad'] ?? 0,
        year: data['year'] ?? 0,
        month: data['month'] ?? 0,
      );

    }

}
