import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tonyredapp/src/services/db.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _db = DatabaseService();

  SharedPreferences prefs;

  String correo = '';
  String password = '';

  @override
  void initState(){
    super.initState();
    _validarUsuario();
  }

  void _validarUsuario() async {
    var user = await _db.getCurrentUser();
    if(user.email != null){
      // print(user.email);
      Navigator.pushReplacementNamed(context, 'mapa' );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            _fondoAplicacion(context),
            _formularioLogin(context)
          ],
        ),
      ),
    );
  }

  Widget _fondoAplicacion(BuildContext context) {
    // Tamaño de la pantalla del dispositivo.
    final size = MediaQuery.of(context).size;

    final circulo = Container(
      width: 95.0,
      height: 95.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.05)
      ),
    );

    final fondo = Container(
      height: size.height * 0.5,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Color.fromRGBO(54, 209, 220, 1.0),
            Color.fromRGBO(91, 134, 229, 1.0),
          ]
        )
      ),
    );

    return Stack(
      children: <Widget>[
        fondo,
        Positioned(child: circulo, top: 40, left: 20),
        Positioned(child: circulo, top: -40, right: -50),
        Positioned(child: circulo, top: 400, right: 30),
        Positioned(child: circulo, bottom: -40, right: 180),
        Container(
          padding: EdgeInsets.only(top: 35),
          child: Column(
            children: <Widget>[
              Icon(Icons.wifi_tethering, color: Colors.white, size: 100.0),
              SizedBox(height: 5.0, width: double.infinity),
              Text('Tony Red', style: TextStyle(color: Color.fromRGBO(225, 245, 254, 1.0), fontSize: 18.0, fontWeight: FontWeight.w800))
            ],
          ),
        )
      ],
    );

  }

  Widget _formularioLogin(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Form(
        key: formKey,
          child: Column(
          children: <Widget>[
            SizedBox(height: size.height * 0.3, width: double.infinity),
            Container(
              width: size.width * 0.90,  
              margin: EdgeInsets.symmetric(vertical: 40.0),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                // color: Colors.white,
                color: Color.fromRGBO(255, 255, 255, 1.0),
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3.0,
                    offset: Offset(0.0, 2.0),
                    spreadRadius: 2.0
                  )
                ]
              ),
              child: Column(
                children: <Widget>[
                  _inputEmail(),
                  _inputPassword(),
                  _botonSubmit()
                ],
              ),
            ),
            SizedBox(height: 100.0)
          ],
        ),
      ),
    );
  }

  Widget _inputEmail() {
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: TextFormField(
        initialValue: correo,
        keyboardType: TextInputType.emailAddress,
        onSaved: (value) => correo = value,
        validator: (value) {
          if ( value.length < 3 ) {
            return 'Correo no válido!';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          icon: Icon( Icons.mail_outline, color: Colors.black38),
          hintStyle: TextStyle(color: Colors.blueAccent),
          labelStyle: TextStyle(color: Colors.black38),  
          hintText: 'ejemplo@correo.com',
          labelText: 'Correo electrónico',
        ),
      )
    );

  }

  Widget _inputPassword() {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: TextFormField(
        initialValue: password,
        obscureText: true,
        onSaved: (value) => password = value,
        validator: (value) {
          if(value.length < 2){
            return 'Contraseña no válida';
          } else{
            return null;
          }
        },
        decoration: InputDecoration(
          icon: Icon( Icons.lock_outline, color: Colors.black38),
          hintStyle: TextStyle(color: Colors.blueAccent),
          labelStyle: TextStyle(color: Colors.black38),
          hintText: 'ejemplo@correo.com',
          labelText: 'Contraseña',
        ),
      )
    );

  }

  Widget _botonSubmit() {
    return RaisedButton(
      child: Container(
            padding: EdgeInsets.symmetric( horizontal: 80.0, vertical: 15.0),
            child: Text('Ingresar'),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      elevation: 1.0,
      color: Color.fromRGBO(57, 106, 252, 1.0),
      textColor: Colors.white,
      onPressed: _login
    );
  } 

  void _login() async{
    if ( !formKey.currentState.validate() ) return;
    formKey.currentState.save();
    var result = await _db.loginFirebase(correo, password);
    prefs = await SharedPreferences.getInstance();

    if (result == true) {
      prefs.setString('email', correo);
      Navigator.pushReplacementNamed(context, 'mapa' );
    }else{
      _mostrarSnackbar('Error. Credenciales incorrectas', 'error');
    }
    
  }

  void _mostrarSnackbar(String mensaje, String tipo) {
    if (tipo == 'success') {
      final snackbar = SnackBar(
        content: Text(mensaje),
        backgroundColor: Colors.green,
        duration: Duration(milliseconds: 2500),
      );
      scaffoldKey.currentState.showSnackBar(snackbar);
    } else {
      final snackbar = SnackBar(
        content: Text(mensaje),
        backgroundColor: Colors.red,
        duration: Duration(milliseconds: 2500),
      );
      scaffoldKey.currentState.showSnackBar(snackbar);
    }
  }

}