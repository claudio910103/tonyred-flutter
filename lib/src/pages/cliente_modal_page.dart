import 'package:flutter/material.dart';
 
class ClienteModalPage extends StatefulWidget {
  ClienteModalPage({Key key}) : super(key: key);

  @override
  _ClienteModalState createState() => _ClienteModalState();
}

class _ClienteModalState extends State<ClienteModalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Cliente'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.cancel),
              onPressed: () {
                 Navigator.pop(context);
              },
            ),
        ],
      ),
       body: Center(
         child: Text('Modal'),
       ),
    );
  }
}