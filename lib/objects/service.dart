/*import de google maps */
import 'package:google_maps_flutter/google_maps_flutter.dart';

class service{
  LatLng coord;
  String id,name,description,location;

  service(String id,String name,String description,String location,LatLng coord){
  this.coord=coord;  
  this.id=id;
  this.name=name;
  this.description=description;
  this.location=location;
  }
}