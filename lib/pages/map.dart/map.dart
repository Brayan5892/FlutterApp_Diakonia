import 'package:cloud_firestore/cloud_firestore.dart';
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
  final String title="MAP";
  final Color verdeOscuro=Color(0xff41736C),
              grisClaro=Color(0xffE6EEED),
              amarillo=Color(0xffF2BB35);  
  @override
  mapState createState()=>mapState();
}

class mapState extends State<map>{

/*Localizacion*/
LatLng _currentLocation;

  _locatePosition(GoogleMapController controller)async{
    Position position=await Geolocator.getCurrentPosition(desiredAccuracy:LocationAccuracy.high,forceAndroidLocationManager: true);
    _currentLocation=LatLng(position.latitude, position.longitude);
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: _currentLocation,zoom: 9.0)));
  }
/*mapa */
final Set <Marker> _markers={};
Marker _marker;
MapType _currentMapType=MapType.normal;
GoogleMapController mapController;

  @override
  Widget build(BuildContext contex){
    _setPermissions();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: widget.verdeOscuro,
          toolbarHeight: 200,
          shape: ContinuousRectangleBorder(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(67.0),
              bottomRight: Radius.circular(67.0),
            ),
          ),          
          title: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: <Widget>[
                      Text(widget.title),
                      SizedBox(height: 20.0,),
                      Container(
                        padding: const EdgeInsets.only(left: 0.0, right: 0.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: widget.grisClaro,
                        ),
                        child:TextField(
                        obscureText: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Search...',
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: (_searchServices),
                          ),
                        ),
                        controller: _searchCont,
                      ),
                      )
                    ]
                  )
                )
              )
            ]
          )
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
                zoom: 11.0
              ),
              onMapCreated: (GoogleMapController controller){
                _setPermissions();
                _locatePosition(controller);
                _loadServices();
                mapController=controller;
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
                    button(_onReturnButtonPressed, Icons.keyboard_return)
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
    Navigator.pop(context,_marker);
  }  

  _addMarkerOnMap(LatLng pos){
    setState(() {
      _marker=Marker(
        markerId:MarkerId(pos.toString()),
        position: pos,
        infoWindow:InfoWindow(
          title: 'Ubicacion',
          snippet: 'Ubicacion a escoger para el servicio'
        ),
        icon: BitmapDescriptor.defaultMarker
      );
      _markers.add(_marker);      
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
      backgroundColor: widget.amarillo,
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

//Barra de busqueda-----------------------------------------------------------------------
String _search;
final _searchCont=TextEditingController();

  _searchServices(){
    
    setState(() {
    _search=_searchCont.text;      
    });

    for(Service service in services){

      if(service.name.contains(_search)||
          service.description.contains(_search)||
          service.location.contains(_search)){
        mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: service.coord,zoom: 15.0)));
      }
    }
  }

  @override
  void dispose() {
    // Limpia el controlador cuando se termina el widget
    _searchCont.dispose();

    super.dispose();
  }
//Cargar Srvicios de las tablas-----------------------------------------------------------
List <Service> services=new List<Service>();
  
  Future _loadServices()async{//esto hay que probarlo en serio
    //codigo para conseguir las coordenadas de los servicios:

    QuerySnapshot qSnapShot=await FirebaseFirestore.instance.collection('services').get();
    qSnapShot.docs.asMap().forEach((key, value) {
      GeoPoint geoPoint = qSnapShot.docs[key]['coords'];
      Service service=new Service(
        qSnapShot.docs[key]['userId'], 
        qSnapShot.docs[key]['name'], 
        qSnapShot.docs[key]['description'], 
        qSnapShot.docs[key]['location'], 
        new LatLng(geoPoint.latitude,geoPoint.longitude),
        qSnapShot.docs[key]['price']
      );
      services.add(service);

      double hueYellow = 60.0;
      setState(() {
        _markers.add(
          Marker(
            markerId:MarkerId(service.idOwner),
            position: service.coord,
            infoWindow:InfoWindow(
              title: service.name,
              snippet: service.description
            ),
            //esto tengo que ver si funciona de verdad
            icon: BitmapDescriptor.defaultMarkerWithHue(hueYellow),
            onTap:(){
              //codigo para desplazarce a la pag servicio
              //Navigator.push(context,MaterialPageRoute(builder: (context)=>service()));
            }
          )
        );   
      }); 
    });
  }
//----------------------------------------------------------------------------------------
}