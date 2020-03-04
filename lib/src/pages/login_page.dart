import 'package:flutter/material.dart';

class LoginPage
 extends StatelessWidget {
  const LoginPage
  ({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }

  Widget _inputEmail() {
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
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
      child: TextField(
        obscureText: true,
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
      onPressed: () {}
    );
  } 

}