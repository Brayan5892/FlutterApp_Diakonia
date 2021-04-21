import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var name=" ", telephone=" ", lastname=" ", email=" ", description=" ";
  var firebaseUser =  FirebaseAuth.instance.currentUser;
  List<DocumentSnapshot> services=[];
  void initState() { 
    super.initState();
    getUser();
    servicesById();
  }

  Future<void> getUser() async{
      
      var document = await FirebaseFirestore.instance.collection('users').doc(firebaseUser.uid).get(); 

      setState(() {
        email=document.data()['email'];
        name=document.data()['name'];
        lastname=document.data()['lastname'];
        telephone=document.data()['phone'];
        description=document.data()['description'];
      });
    
  }

   void servicesById() async {
      var result = await FirebaseFirestore.instance
          .collection('services')
          .where('userId', isEqualTo: 'gIwFCCeDIXZbAqAbkI6IM8Uf0d12')
          .get();
         
          services = result.docs;
         
  }

 
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
                icon: Icon(Icons.home_outlined,size: 35,color: Colors.black,),
                onPressed: (){
                     Navigator.of(context).pushNamed("/home");
                   }
                ),
        ),
        body: Column(
          children: [
            Expanded(
                child:Container(
                margin: EdgeInsets.only(top:30),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(67),topLeft: Radius.circular(67)),
                  color: Color(int.parse("#41736C".replaceAll('#', '0xff'))),
                ),
                child: Column(
                  children: [

                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  ),),

                              Text(telephone,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  ),),
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(0),
                                    child: Icon(Icons.account_circle_outlined, size: 90,color:Colors.white,
                                    )
                                    ),
                                  Container(
                                    padding: const EdgeInsets.all(0.0),
                                    margin: EdgeInsets.only(top:40),
                                    child: IconButton(
                                        icon: Icon(Icons.edit_outlined,size: 20,color: Colors.white,), 
                                        onPressed: null
                                ),
                                  ),
                                ],
                              ),
                             
                            ],
                          ),
                         
                          
                        ],
                        
                        
                        
                        ),
                    ),
                    Expanded(
                       child: Container(  
                          margin: EdgeInsets.symmetric(horizontal:10,vertical:20),
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(33)),
                              color: Color(int.parse("#E6EEED".replaceAll('#', '0xff'))),
                          ),
                          child: Column(
                            children:[
                              Container(
                                margin: EdgeInsets.only(top:15),
                                child: Text('ABOUT ME', 
                                style: TextStyle(fontSize: 25, color: Colors.black),)
                                ),
                              ConstrainedBox(
                                 constraints: BoxConstraints(maxWidth: 350),
                                 child: Container(
                                 padding: EdgeInsets.all(10),
                                 margin: EdgeInsets.only(top:15),
                                 
                                 decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    color: Colors.white,
                                 ),
                                 child: Text(description, 
                                 style: TextStyle(
                                   fontSize: 15, 
                                   color: Colors.black),           
                                   )
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top:15),
                                child: Text('Current services', 
                                style: TextStyle(fontSize: 20, color: Colors.black),)
                                ),
                              Container(
                              height: 50,
                              margin: EdgeInsets.only(top:20),
                              padding: EdgeInsets.symmetric(horizontal:20),
                              child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: services.length,
                              itemBuilder: (BuildContext context, int index) {
                                final service = services[index].data();
                                return Card(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                   color: Color(int.parse("#F2BB35".replaceAll('#', '0xff'))),
                                   child: Container(
                                    padding: EdgeInsets.all(10),
                                    
                                    child: Text(service['name'])
                                    ),
                                );
                              },
                            )),
                             Container(
                                margin: EdgeInsets.only(top:15),
                                child: Text('Certificates', 
                                style: TextStyle(fontSize: 20, color: Colors.black),)
                             ),



                            ],
                          ),
                      ),
                    ),
                   



                    
                  ],
                ),
              
              ),
            ),
          ],
        ),
      ),
    );
  }
}