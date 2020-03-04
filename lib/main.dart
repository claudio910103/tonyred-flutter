import 'package:flutter/material.dart';

import 'package:tonyredapp/src/pages/cliente_modal_page.dart';
import 'package:tonyredapp/src/pages/clientes_page.dart';
import 'package:tonyredapp/src/pages/login_page.dart';
import 'package:tonyredapp/src/pages/mapa_page.dart';

 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tony Red',
      initialRoute: 'clientes',
      routes: {
        'login' : (BuildContext context) => LoginPage(),
        'mapa' : (BuildContext context) => MapaPage(),
        'clientes' : (BuildContext context) => ClientesPage(),
        'cliente-modal' : (BuildContext context) => ClienteModalPage()
      },
      theme: ThemeData(
        primaryColor: Color.fromRGBO(30, 100, 247, 1.0)
      )
    );
  }
}
