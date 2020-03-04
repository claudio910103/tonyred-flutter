import 'package:flutter/material.dart';
import 'package:tonyredapp/src/widgets/menu_drawer.dart';

class ClientesPage extends StatefulWidget {
  ClientesPage({Key key}) : super(key: key);

  @override
  _ClientesPageState createState() => _ClientesPageState();
}

class _ClientesPageState extends State<ClientesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clientes'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add_circle),
              onPressed: () {
                
              },
            ),
        ],
      ),
      drawer: MenuDraweWidget(),
      body: SafeArea(
       child: Stack(
         children: <Widget>[
           Container(
             color: Colors.white,
             width: double.infinity,
           )
         ],
       ),
      ),
    );
  }
}