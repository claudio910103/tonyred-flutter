import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:tonyredapp/src/api/api_keys.dart';
import 'package:tonyredapp/src/widgets/menu_drawer.dart';

class MapaPage extends StatefulWidget {
  MapaPage({Key key}) : super(key: key);

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  MapController _map = new MapController();
  LatLng _ubicacionInicial = new LatLng(16.5588581, -95.1009607);
  double _zoomInicial = 15.0;
  String tipoMapa = "dark"; // streets, dark, light, outdoors, satellite
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clientes'),
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
            onPressed: (){
            }
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
                _zoomInicial++;
                _updateZoomMap(_ubicacionInicial, 17.0);
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
            child: Icon( Icons.wifi_tethering, size: 30.0, color: Colors.lightBlue),
            backgroundColor: Colors.transparent,
            onPressed: (){

            }
          ),
        ),
      )
    );
  }

  // Widget del contenedor del mapa 
  Widget _mapaMapbox(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
          _crearMapa(),
          _ubicacionActualMarker(),
          _creaMarcadores()  
        ],  
      ),
    );

  }

  _crearMapa() {

    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/v4/'
      '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additionalOptions: {
        'accessToken': mapBoxKey,
        'id': 'mapbox.$tipoMapa' 
        // streets, dark, light, outdoors, satellite
      }
    );
  }

  _ubicacionActualMarker(){
    return new MarkerLayerOptions(
          markers: [
            new Marker(
              width: 80.0,
              height: 80.0,
              point: _ubicacionInicial,
              builder: (ctx) =>
              new Container(
                child: Icon(
                  Icons.place,
                  color: Colors.lightBlue,
                  size: 50.0,
                ),
              ),
            ),
          ],
    );
  }

  _creaMarcadores(){
    return new MarkerLayerOptions(
          markers: [
            new Marker(
              width: 250.0,
              height: 90.0,
              point: new LatLng(16.5602482,-95.0992879),
              builder: (ctx) =>
              Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      color: Color.fromRGBO(40, 40, 40, 0.7),
                      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                      child: Text('Salon Zandunga',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w700
                        ),
                        overflow: TextOverflow.ellipsis
                      )
                    )
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    child: Image.asset('assets/img/antena-on.png', width: 40)
                  ),
                ]
              ),
            ),
          ],
    );
  }

  Future<void> _updateZoomMap(LatLng centro, double newZoom) async {
    _map.move(centro, newZoom);
  }

}