import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tonyredapp/src/models/cliente_model.dart';
import 'package:tonyredapp/src/services/db.dart';


import 'package:tonyredapp/src/widgets/menu_drawer.dart';


class ClientesPage extends StatelessWidget {

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
        child: ClientesLista(),
      ),
    );
  }

}

  class ClientesLista extends StatelessWidget {
    final auth = FirebaseAuth.instance;
    final db = DatabaseService();
  
    @override
    Widget build(BuildContext context) {

      return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              StreamProvider<List<ClienteModel>>.value(
                initialData: [],
                value: db.streamClientes(),
                child: CardClienteItem(),
              ),
            ],
          ),
      );
    }
  }

  class CardClienteItem extends StatelessWidget {
  
    @override
    Widget build(BuildContext context) {
      var clientes = Provider.of<List<ClienteModel>>(context);
      final size = MediaQuery.of(context).size;

      return Container(
        height: size.height,
        child: ListView(
          children: clientes.map((clie) {

          return new Container(
            height: 70,
            margin: EdgeInsets.all(10.0),
            decoration: new BoxDecoration(
              color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3.0,
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
                  child: Text(clie.nombre,
                    style: TextStyle(fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis)
                ),
                Positioned(
                  top: 6.0,
                  right: 6.0,
                  child: Icon(Icons.more_vert, size: 20.0, color: Colors.blueAccent)
                ),
                Positioned(
                  top: 24.0,
                  left: 36.0,
                  right: 38.0,
                  child: Text(clie.telefono,
                    style: TextStyle(fontSize: 12.0, color: Colors.black54, fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis)
                ),
              ],
            ),
          );

          }).toList(),
        ),
      );


    }
  }