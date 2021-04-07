import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


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

  var pass;
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
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
     formKey.currentState.save();
     auth.createUserWithEmailAndPassword(email: _email, password: _password).then((_){
          Navigator.of(context).pushNamed("/");
    });
  }
    


  }
}