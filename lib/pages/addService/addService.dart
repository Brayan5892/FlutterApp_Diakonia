import 'package:diakonia/pages/categories/categories.dart';
import 'package:flutter/material.dart';

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
        body: Stack(
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
                  ],
                ),
              ),
            )
          ] ,
        ),
      )
    );
  }

//COMBO BOX CATEGORIES ---------------------------------------------------------------
  String _selectedCategory;
  List<DropdownMenuItem<String>> _dropdownMenuItems;

  //funcion para cambios en la seleccion del combobox
  onChangeDropdownItem(String selectedCactegory) {
    setState(() {
      _selectedCategory = selectedCactegory;
    });
  }

  //funcion para construir el combobox
  List<DropdownMenuItem<String>> buildDropdownMenuItems(List<String> _categories) {
    List<DropdownMenuItem<String>> items=new List();
    DropdownMenuItem<String> item=DropdownMenuItem(
      value: 'Categories',
      child: Text('Categories'),
    );
    items.add(item);    
    for (String _category in _categories) {
      item=DropdownMenuItem(
          value: _category,
          child: Text(_category),
        );
      items.add(item);
    }
    return items;
  }  

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(getCategories());
    _selectedCategory = _dropdownMenuItems[0].value;
    super.initState();
  }
}

/*
import 'package:flutter/material.dart';
 
class DropDown extends StatefulWidget {
  DropDown() : super();
 
  final String title = "DropDown Demo";
 
  @override
  DropDownState createState() => DropDownState();
}
 -----------------------------------------------------------------------------
class Company {
  int id;
  String name;
 
  Company(this.id, this.name);
 
  static List<Company> getCompanies() {
    return <Company>[
      Company(1, 'Apple'),
      Company(2, 'Google'),
      Company(3, 'Samsung'),
      Company(4, 'Sony'),
      Company(5, 'LG'),
    ];
  }
}
 
class DropDownState extends State<DropDown> {
  //
  List<Company> _companies = Company.getCompanies();
  List<DropdownMenuItem<Company>> _dropdownMenuItems;
  Company _selectedCompany;
 
  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_companies);
    _selectedCompany = _dropdownMenuItems[0].value;
    super.initState();
  }
 
  List<DropdownMenuItem<Company>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<Company>> items = List();
    for (Company company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.name),
        ),
      );
    }
    return items;
  }
 
  onChangeDropdownItem(Company selectedCompany) {
    setState(() {
      _selectedCompany = selectedCompany;
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("DropDown Button Example"),
        ),
        body: new Container(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Select a company"),
                SizedBox(
                  height: 20.0,
                ),
                DropdownButton(
                  value: _selectedCompany,
                  items: _dropdownMenuItems,
                  onChanged: onChangeDropdownItem,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text('Selected: ${_selectedCompany.name}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}*/