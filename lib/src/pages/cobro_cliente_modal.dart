import 'package:flutter/material.dart';
import 'package:tonyredapp/src/models/cliente_model.dart';
import 'package:tonyredapp/src/models/pagos_model.dart';
import 'package:tonyredapp/src/services/db.dart';

class CobroClienteModal extends StatefulWidget {
  const CobroClienteModal({Key key}) : super(key: key);

  @override
  _CobroClienteModalState createState() => _CobroClienteModalState();
}

class _CobroClienteModalState extends State<CobroClienteModal> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>(); // Para mostrar el snackbar
  String mesesAPagar = '1';
  String cantidadACobrar = '0';
  ClienteModel cliente = new ClienteModel();
  bool _guardando = false;
  final db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    final ClienteModel clienteData = ModalRoute.of(context).settings.arguments;
    if (clienteData != null) {
      cliente = clienteData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Cobrar'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SafeArea(child: _formularioCobro(context)),
    );
  }

  Widget _formularioCobro(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            SizedBox(height: 10.0),
            _iconoAntenaEstatus(),
            _tituloSeccion('Cliente:'),
            _nombreCliente(),
            _tituloSeccion('Dia de pago del cliente:'),
            _diaPagoCliente(),
            _tituloSeccion('Vigencia:'),
            _vigenciaCliente(),
            _tituloSeccion('Teléfono:'),
            _telefonoCliente(),
            _tituloSeccion('Seleccionar meses a cobrar:'),
            _selectMesesAPagar(context),
            _inputMontoCobro(),
            _botonCobrar()
          ],
        ),
      ),
    );
  }

  Widget _tituloSeccion(String texto) {
    return Container(
      height: 35.0,
      width: double.infinity,
      padding: EdgeInsets.only(left: 16.0, top: 16.0),
      child: Text(texto,
          style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w500,
              color: Colors.black54)),
    );
  }

  Widget _iconoAntenaEstatus() {
    String icono = 'antena-on.png';
    String texto = '-';
    final vigencia = new DateTime.utc(cliente.year, cliente.month, int.parse(cliente.diaPago));
    final fechaActual = new DateTime.now();
    if (vigencia.isBefore(fechaActual)) {
      icono = 'antena-off.png';
      texto = 'Pago pendiente';
    } else {
      icono = 'antena-on.png';
      texto = 'Vigente';
    }
    return Column(
      children: <Widget>[
        Container(
          child: Image.asset('assets/img/' + icono, width: 80),
        ),
        Container(
          child: Text(texto,
          style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w500,
              color: Colors.black54)),
        ),
      ],
    );
  }

  Widget _nombreCliente() {
    return Container(
      height: 20.0,
      width: double.infinity,
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      child: Text(cliente.nombre,
          style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: Colors.black87)),
    );
  }

  Widget _telefonoCliente() {
    return Container(
      height: 20.0,
      width: double.infinity,
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      child: Text(cliente.telefono,
          style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: Colors.black87)),
    );
  }

  Widget _vigenciaCliente() {
    return Container(
      height: 20.0,
      width: double.infinity,
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      child: Text(
          cliente.year.toString() + "-" + cliente.month.toString() + "-" + cliente.diaPago,
          style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: Colors.black87)),
    );
  }

  Widget _diaPagoCliente() {
    return Container(
      height: 20.0,
      width: double.infinity,
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      child: Text(cliente.diaPago,
          style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: Colors.black87)),
    );
  }

  Widget _selectMesesAPagar(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: DropdownButton<String>(
          value: mesesAPagar,
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
              mesesAPagar = newValue;
            });
          },
          items: <String>['1', '2', '3', '4', '5', '6']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList()),
    );
  }

  Widget _inputMontoCobro() {
    return Container(
        margin: EdgeInsets.only(bottom: 20.0),
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: TextFormField(
          initialValue: cantidadACobrar,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.attach_money, color: Colors.black38),
            hintStyle: TextStyle(color: Color.fromRGBO(30, 100, 247, 1.0)),
            labelStyle: TextStyle(color: Colors.black38),
            labelText: 'Monto a cobrar',
            hintText: 'Escriba la cantidad a cobrar al cliente',
          ),
          onSaved: (value) => cantidadACobrar = value,
          validator: (value) {
            if (value.length < 1) {
              return 'Cantidad inválida';
            } else {
              if (int.parse(value) <= 0) {
                return 'Cantidad inválida';
              } else {
                return null;
              }
            }
          },
        ));
  }

  Widget _botonCobrar() {
    return RaisedButton(
        child: Container(
          width: 120,
          height: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Icon(Icons.monetization_on),
              Text('COBRAR',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
            ],
          ),
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 1.0,
        color: Color.fromRGBO(30, 100, 247, 1.0),
        textColor: Colors.white,
        onPressed: (_guardando) ? null : _submit);
  }

  void _submit() async{
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();
    setState(() {
      _guardando = true;
    });

    final vigenciaNueva = new DateTime.utc(cliente.year, cliente.month + int.parse(mesesAPagar), int.parse(cliente.diaPago));
    cliente.year = vigenciaNueva.year;
    cliente.month = vigenciaNueva.month;
    cliente.diaPago = vigenciaNueva.day.toString();
    print(vigenciaNueva);

    var transaccion1 = await db.realizarCobroCliente(cliente);
    PagosModel pago = new PagosModel();
    var fechaHoy = new DateTime.now();
    if(transaccion1 == true){
      pago.clienteID = cliente.id;
      pago.montoPago = int.parse(cantidadACobrar);
      pago.meses = int.parse(mesesAPagar);
      pago.anio = fechaHoy.year;
      pago.mes = fechaHoy.month;
      pago.dia = fechaHoy.day;

      db.crearEntradaPago(pago);
      _mostrarSnackbar('Cobrado', 'success');
    }else{
      _mostrarSnackbar('Error al realizar el cobro', 'error');
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
