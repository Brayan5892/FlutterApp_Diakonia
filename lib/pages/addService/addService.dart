import 'package:diakonia/objects/categories.dart';
import 'package:diakonia/pages/map.dart/map.dart';
import 'package:flutter/material.dart';

//import para el manejo de archivos E/S
import 'dart:io';

//import para cargar imagenes del dispositvo
import 'package:image_picker/image_picker.dart';

//import de google maps
import 'package:google_maps_flutter/google_maps_flutter.dart';

//import para autenticacion firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//import para guardar imagenes en firestore
import 'package:firebase_storage/firebase_storage.dart';

class addService extends StatefulWidget{
  addService():super();
  final String title="ADD SERVICE";
  final Color verdeOscuro=Color(0xff41736C),
              grisClaro=Color(0xffE6EEED),
              amarillo=Color(0xffF2BB35);
  @override
  addServiceState createState()=>addServiceState();
}

class addServiceState extends State<addService>{
  final GlobalKey<ScaffoldState>_scaffold=GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext contex){
    return MaterialApp(
      home: Scaffold(
        key: _scaffold,
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
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: widget.grisClaro,
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: _selectedCategory,
                            items: _dropdownMenuItems,
                            onChanged: onChangeDropdownItem,
                          )
                        )
                      )
                    ]
                  )
                )
              )
            ]
          )
        ),
        body: Builder(
          builder: (context) => 
          Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 16.0,),
                      TextField(
                        obscureText: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Name',
                        ),
                        controller: _nameCon,
                      ),
                      SizedBox(height: 16.0,),
                      TextField(
                        obscureText: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Price',
                        ),
                        controller: _priceCon,
                      ),
                      SizedBox(height: 16.0,),
                      TextField(
                        obscureText: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Description',
                        ),
                        controller: _descCon,
                      ),
                      SizedBox(height: 16.0,),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Expanded(
                              child:TextField(
                              obscureText: false,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Location',
                              ),
                              controller: _locCon,
                              )
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child:ElevatedButton(
                                onPressed: (){goToMap(context);},
                                child: Text('pick location'),
                                style:
                                  ElevatedButton.styleFrom(
                                  primary: widget.amarillo,
                                  onPrimary: Colors.black,
                                  ),
                                )   
                              )
                            ) 
                          ]
                        )  
                      ),                 
                      Container(
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Expanded(
                              child:ElevatedButton(
                                onPressed: (){showAlertDialog(context);},
                                child: Text('Upload Pic'),
                                style:
                                  ElevatedButton.styleFrom(
                                  primary: widget.amarillo,
                                  onPrimary: Colors.black,
                                  ),
                              )
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child:ElevatedButton(
                                onPressed: (){
                                  add();
                                  showAlertDialogExit(context);},
                                child: Text('AddService'),
                                style:
                                  ElevatedButton.styleFrom(
                                  primary: widget.amarillo,
                                  onPrimary: Colors.black,
                                  ),
                                )   
                              )
                            ) 
                          ]
                        )  
                      )
                    ]
                  )
                )
              )
            ]
          )
        )
      ),
      routes: {
        '/map':(context)=>map()//el contexto aqui puede dar problemas de materializacion
      }
    );
  }

