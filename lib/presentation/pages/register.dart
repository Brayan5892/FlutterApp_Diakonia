import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// Import the firebase_core and cloud_firestore plugin
import 'package:cloud_firestore/cloud_firestore.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  String _email;
  String _password;
  String _confirmPassword;
   
  final auth = FirebaseAuth.instance;

  final formKey = GlobalKey<FormState>();
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  var pass;
  @override
  Widget build(BuildContext context) {
 

   return MaterialApp(
     debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/fondoRegister.png"),
            fit: BoxFit.cover,
          ),
        ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
             child: Column(
               mainAxisAlignment: MainAxisAlignment.start,
               
               children: <Widget>[
                 Container(
                   margin: EdgeInsets.only(top:30, bottom: 60),
                  child: Image.asset("assets/images/logoAmarillo.png"),
                  ),
               
                 Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                     Container(
                        margin: EdgeInsets.only(bottom:9.0),
                         child:  Text('Create your account',
                         style: TextStyle(fontStyle: FontStyle.italic),
                         
                         ),
                     ),
                   ],
                 ),
                  
                 Container(
                     height: 55,
                     margin: EdgeInsets.only(top:8.0, bottom: 8.0),
                     
                     child: TextFormField(
                       onSaved:  (value){
                             _email = value;
                       }, 
                       validator: (value){
                        if(value.isEmpty){
                          return "Please enter the email";
                        }else{
                          return null;
                        }
                        
                       },
                       key: Key("emailRegister"),
                       decoration: InputDecoration(
                          fillColor: Colors.white, filled: true,
                         labelText: "Email:",
                         border: OutlineInputBorder(borderRadius: const BorderRadius.all(
                           const Radius.circular(30.0),
                         ),
                         borderSide: BorderSide(
                               width: 0, 
                               style: BorderStyle.none,
                         ),
                         )
                         ),
                       )
                     ),
                     Container(
                       height: 55,
                       margin: EdgeInsets.only(top:8.0, bottom: 8.0),
                      
                       child: TextFormField(
                         obscureText: true,
                         onSaved:(value){
                             _password = value;
                          },  
                          validator: (value){
                             pass = value;
                            if(value.isEmpty){
                              return "Please enter the password";
                            }else{
                              return null;
                            }
            
                          },
                          key: Key("passwordRegister"),
                         decoration: InputDecoration(
                         fillColor: Colors.white, filled: true,
                         labelText: "Password:",
                         border: OutlineInputBorder(borderRadius: const BorderRadius.all(
                           const Radius.circular(30.0)
                         ),
                          borderSide: BorderSide(
                               width: 0, 
                               style: BorderStyle.none,
                         ),
                         )
                         ),
                       )
                     ),
                      Container(
                       height: 55,
                       margin: EdgeInsets.only(top:8.0, bottom: 8.0),
                    
                       child: TextFormField(
                         obscureText: true,
                       textInputAction: TextInputAction.send,
                       onSaved:  (value){
                        _confirmPassword = value;
                       },  
                       validator: (value){
                        if(value.isEmpty){
                          return "Please enter the password";
                        }else if (value != pass) {
                          return "Password must be same as above";
                        } else{
                          return null;
                        }
                        
                       },
                       key: Key("confirmRegister"),
                       decoration: InputDecoration(
                        
                         fillColor: Colors.white, filled: true,
                         labelText: "Confirm Password:",
                         border: OutlineInputBorder(borderRadius: const BorderRadius.all(
                           const Radius.circular(30.0)
                         ),
                          borderSide: BorderSide(
                               width: 0, 
                               style: BorderStyle.none,
                         ),
                         )
                         ),
                       )
                     ),
                     Container(
                       height: 50,
                       width: 375,
                       margin: EdgeInsets.only(top:30.0),
                       child: OutlinedButton(
                         onPressed: (){
                           _signuP();
                         },
                         child: Text(
                           "Sign Up",
                           style: TextStyle(color: Colors.white,
                           fontSize:20),
                         ),
                         style: OutlinedButton.styleFrom(
                           shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                           backgroundColor: Color(int.parse("#41736C".replaceAll('#', '0xff')))
                           
                         ),
                         ),
                     ),
                     Spacer(),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         Container(
                           margin:EdgeInsets.only(bottom:20, top:15),
                           child: IconButton(
                             icon:Icon(Icons.arrow_back, size:50,),
                             onPressed: (){
                               Navigator.of(context).pushNamed("/");
                             },
                           ),
                         ),
                       ],
                     ),
               ],
               ),
              ),
          ),
        )
      ),
    );
  }

  void _signuP() async {
      if(formKey.currentState.validate()){
          try {
            formKey.currentState.save();
            UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _email,
            password: _password
          );
          var firebaseUser =  FirebaseAuth.instance.currentUser;
          
          users.doc(firebaseUser.uid).set({
                      'email': _email, 
                      'password': _password,
                    }).then((value) => print("User Added"))
                    .catchError((error) => print("Failed to add user: $error"));

                          Navigator.of(context).pushNamed("/");

                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              _showErrorDialog('La contraseña es poco segura');
                            } else if (e.code == 'email-already-in-use') {
                            _showErrorDialog('El correo ya está en uso');
                            }
                          } catch (e) {
                            print(e);
                          }
                      }
  }
                    void _showErrorDialog(String msg){
                      showDialog(
                          context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text('An Error Occured'),
                          content: Text(msg),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Okay'),
                              onPressed: (){
                                Navigator.of(ctx).pop();
                              },
                            )
                          ],
                        )
                      );
                    }
              

                Future<void> addUser() {
                    // Call the user's CollectionReference to add a new user
                    return 
                    users.add({
                      'email': _email, // John Doe,
                      'password': _password, // 42
                    })
                    .then((value) => print("User Added"))
                    .catchError((error) => print("Failed to add user: $error"));
              } 
                   
}