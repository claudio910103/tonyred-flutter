import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tonyredapp/src/models/cliente_model.dart';

class DatabaseService {
  final Firestore _db = Firestore.instance;

  Stream<List<ClienteModel>> streamClientes() {
    var ref = _db.collection('clientes');
    return ref.snapshots().map((list) => 
      list.documents.map((doc) => ClienteModel.fromFirestore(doc)).toList()
    );
  }

  Future<bool> crearCliente(ClienteModel cliente) async{

   _db.runTransaction((transaction) async {
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