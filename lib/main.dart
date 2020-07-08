import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:tonyredapp/src/pages/cliente_modal_page.dart';
import 'package:tonyredapp/src/pages/clientes_page.dart';
import 'package:tonyredapp/src/pages/cobro_cliente_modal.dart';
import 'package:tonyredapp/src/pages/login_page.dart';
import 'package:tonyredapp/src/pages/mapa_page.dart';

 
void main() {
  runApp(MyApp());
} 
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
          providers: [
            StreamProvider<FirebaseUser>.value(value: FirebaseAuth.instance.onAuthStateChanged)
          ],
          child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Tony Red',
          initialRoute: 'login',
          routes: {
            'login' : (context) => LoginPage(),
            'mapa' : (context) => MapaPage(),
            'clientes' : (context) => ClientesPage(),
            'cliente-modal' : (context) => ClienteModalPage(),
            'cobro-cliente' : (context) => CobroClienteModal()
          },
          theme: ThemeData(
            primaryColor: Color.fromRGBO(30, 100, 247, 1.0)
          )
        ),
    );

  }
}
