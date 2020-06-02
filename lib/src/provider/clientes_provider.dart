import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:tonyredapp/src/models/cliente_model.dart';

class ClientesProvider {

  // Lista todos los clientes de firestore 
  Future<List<ClienteModel>> cargarClientes() async {
    final List<ClienteModel> clientes = new List();
    List<DocumentSnapshot> templist;
    CollectionReference collectionRef = Firestore.instance
            .collection('clientes');
    QuerySnapshot collectionSnapshot = await collectionRef.getDocuments();
    templist = collectionSnapshot.documents;

    templist.map((DocumentSnapshot docSnapshot){
      final clienteTemp = ClienteModel.fromJson(docSnapshot.data, docSnapshot.documentID);
      clientes.add(clienteTemp);
    }).toList();
    
    return clientes;
  }

  // Crear Cliente nuevo
  Future<bool> crearCliente(ClienteModel cliente) async{

    Firestore.instance.runTransaction((transaction) async {
      await transaction.set(Firestore.instance.collection("clientes").document(), {
        "nombre"        : cliente.nombre,
        "modeloAntena"  : cliente.modeloAntena,
        "telefono"      : cliente.telefono,
        "urlFachada"    : cliente.urlFachada,
        "latitud"       : cliente.latitud,
        "longitud"      : cliente.longitud,
        "direccionIP"   : cliente.direccionIP,
        "costoMensualidad"  : cliente.costoMensualidad,
      });
    });

    return true;
  }


} 