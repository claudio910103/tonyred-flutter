import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:tonyredapp/src/models/cliente_model.dart';
import 'package:tonyredapp/src/models/pagos_model.dart';

class DatabaseService {
  final Firestore _db = Firestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<List<ClienteModel>> streamClientes() {
    var ref = _db.collection('clientes');
    return ref.snapshots().map((list) => 
      list.documents.map((doc) => ClienteModel.fromFirestore(doc)).toList()
    );
  }

  // Crea un nuevo cliente 
  Future<String> crearCliente(ClienteModel cliente) async{

    DocumentReference newdocument = Firestore.instance.collection("clientes").document();
    _db.runTransaction((Transaction transaction) async {
        await transaction.set(newdocument, {
          "nombre"        : cliente.nombre,
          "modeloAntena"  : cliente.modeloAntena,
          "telefono"      : cliente.telefono,
          "urlFachada"    : cliente.urlFachada,
          "latitud"       : cliente.latitud,
          "longitud"      : cliente.longitud,
          "direccionIP"   : cliente.direccionIP,
          "costoMensualidad"  : cliente.costoMensualidad,
          "year"          : cliente.year,
          "month"         : cliente.month,
          "diaPago"       : cliente.diaPago,
        });

    });

    return newdocument.documentID;
  }

  Future<bool> realizarCobroCliente(ClienteModel cliente) async{
    DocumentReference documento = Firestore.instance.collection("clientes").document(cliente.id);

    _db.runTransaction((Transaction transaction) async {
      await transaction.update(documento, {
          "nombre"        : cliente.nombre,
          "modeloAntena"  : cliente.modeloAntena,
          "telefono"      : cliente.telefono,
          "urlFachada"    : cliente.urlFachada,
          "latitud"       : cliente.latitud,
          "longitud"      : cliente.longitud,
          "direccionIP"   : cliente.direccionIP,
          "costoMensualidad"  : cliente.costoMensualidad,
          "year"          : cliente.year,
          "month"         : cliente.month,
          "diaPago"       : cliente.diaPago,
        }).catchError((e) {
          return false;
        });
    });
    return true;
  }

  Future<bool> crearEntradaPago(PagosModel pagos) async{

    DocumentReference pagosDocument = Firestore.instance.collection("pagos").document();
    _db.runTransaction((Transaction transaction) async {
        await transaction.set(pagosDocument, {
          "clienteID" : pagos.clienteID,
          "montoPago" : pagos.montoPago,
          "meses"     : pagos.meses,
          "dia"       : pagos.dia,
          "mes"       : pagos.mes,
          "anio"      : pagos.anio,
        }).catchError((err) {
          return false;
        });
    });

    return true;
  }

  Future<bool> loginFirebase(String email, String password) async{
    
    try{
      var user = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      print(user.user.email);
      return true;
    } catch(e){
      print(e.message);
      return false;
    }
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
  
}