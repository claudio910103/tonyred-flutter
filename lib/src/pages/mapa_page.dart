import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tonyredapp/src/api/api_keys.dart';
import 'package:tonyredapp/src/models/cliente_model.dart';
import 'package:tonyredapp/src/widgets/menu_drawer.dart';

class MapaPage extends StatefulWidget {
  MapaPage({Key key}) : super(key: key);

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  MapController _map = new MapController();
  LatLng _ubicacionInicial = new LatLng(16.5588581, -95.1009607);
  double _zoomInicial = 14.0;
  List<Marker> allMarkers = [];
  // final prefs = new PreferenciasService();
  SharedPreferences prefs;
  String tipoMapa; // streets, dark, light, outdoors, satellite
  StreamSubscription<Position> _positionStream;

  @override
  void initState() {
    super.initState();
    _consultarPrefs();
    var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
    _positionStream =  Geolocator().getPositionStream(locationOptions).listen((Position position) {
      setState(() {
        _ubicacionInicial =  new LatLng(position.latitude, position.longitude);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _positionStream.cancel();
  }

  _consultarPrefs() async{
    print('CONSULTA_PREFS');
    prefs = await SharedPreferences.getInstance();
    tipoMapa =  prefs.getString('mapa') ?? 'mapbox/streets-v11';
    print('MAPA-GUARDADO:'+ tipoMapa);
  }

  @override
  Widget build(BuildContext context) {
    print(_ubicacionInicial);

    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa'),
      ),
      drawer: MenuDraweWidget(),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            _mapaMapbox(context),
            _botonMapa(),
            _botonUbicacionGPS(),
            _botonAddMarcador(context)
          ],
        ),
      ),
    );
  }

  Widget _botonMapa() {
    return Positioned(
      top: 8.0,
      right: 8.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40.0),
        child: Container(
          color: Color.fromRGBO(40, 40, 40, 1),
          width: 40.0,
          height: 40.0,
          child: FloatingActionButton(
            heroTag: 'fa-btn-map',
            elevation: 0.0,
            child: Icon( Icons.map, size: 25.0, color: Colors.lightBlue),
            backgroundColor: Colors.transparent,
            onPressed: _cambiarLayerMapa
          ),
        ),
      )
    );
  }

  Widget _botonUbicacionGPS() {
    return Positioned(
      top: 60.0,
      right: 8.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40.0),
        child: Container(
          color: Color.fromRGBO(40, 40, 40, 1),
          width: 40.0,
          height: 40.0,
          child: FloatingActionButton(
            heroTag: 'fa-btn-gps',
            elevation: 0.0,
            child: Icon( Icons.my_location, size: 25.0, color: Colors.lightBlue),
            backgroundColor: Colors.transparent,
            onPressed: (){
              setState(() {
                // _zoomInicial++;
                _updateZoomMap();
              });
            }
          ),
        ),
      )
    );
  }

  Widget _botonAddMarcador(BuildContext context ) {
    return Positioned(
      bottom: 8.0,
      right: 8.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40.0),
        child: Container(
          color: Color.fromRGBO(40, 40, 40, 1),
          width: 40.0,
          height: 40.0,
          child: FloatingActionButton(
            heroTag: 'fa-btn-marker',
            elevation: 0.0,
            child: Icon( Icons.person_pin, size: 30.0, color: Colors.lightBlue),
            backgroundColor: Colors.transparent,
            onPressed: (){
              Navigator.pushNamed(context, 'cliente-modal');
            }
          ),
        ),
      )
    );
  }

  // Widget del contenedor del mapa 
  Widget _mapaMapbox(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return StreamBuilder(
      stream: Firestore.instance.collection('clientes').snapshots(),
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return Text('Cargando mapa');
        } else {
          allMarkers.clear();
          for (int i = 0; i < snapshot.data.documents.length; i++) {
            final String nombre = snapshot.data.documents[i]['nombre'];
            final double latitud = double.parse(snapshot.data.documents[i]['latitud']);
            final double longitud = double.parse(snapshot.data.documents[i]['longitud']);
            // Vigencia Cliente
            final int year = snapshot.data.documents[i]['year'];
            final int month = snapshot.data.documents[i]['month'];
            final int day = int.parse(snapshot.data.documents[i]['diaPago']);

            final vigencia = new DateTime.utc(year, month, day);
            final fechaActual = new DateTime.now();

            String icono = 'antena-on.png';
            ClienteModel cliente = new ClienteModel();

            if(vigencia.isBefore(fechaActual)){
              icono = 'antena-off.png';
            } else{
              icono = 'antena-on.png';
            }

            // Mapeo manual de firestore al modelo 
            cliente.id = snapshot.data.documents[i].documentID;
            cliente.nombre = snapshot.data.documents[i]['nombre'];
            cliente.modeloAntena = snapshot.data.documents[i]['modeloAntena'];
            cliente.telefono = snapshot.data.documents[i]['telefono'];
            cliente.urlFachada = snapshot.data.documents[i]['urlFachada'];
            cliente.latitud = snapshot.data.documents[i]['latitud'];
            cliente.longitud = snapshot.data.documents[i]['longitud'];
            cliente.direccionIP = snapshot.data.documents[i]['direccionIP'];
            cliente.diaPago = snapshot.data.documents[i]['diaPago'];
            cliente.costoMensualidad = snapshot.data.documents[i]['costoMensualidad'];
            cliente.year = snapshot.data.documents[i]['year'];
            cliente.month = snapshot.data.documents[i]['month'];


            allMarkers.add(new Marker(
                  width: 250.0,
                  height: 90.0,
                  point: new LatLng(latitud,longitud),
                  builder: (ctx) =>
                  Column(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          color: Color.fromRGBO(40, 40, 40, 0.7),
                          padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                          child: Text(nombre,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w700
                            ),
                            overflow: TextOverflow.ellipsis
                          )
                        )
                      ),
                      SizedBox(height: 5.0),
                      GestureDetector(
                        child: Container(
                          child: Image.asset('assets/img/'+icono, width: 30)
                        ),
                        onTap: () {
                           Navigator.pushNamed(context, 'cobro-cliente', arguments: cliente);
                        },
                      ),
                    ]
                  ),
              ),
            );

          }
          return Container(
              width: size.width,
              height: size.height,
              child: FlutterMap(
                mapController: _map,
                options: MapOptions(
                  center: _ubicacionInicial,
                  zoom: _zoomInicial
                ),
                layers: [
                  _tileLayerOptions(),
                  _ubicacionActualMarker(),
                  new MarkerLayerOptions(markers: allMarkers)
                  // _creaMarcadores()  
                ],  
              ),
          );
        }
      }, 
    );

  }

  _tileLayerOptions() {
    
    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}@2x?access_token={accessToken}',
      additionalOptions: {
        'accessToken': mapBoxKey,
        'id': tipoMapa, 
        // streets, dark, light, outdoors, satellite
      }
    );
  }

  MarkerLayerOptions _ubicacionActualMarker(){
    return new MarkerLayerOptions(
          markers: [
            new Marker(
              width: 80.0,
              height: 80.0,
              point: _ubicacionInicial,
              builder: (ctx) =>
              new Container(
                child: Icon(
                  Icons.person_pin_circle,
                  color: Colors.lightBlue,
                  size: 50.0,
                ),
              ),
            ),
          ],
    );
  }

  void _updateZoomMap() async {
    print('get ubicacion');
    _getCurrentLocation();
    _map.move(_ubicacionInicial, 16.0);
  }

  void _cambiarLayerMapa() async{
    
    String mapa = 'mapbox/streets-v11';
    prefs = await SharedPreferences.getInstance();
    String mapaPrefs = prefs.getString('mapa') ?? 'mapbox/streets-v11';

    if(mapaPrefs == 'mapbox/streets-v11'){
      mapa = 'mapbox/outdoors-v11';
    }
    if(mapaPrefs == 'mapbox/outdoors-v11'){
      mapa = 'mapbox/light-v10';
    }
    if(mapaPrefs == 'mapbox/light-v10'){
      mapa = 'mapbox/dark-v10';
    }
    if(mapaPrefs == 'mapbox/dark-v10'){
      mapa = 'mapbox/satellite-v9';
    }
    if(mapaPrefs == 'mapbox/satellite-v9'){
      mapa = 'mapbox/satellite-streets-v11';
    }
    if(mapaPrefs == 'mapbox/satellite-streets-v11'){
      mapa = 'mapbox/streets-v11';
    }


    print('MAPANUEVO::'+ mapa);
    setState(() {
      tipoMapa = mapa;
      prefs.setString('mapa', tipoMapa);
    });

  }

  _getCurrentLocation() async{
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position ubicacion) {
          setState(() {
            _ubicacionInicial = new LatLng(ubicacion.latitude, ubicacion.longitude);
          });
        }).catchError((e) {
          print(e);
        });

  }

}