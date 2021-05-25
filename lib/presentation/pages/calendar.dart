import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diakonia/presentation/pages/request.dart';
import 'package:diakonia/presentation/pages/requestAdd.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Calendar extends StatefulWidget {
  String name;
  var nameUser;
  String userServiceid;
  String imgService;
  Calendar(this.name, this.nameUser, this.userServiceid, this.imgService);
  @override
  _CalendarState createState() => _CalendarState();

}

class _CalendarState extends State<Calendar> {
  String name;
  var nameUser;
  String userServiceid;
 String imgService;
  void initState() {
    super.initState();
    name = widget.name;
    nameUser = widget.nameUser;  
    userServiceid = widget.userServiceid;  
    imgService = widget.imgService;
  }
  
    DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
  @override
 Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
   double height = MediaQuery.of(context).size.height;
    return MaterialApp(
       debugShowCheckedModeBanner: false,
         title: 'Material App',
        
      home: Scaffold(
         appBar: AppBar(
           backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
          actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              icon: Icon(
                Icons.account_circle_outlined, 
                color: Color(int.parse("#F2BB35".replaceAll('#', '0xff'))),
                
                ),
                onPressed: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new Request(),
                ),
              );
            },
            ),
            
          ),
        
        ],

        ),
        body: Stack(
        fit: StackFit.expand,
        children: [
           
           
              Positioned(
              bottom: 0,
              left: 0,
              right: 0,
         
              child: Container(
               
                height: height * 0.6,
                decoration: BoxDecoration(
                  color: Color(int.parse("#41736C".replaceAll('#', '0xff'))),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                  
                   child: Container(
                     padding: EdgeInsets.only(top:25,left: 50),
                     child: Column(
                       children: [
                         Text (
                             '',
                        style: TextStyle(
                          
                          color: Colors.black,
                          fontFamily: 'Nunito',
                          fontSize: 28,
                        ),
                         ),
                       ],
                     ),
                     
                      ),
              ),
              
                 ),
           
            Positioned(
                    
            bottom: 20,
            left: 25,
            right: 25,
            child: Container(
              height: height * 0.5,
              width: width * 0.9,
              decoration: BoxDecoration(
                color:  Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                  
                child: Column(
                  
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    Container(
                     padding: EdgeInsets.only(top:5,left: 25, bottom: 25),
                     child: Column(
                       children: [
                         Text (
                             'Usted está solicitando el servicio: '+name,
                        style: TextStyle(
                          
                          color: Colors.black,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                         ),
                       ],
                     ),
                     
                      ),
                    Text(
                      'Prestador de servicio',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Nunito',
                        
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    
                    Material(
                      
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(25),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Color(int.parse("#D8A07D".replaceAll('#', '0xff'))),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0 ),
                          child: Text(
                            nameUser,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      children:  [
                       
                         
                         Center(
                           child: Column(
                                 mainAxisSize: MainAxisSize.min,
                             children: [
                               Container(
                                 padding: EdgeInsets.only(left:60, top:20, ),
                                 child: OutlinedButton(
                                  // elevation: 6,
                                  // borderRadius: BorderRadius.circular(25),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color:  Color(int.parse("#F2BB35".replaceAll('#', '0xff'))),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(top:20, bottom:20, left:70, right: 70),
                                      child: Text(
                                        '  Request ',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontFamily: 'Nunito'),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                 saveRequest(nameUser, name, userServiceid, selectedDate, context, imgService);
                                    },
                        ),
                               ),
                             ],
                           ),
                         ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
           Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "${selectedDate.toLocal()}".split(' ')[0],
              style: TextStyle(fontSize: 55, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              onPressed: () => _selectDate(context),
              child: Text(
                'Select date',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              color: Color(int.parse("#F2BB35".replaceAll('#', '0xff'))),
            ),
          ],
        ),
        ],
  
        ),
    
      ),
    );
  }
}

 Future <void> saveRequest(name, descriptionService, nameUser, selectedDate, context,imgService) async{
      var firebaseUser =  FirebaseAuth.instance.currentUser;
     // var col = await FirebaseFirestore.instance.collection('request');
      var document = await FirebaseFirestore.instance
      .collection('users')
      .doc(firebaseUser.uid)
      .collection('request').doc()
      .set({
          'nameService': name,
          'infoService': descriptionService,
          'namePrestadorServicio': nameUser,
          'dateGetService': selectedDate,
          'imgURL':imgService
      })
      .then((value) => 
         Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new RequestAdd(),
                ),
              )
      )
                    .catchError((error) => print("Failed to add request: $error"));
      
       
}