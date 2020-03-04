import 'package:flutter/material.dart';


class MenuDraweWidget extends StatelessWidget {
  final textItemStyle = TextStyle(color: Colors.lightBlue[100], fontWeight: FontWeight.w700);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Color.fromRGBO(30, 100, 247, 1.0),
              Color.fromRGBO(0, 10, 74, 1.0),
            ]
          )
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _fondoMenuHeader(),
            ListTile(
              leading: Image.asset('assets/img/mapa.png', height: 30.0),
              title: Text('Mapas', style: textItemStyle),
              onTap: (){
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, 'mapa' );
              },
            ),
            ListTile(
              leading: Image.asset('assets/img/clientes.png', height: 30.0),
              title: Text('Clientes', style: textItemStyle),
              onTap: (){
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, 'clientes' );
              },
            ),
            ListTile(
              leading: Image.asset('assets/img/ticket.png', height: 30.0),
              title: Text('Tickets', style: textItemStyle),
              onTap: (){ },
            ),
            ListTile(
              leading: Image.asset('assets/img/ajustes.png', height: 30.0),
              title: Text('Ajustes', style: textItemStyle),
              onTap: (){ },
            ),
            ListTile(
              leading: Image.asset('assets/img/close.png', height: 30.0),
              title: Text('Salir', style: textItemStyle),
              onTap: (){
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, 'login' );
              },
            ),

          ],
        ),
      ),
    );
  }

  _fondoMenuHeader(){
    return DrawerHeader(
      child: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/img/usuario.png', height: 80,),
              Text('Claudio Velazquez Vazquez', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 14.0))
            ],
          ),
        ),
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/img/img-antena.jpg'),
          fit: BoxFit.cover
        )
      )
    );
  }


}