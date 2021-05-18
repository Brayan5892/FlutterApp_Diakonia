import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloudinary_public/cloudinary_public.dart';



class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final cloudinary = CloudinaryPublic('dfm8d2pyf', 'zjtb4tq2', cache: false);
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  var name=" ", telephone=" ", lastname=" ", email=" ", description=" ", profilePicture=" ";
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
        profilePicture=document.data()['profilePicture'];
      });
    
  }

   void servicesById() async {
      var result = await FirebaseFirestore.instance
          .collection('services')
          .where('userId', isEqualTo: firebaseUser.uid)
          .get();
          services = result.docs;
         
  }

 
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
                icon: Icon(
                  Icons.home_outlined,
                  size: 35,
                  color: Colors.black,),
                onPressed: (){
                     Navigator.of(context).pushNamed("/home");
                   }
                ),
                     actions: [
          IconButton(
            key: Key("settings"),
            icon: Icon(
              Icons.settings,
              size: 30,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed("/profileEdit");
            },
          ),
        ],
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
                                        Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Color.fromARGB(255, 242, 187, 53)),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: profilePicture==null ? NetworkImage(
                                'https://pm1.narvii.com/6521/328d0ecf99dd0a94976de54ac20e3f0ded2219e0_hq.jpg',
                              ) : NetworkImage(profilePicture),
                            )
                          ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 2,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Color.fromARGB(255, 242, 187, 53),
                          ),
                          child: InkWell(
                            onTap: (){
                              showModalBottomSheet(
                                context: context, 
                                builder: ((builder) => bottomSheet()),
                                );
                            },
                         
                          child: IconButton(
                            key: Key("editImage"),
                            icon: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                            onPressed: null,
                          ),
                          ), 
                        )),
                          ],
                        ),
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



  Widget bottomSheet(){
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose profile photo",
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            
            TextButton.icon(
              key: Key("camera"),
              icon: Icon(
                Icons.camera,
                color: Color.fromARGB(255, 65, 115, 108),
                ),
              onPressed: () async {
                      await takePhoto(ImageSource.camera);
                      try {
                        CloudinaryResponse response = await cloudinary.uploadFile(
                        CloudinaryFile.fromFile(_imageFile.path, resourceType: CloudinaryResourceType.Image),
                      );

                        print(response.secureUrl);

                        var firebaseUser =  FirebaseAuth.instance.currentUser;

                        FirebaseFirestore.instance.collection("users").doc(firebaseUser.uid).update({
                          "profilePicture": response.secureUrl,
                        }).then((_) {
                          print("Se ha guardado su foto satisfactoriamente");
                          setState(() {
                            profilePicture=response.secureUrl;
                          });
                        });

                    } on CloudinaryException catch (e) {
                      print(e.message);
                      print(e.request);
                    }
              }, 

               label: Text("Camera"),
               ),
              TextButton.icon(
                key: Key("gallery"),
                icon: Icon(
                Icons.image, 
                color: Color.fromARGB(255, 65, 115, 108),
                ),
              onPressed: () async {
                await takePhoto(ImageSource.gallery);
                       try {
                      
                      CloudinaryResponse response = await cloudinary.uploadFile(
                      CloudinaryFile.fromFile(_imageFile.path, resourceType: CloudinaryResourceType.Image),
                      );
                      
                        print(response.secureUrl);
                    } on CloudinaryException catch (e) {
                      print(e.message);
                      print(e.request);
                         
                    }
              }, 
               label: Text("Gallery"),
               ),
          ],)
        ],
      ),
    );
  }

  takePhoto(ImageSource source) async{
  
    final pickedFile = await _picker.getImage(
      source: source,
    );
   
    setState(() {
      _imageFile = pickedFile;
    });
    
  }
}