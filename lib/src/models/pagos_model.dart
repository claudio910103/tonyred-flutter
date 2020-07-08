import 'package:cloud_firestore/cloud_firestore.dart';

class PagosModel {

  String transaccion;
  String clienteID;
  int montoPago;
  int meses;
  int dia;
  int mes;
  int anio;

    PagosModel({
        this.transaccion,
        this.clienteID = '',
        this.montoPago  =  0,
        this.meses = 0,
        this.dia = 0,
        this.mes = 0,
        this.anio = 0,
    });

    factory PagosModel.fromFirestore(DocumentSnapshot doc) {
      Map data = doc.data;

      return PagosModel(
        transaccion: doc.documentID,
        clienteID: data['clienteID'] ?? '',
        montoPago: data['montoPago'] ?? 0,
        meses: data['meses'] ?? 0,
        dia: data['dia'] ?? 0,
        mes: data['mes'] ?? 0,
        anio: data['anio'] ?? 0,
      );

    }

}
