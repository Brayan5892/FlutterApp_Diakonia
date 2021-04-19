import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var name=" ", telephone=" ", lastname=" ", email=" ";
  var firebaseUser =  FirebaseAuth.instance.currentUser;
  List<DocumentSnapshot> services=[];
  void initState() { 
    super.initState();
    getUser();
  }

  Future<void> getUser() async{
      
      var document = await FirebaseFirestore.instance.collection('users').doc(firebaseUser.uid).get(); 

      setState(() {
        email=document.data()['email'];
        name=document.data()['name'];
        lastname=document.data()['lastname'];
        telephone=document.data()['phone'];
      });
    
  }

   void servicesById() async {
      var result = await FirebaseFirestore.instance
          .collection('services')
          .where('UserId', isEqualTo: firebaseUser.uid)
          .get();
          services = result.docs;
  }

 
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: Center(
          child: Container(
            child: ListView(
              children: <Widget>[
                Card(
                  child: email == null ? Text("Correo: "+"NULL"):Text("Correo: "+email),
                ),
                Card(
                  child: name == null ? Text("Nombre: "+"NULL"):Text("Nombres: "+name),
                ),
                Card(
                  child: lastname == null ? Text("Apellido: "+"NULL"):Text("Apellidos: "+lastname),
                ),
                Card(
                  child: telephone == null ? Text("Telefono: "+"NULL"):Text("Telefono: "+telephone),
                ),
                




                OutlinedButton(
                         onPressed: (){
                           Navigator.of(context).pushNamed("/profileEdit");
                         },
                         child: Text(
                           "Edit",
                         ),
                        
                         )
              ],
            ),
          ),
        ),
      ),
    );
  }
}