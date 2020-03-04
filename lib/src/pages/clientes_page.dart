import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:tonyredapp/src/widgets/menu_drawer.dart';

class ClientesPage extends StatefulWidget {
  ClientesPage({Key key}) : super(key: key);

  @override
  _ClientesPageState createState() => _ClientesPageState();
}

class _ClientesPageState extends State<ClientesPage> {
  Stream<QuerySnapshot> _queryStream;

  @override
  void initState() {
    super.initState();
    _queryStream = Firestore.instance
            .collection('clientes')
            .snapshots();
  }
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Clientes'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add_circle),
              onPressed: () {
                Navigator.pushNamed(context, 'cliente-modal' );
              },
            ),
        ],
      ),
      drawer: MenuDraweWidget(),
      body: SafeArea(
        child: _listaClientes(),
      //  child: Stack(
      //    children: <Widget>[
      //      Container(
      //        color: Colors.white,
      //        width: double.infinity,
      //        height: size.height,
      //      ),
            
      //    ],
      //  ),
      ),
    );
  }

  Widget _listaClientes() {
    return StreamBuilder<QuerySnapshot>(
      stream: _queryStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> data) {
        if (data.hasData){
          final lista = data.data.documents;

          return new ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: lista.length,
            itemBuilder: (context, i ) => _itemClienteCard(data.data.documents[i], data.data.documents[i].documentID),
          );
        }
          
        return Center(
          child: CircularProgressIndicator(),
        );

      }
    );

  }

  Widget _itemClienteCard(DocumentSnapshot document, String firebaseID) {

    return new Container(
      height: 50,
      margin: EdgeInsets.all(10.0),
      decoration: new BoxDecoration(
        color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black26,
              blurRadius: 2.0,
              offset: Offset(0.0, 3.0),
              spreadRadius: 2.0
            )
          ],
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 6.0,
            left: 6.0,
            child: Icon(Icons.wifi_tethering, size: 20.0, color: Colors.blueAccent)
          ),
          Positioned(
            top: 6.0,
            left: 36.0,
            right: 38.0,
            child: Text(document['nombre'],
              style: TextStyle(fontSize: 16.0, color: Colors.black87, fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis)
          ),
          Positioned(
            top: 6.0,
            right: 6.0,
            child: Icon(Icons.edit, size: 20.0, color: Colors.blueAccent)
          ),
          Positioned(
            top: 24.0,
            left: 36.0,
            right: 38.0,
            child: Text(document['telefono'],
              style: TextStyle(fontSize: 14.0, color: Colors.black54, fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis)
          ),
        ],
      ),
    );
  }

}