//funcion para agregar servicio a la tabla (markers continene todos los marcadores del en el mapa)
  add()async{
    setState(() {
      _name=_nameCon.text;     
      _price=int.parse(_priceCon.text);   
      _des=_descCon.text;
      _loc=_locCon.text; 
    });
    
    var firebaseUser =  FirebaseAuth.instance.currentUser;
    //markers puede llegar null
    if(_marker!=null){
      LatLng coord=new LatLng(_marker.position.latitude,_marker.position.longitude);
    
      //codigo para agregar servicio a las tablas
      FirebaseFirestore.instance.collection('services').doc('servicio_'+firebaseUser.uid+'_'+_name).set({
        "category":_selectedCategory.toString().split('.').last,
        "coords" : new GeoPoint(coord.latitude, coord.longitude),
        "description":_des,
        "location":_loc,
        "name":_name,
        "price":_price,
        "userId":firebaseUser.uid
      });
    }else{
      //codigo para agregar servicio a las tablas
      FirebaseFirestore.instance.collection('services').doc('servicio_'+firebaseUser.uid+'_'+_name).set({
        "category":_selectedCategory.toString().split('.').last,
        "coords" : new GeoPoint(0,0),
        "description":_des,
        "location":_loc,
        "name":_name,
        "price":_price,
        "userId":firebaseUser.uid
      });
    }
    //-----------------------------------------
    if(imageFile!=null){
      var snapshot = await FirebaseStorage.instance.ref()
      .child('servicesIMG/'+firebaseUser.uid+'/'+_name)
      .putFile(imageFile);
      var downloadUrl = await snapshot.ref.getDownloadURL();
      setState(() {
      String imageUrl = downloadUrl;
      });
    }

    Navigator.pushNamed(context, '/home');
  }

  showAlertDialogExit(BuildContext context){

    // configurar el alert dialog
    AlertDialog alert = AlertDialog(
      title: Text("Service added successfully"),
      content: Text("The service "+_name+" was added succesfully"),
    );

    // mostrar el alert dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

//Navegacion a la ventana mapa-------------------------------------------------------
  Marker _marker;

  goToMap(BuildContext context)async{
    _marker=await Navigator.push(
      context,
      MaterialPageRoute(builder: (context)=>map()));
  }

//COMBO BOX CATEGORIES ---------------------------------------------------------------
  categories _selectedCategory;
  List<DropdownMenuItem<categories>> _dropdownMenuItems;

  //funcion para cambios en la seleccion del combobox
  onChangeDropdownItem(categories selectedCactegory) {
    setState(() {
      _selectedCategory = selectedCactegory;
    });
  }

  //funcion para construir el combobox
  List<DropdownMenuItem<categories>> buildDropdownMenuItems() {
    List<DropdownMenuItem<categories>> items=new List();
    DropdownMenuItem<categories> item;
    List<categories> _categories=new List();
    categories.values.forEach((category) {
    _categories.add(category);
    });
    for (categories _category in _categories) {
      item=DropdownMenuItem(
          value: _category,
          child: Text(_category.toString().split('.').last.replaceAll("_", " ")),
        );
      items.add(item);
    }
    return items;
  }  

  @override
  void initState() {
    //esto es para el combobox
    _dropdownMenuItems = buildDropdownMenuItems();
    _selectedCategory = _dropdownMenuItems[0].value;
    
    super.initState();
  }

//CAMPOS DE TEXTO ----------------------------------------------------------
  String _name,_des,_loc;  
  int _price;
  final _nameCon=TextEditingController(),
        _priceCon=TextEditingController(),
        _descCon=TextEditingController(),
        _locCon=TextEditingController();

  @override
  void dispose() {
    // Limpia el controlador cuando se termina el widget
    _nameCon.dispose();
    _priceCon.dispose();
    _descCon.dispose();
    _locCon.dispose();

    super.dispose();
  }

//CARGAR IMG DEL DISPOSITIVO -----------------------------------------------
  showAlertDialog(BuildContext context) {

    // configurar los botones
    Widget cameraButton = ElevatedButton(
      child: Text("Camera"),
      onPressed:  () {
        openCamera();
      },
    );
    Widget galleryButton = ElevatedButton(
      child: Text("Gallery"),
      onPressed:  () {
        openGallery();
      },
    );

    // configurar el alert dialog
    AlertDialog alert = AlertDialog(
      title: Text("Upload Image"),
      content: Text("Upload an Image from your device"),
      actions: [
        cameraButton,
        galleryButton,
      ],
    );

    // mostrar el alert dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  File imageFile;

  //cargar imagen de galeria
  openGallery()async{
    final picker = ImagePicker();
    var pic=await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pic!=null) {
        imageFile = File(pic.path);
      } else {
        print('No image selected.');
      }
    });
  }
  
  //cargar imagen de camara
  openCamera()async{
    final picker = ImagePicker();
    var pic=await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pic!=null) {
        imageFile = File(pic.path);
      } else {
        print('No image selected.');
      }
    });
  }
//---------------------------------------------------------------------------
}