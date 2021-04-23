/*import de google maps */
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Service{
  LatLng coord;
  int price;
  String idOwner,name,description,location;

  Service(String id,String name,String description,String location,LatLng coord,int price){
  this.coord=coord;  
  this.idOwner=id;
  this.name=name;
  this.description=description;
  this.location=location;
  this.price=price;
  }
}