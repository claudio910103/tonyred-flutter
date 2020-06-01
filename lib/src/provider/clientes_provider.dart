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
      print('cargando');
    }).toList();
    
    return clientes;
  }
} 