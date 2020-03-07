import 'package:flutter/material.dart';
 
class ClienteModalPage extends StatefulWidget {
  ClienteModalPage({Key key}) : super(key: key);

  @override
  _ClienteModalState createState() => _ClienteModalState();
}

class _ClienteModalState extends State<ClienteModalPage> {
  String dropdownValue = '1 Mes';


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
       body: SafeArea(
         child: _formularioCliente(),
       ),
    );
  }

  Widget _formularioCliente() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: 10.0),
          _tituloSeccion('Datos Cliente:'),
          _inputNombreCliente(),
          _inputTelCliente(),
          _inputModAntena(),
          _inputDireccionIP(),
          _tituloSeccion('Coordenadas:'),
          _seccionUbicacion(),
          _tituloSeccion('Pagos:'),
          _selectMensualidad(),
          _tituloSeccion('Fotografia Fachada:'),
          _botonFotografia(),
          SizedBox(height: 80.0),
          _botonGuardarCliente() ,
          SizedBox(height: 80.0)
        ],
      ),
    );

  }

  Widget _tituloSeccion(String texto) {
    return Container(
      height: 40.0,
      width: double.infinity,
      padding: EdgeInsets.only(left: 16.0, top: 16.0),
      child: Text(
        texto.toUpperCase(),
        style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700, color: Colors.black54)
      ),
    );
  }

  Widget _inputNombreCliente() {
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon( Icons.person_outline, color: Colors.black38),
          hintStyle: TextStyle(color: Color.fromRGBO(30, 100, 247, 1.0)),
          labelStyle: TextStyle(color: Colors.black38),  
          labelText: 'Nombre del cliente',
          hintText: 'Escriba el nombre del cliente...',
        ),
      )
    );
  }

  Widget _inputTelCliente() {
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: TextField(
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          prefixIcon: Icon( Icons.phone_android, color: Colors.black38),
          hintStyle: TextStyle(color: Color.fromRGBO(30, 100, 247, 1.0)),
          labelStyle: TextStyle(color: Colors.black38),  
          labelText: 'Teléfono del cliente',
          hintText: 'Escriba el teléfono de contacto del cliente...',
        ),
      )
    );
  }

  Widget _inputModAntena() {
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon( Icons.wifi_tethering, color: Colors.black38),
          hintStyle: TextStyle(color: Color.fromRGBO(30, 100, 247, 1.0)),
          labelStyle: TextStyle(color: Colors.black38),  
          labelText: 'Modelo de la antena',
          hintText: 'Escriba el modelo de la antena...',
        ),
      )
    );
  }

  Widget _inputDireccionIP() {
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon( Icons.settings_remote, color: Colors.black38),
          hintStyle: TextStyle(color: Color.fromRGBO(30, 100, 247, 1.0)),
          labelStyle: TextStyle(color: Colors.black38),  
          labelText: 'Direccion IP',
          hintText: 'Escriba la dirección IP de la antena...',
        ),
      )
    );
  }


  Widget _seccionUbicacion() {
    return SizedBox(
      height: 70.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _inputLatitud(),
          _inputLongitud()
        ],
      ),
    );
  }

  Widget _inputLatitud() {
    final size = MediaQuery.of(context).size;
    
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      padding: EdgeInsets.only(left: 12.0),
      width: size.width * 0.47,
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon( Icons.place, color: Colors.black38),
          hintStyle: TextStyle(color: Color.fromRGBO(30, 100, 247, 1.0)),
          labelStyle: TextStyle(color: Colors.black38),  
          labelText: 'Latitud',
          hintText: 'Escriba la latitud...',
        ),
      )
    );
  }

  Widget _inputLongitud() {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      padding: EdgeInsets.only(right: 12.0),
      width: size.width * 0.47,
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon( Icons.place, color: Colors.black38),
          hintStyle: TextStyle(color: Color.fromRGBO(30, 100, 247, 1.0)),
          labelStyle: TextStyle(color: Colors.black38),  
          labelText: 'Longitud',
          hintText: 'Escriba la longitud...',
        ),
      )
    );
  }

  Widget _selectMensualidad() {
    final size = MediaQuery.of(context).size;

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[

            Container(
              padding: EdgeInsets.only(left: 12.0),
              width: size.width * 0.47,
              height: 65,
              child: DropdownButton<String>(
                value: dropdownValue,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                underline: Container(
                  height: 1,
                  color: Colors.black38,
                ),
                isExpanded: true,
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
                items: <String>['1 Mes', '2 Meses', '3 Meses', '4 Meses']
                  .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  })
                  .toList()
              ),
            ),

            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              padding: EdgeInsets.only(right: 12.0),
              width: size.width * 0.47,
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: Icon( Icons.monetization_on, color: Colors.black38),
                  hintStyle: TextStyle(color: Color.fromRGBO(30, 100, 247, 1.0)),
                  labelStyle: TextStyle(color: Colors.black38),  
                  labelText: 'Monto mensualidad',
                  hintText: '\$ 0.00',
                ),
              )
            )

          ],
        ),
      ],
    );
  }

  Widget _botonFotografia() {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      child: MaterialButton(
        color: Color.fromRGBO(30, 100, 247, 1.0),
        height: 40.0,
        minWidth: 40.0,
        child: Icon(Icons.camera_enhance, color: Colors.white,),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
        onPressed: () {}
      )
    );
  }

  Widget _botonGuardarCliente() {
    return RaisedButton(
      child: Container(
        width: 140,
        height: 40.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(Icons.save),
            Text('GUARDAR', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0)
      ),
      elevation: 1.0,
      color: Color.fromRGBO(30, 100, 247, 1.0),
      textColor: Colors.white,
      onPressed: () {}
    );
  }

}