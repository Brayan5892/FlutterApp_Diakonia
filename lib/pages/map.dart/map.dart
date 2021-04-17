import 'package:diakonia/objects/service.dart';
import 'package:flutter/material.dart';

/*import para los permisos */
import 'package:permission_handler/permission_handler.dart';

/*import de google maps */
import 'package:google_maps_flutter/google_maps_flutter.dart';

/*import para la localizacion */
import 'package:geolocator/geolocator.dart';

class map extends StatefulWidget{
  map():super();
  final String title="Demo Google Maps";
  @override
  mapState createState()=>mapState();
}

class mapState extends State<map>{

/*Localizacion*/
LatLng _currentLocation;
  _locatePosition()async{
    Position position=await Geolocator.getCurrentPosition(desiredAccuracy:LocationAccuracy.high,forceAndroidLocationManager: true);
    _currentLocation=LatLng(position.latitude, position.longitude);
  }

/*mapa */
final Set <Marker> _markers={};
MapType _currentMapType=MapType.normal;

  @override
  Widget build(BuildContext contex){
    _locatePosition();
    _setPermissions();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.blue,
        ),
        body: Stack(
          children: <Widget>[          
            GoogleMap(
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              initialCameraPosition: CameraPosition(
                target: LatLng(10,10),
                zoom: 11.0),
              onMapCreated: (GoogleMapController controller){
                  _setPermissions();
                  _locatePosition();
                  controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: _currentLocation,zoom: 9.0)));
                },
              onLongPress: _addMarkerOnMap,  
              mapType: _currentMapType,
              markers: _markers,
              onCameraMove: _onCameraMove
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 50.0,),
                    button(_onMapTypeButtonPressed, Icons.map),
                    SizedBox(height: 16.0,),
                    button(_onReturnButtonPressed, Icons.keyboard_return),
                  ]
                )
              )
            )
          ]
        )
      )
    );
  }

  _onReturnButtonPressed(){
    Navigator.pop(context,_markers);
  }  

  _addMarkerOnMap(LatLng pos){
    setState(() {
      _markers.add(
        Marker(
          markerId:MarkerId(pos.toString()),
          position: pos,
          infoWindow:InfoWindow(
            title: 'Ubicacion',
            snippet: 'Ubicacion a escoger para el servicio'
          ),
          icon: BitmapDescriptor.defaultMarker
        )
      );      
    });
  }

  _setPermissions()async{
    Map<Permission, PermissionStatus> permissions = await [Permission.location].request();
  }   

  _onCameraMove(CameraPosition position){
    _currentLocation=position.target;
  }  

  Widget button(Function function,IconData icon){
    _setPermissions();
    return FloatingActionButton(
      //esto es para resolver el problema de There are multiple heroes that share the same tag within a subtree.
      heroTag: null,

      onPressed: function,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: Colors.blue,
      child: Icon(
        icon,
        size: 36.0,)
    );
  }

  _onMapTypeButtonPressed(){
    setState(() {
      _currentMapType=_currentMapType==MapType.normal
      ?MapType.satellite
      :MapType.normal;
    });
  }

//Cargar Srvicios de las tablas-----------------------------------------------------------

  loadServices(){
    Set <service> services={};
    
    //codigo para conseguir las coordenadas de los servicios:
    //
    //------------------------------------------------------
    
    for(service service in services){
      double hueYellow = 60.0;
      _markers.add(
        Marker(
          markerId:MarkerId(service.id),
          position: service.coord,
          infoWindow:InfoWindow(
            title: service.name,
            snippet: service.description
          ),
          //esto tengo que ver si funciona de verdad
          icon: BitmapDescriptor.defaultMarkerWithHue(hueYellow) 
        )
      );  
    }
  }

  @override
  void initState() {
    //esto puede que de problemas al ser lo primer que se inicializa?... creo?
    loadServices();

    super.initState();
  }
//----------------------------------------------------------------------------------------
}