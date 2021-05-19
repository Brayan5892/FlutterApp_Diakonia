import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diakonia/presentation/pages/calendar.dart';
import 'package:diakonia/presentation/pages/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ServiceInfo extends StatefulWidget {
  final DocumentSnapshot service;
  ServiceInfo(this.service);
  @override
  _ServiceInfoState createState() => _ServiceInfoState();
}
 
class _ServiceInfoState extends State<ServiceInfo> {
  DocumentSnapshot service;
  String name='';
  String description='';
  String userServiceid='';
    var nameUser=" ", telephone=" ", lastname=" ",  descriptionUser=" ", profilePicture=" ";
void initState() {
    super.initState();
     
    service = widget.service;
    setState(() {
       
          name=service.data()['name'];
          description =service.data()['description'];
          userServiceid= service.data()['userId'];
        });
        getUser();
  }
  
   Future<void> getUser() async{
      
      var document = await FirebaseFirestore.instance.collection('users').doc(userServiceid).get(); 
      
      setState(() {
       
        nameUser=document.data()['name'];
        lastname=document.data()['lastname'];
        telephone=document.data()['phone'];
        descriptionUser=document.data()['description'];
        profilePicture=document.data()['profilePicture'];
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
                          builder: (context) => new Profile(),
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
            ),
               ),
             Column(
            children: [
              Text(
                name,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 45,
                ),
              ),
            ],
          ), 
            Positioned(
            top: 0,
            left: 10,
            
            child: Container(
              width: width ,
              child: Hero(
                tag: 'shadow$name',
                child: Image.asset(
                  "assets/images/pana.png",
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
          ),
            Positioned(
            top: 0,
            left: 0,
           
            child: Container(
              width: width ,
              child: Hero(tag: name, 
              child: Image.asset("assets/images/pana.png")),
            ),
          ),
              Positioned(
            bottom: 20,
            left: 60,
            child: Container(
              height: height * 0.4,
              width: width * 0.7,
              decoration: BoxDecoration(
                color:  Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      nameUser,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Nunito',
                        fontSize: 28,
                      ),
                    ),
                    Text(
                      telephone,
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
                            description,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Nunito',
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
                        
                        Padding(
                            padding: EdgeInsets.only(top:20, right: 20),
                            
                          child: OutlinedButton(
                            // elevation: 6,
                            // borderRadius: BorderRadius.circular(25),
                            child: Container(
                              decoration: BoxDecoration(
                                color:  Color(int.parse("#F2BB35".replaceAll('#', '0xff'))),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Text(
                                  'Talk',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontFamily: 'Nunito'),
                                ),
                              ),
                            ),
                               onPressed: () {
                                Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                    builder: (context) => new Profile(),
                                  ),
                                );
                              },
                          ),
                        ),
                         
                         Padding(
                           padding: EdgeInsets.only(left:0, top:20, right: 10),
                           child: OutlinedButton(
                            // elevation: 6,
                            // borderRadius: BorderRadius.circular(25),
                            child: Container(
                              decoration: BoxDecoration(
                                color:  Color(int.parse("#F2BB35".replaceAll('#', '0xff'))),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Text(
                                  'Request',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontFamily: 'Nunito'),
                                ),
                              ),
                            ),
                            onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => Calendar(name, nameUser, userServiceid),
                                                      
                                  ),
                                ) ;
                              },
                        ),
                         ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
           ]
          
        ),
           
          ),
        
             
         
           
          
      
    );
  }
}