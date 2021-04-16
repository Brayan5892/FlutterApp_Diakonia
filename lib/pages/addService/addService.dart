import 'package:diakonia/pages/categories/categories.dart';
import 'package:flutter/material.dart';

//import para el manejo de archivos E/S
import 'dart:io';

//import para cargar imagenes del dispositvo
import 'package:image_picker/image_picker.dart';

class addService extends StatefulWidget{
  addService():super();
  final String title="Add Service";
  @override
  addServiceState createState()=>addServiceState();
}

class addServiceState extends State<addService>{
  @override
  Widget build(BuildContext contex){
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.blue,
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
                      DropdownButton(
                        value: _selectedCategory,
                        items: _dropdownMenuItems,
                        onChanged: onChangeDropdownItem,
                      ),
                      SizedBox(height: 16.0,),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Name',
                        ),
                        controller: _nameCon,
                      ),
                      SizedBox(height: 16.0,),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Price',
                        ),
                        controller: _priceCon,
                      ),
                      SizedBox(height: 16.0,),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Description',
                        ),
                        controller: _descCon,
                      ),
                      SizedBox(height: 16.0,),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Location',
                        ),
                        controller: _locCon,
                      ),
                      SizedBox(height: 16.0,),
                      ElevatedButton(
                        onPressed: (){showAlertDialog(context);},
                        child: Text('Upload'),
                      ),
                      SizedBox(height: 16.0,),
                      ElevatedButton(
                        onPressed: (){
                          setState(() {
                            _name=_nameCon.text;     
                            _price=_priceCon.text;   
                            _des=_descCon.text;
                            _loc=_locCon.text; 
                          });
                        },
                        child: Text('Add'),
                      ),
                    ]
                  )
                )
              )
            ]
          )
        )
      )
    );
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
          child: Text(_category.toString().split('.').last),
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
  String _name,_price,_des,_loc;  
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
      onPressed:  () {openCamera();},
    );
    Widget galleryButton = ElevatedButton(
      child: Text("Gallery"),
      onPressed:  () {openGallery();},
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