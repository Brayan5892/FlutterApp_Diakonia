import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileEdit extends StatefulWidget {
  ProfileEdit({Key key}) : super(key: key);

  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
    final formKey = GlobalKey<FormState>();
    var editName, editLastName, editPhone;
    


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
       appBar: AppBar(
        title: Text('Profile edit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
          child: Form(
           key: formKey,
           child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
             children: <Widget>[
               Container(
                     height: 55,
                     margin: EdgeInsets.only(top:8.0, bottom: 8.0),
                     child: TextFormField(
                       onSaved:  (value){
                             editName = value;
                       }, 
                        validator: (value){
                          if(value.isEmpty){
                            return "Please enter the name";
                          }else{
                            return null;
                          }
                       },
                       decoration: InputDecoration(
                          fillColor: Colors.white, filled: true,
                         labelText: "Name:",
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
                     margin: EdgeInsets.only(top:8.0,bottom: 8.0),
                     child: TextFormField(
                       onSaved:  (value){
                             editLastName = value;
                       }, 
                       validator: (value){
                          if(value.isEmpty){
                            return "Please enter the last name";
                          }else{
                            return null;
                          }
                       },
                       decoration: InputDecoration(
                          fillColor: Colors.white, filled: true,
                         labelText: "LastName:",
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
                       onSaved:  (value){
                             editPhone = value;
                       }, 
                       validator: (value){
                          if(value.isEmpty){
                            return "Please enter the phone";
                          }else{
                            return null;
                          }
                       },
                       decoration: InputDecoration(
                          fillColor: Colors.white, filled: true,
                         labelText: "Phone:",
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
                       height: 50,
                       width: 375,
                       margin: EdgeInsets.only(top:30.0),
                       child: OutlinedButton(
                         onPressed: (){
                           _save();
                         },
                         child: Text(
                           "Save",
                           style: TextStyle(color: Colors.black,
                           fontSize:20),
                         ),
                         style: OutlinedButton.styleFrom(
                           shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                           backgroundColor: Color(int.parse("#F2BB35".replaceAll('#', '0xff')))
                           
                         ),
                         ),
                     ),



            ],
           ),
        ),
      ),
    
    );
  }
  
   
  void _save(){

    if(formKey.currentState.validate()){
      try {
          formKey.currentState.save();
          var firebaseUser =  FirebaseAuth.instance.currentUser;
          FirebaseFirestore.instance.collection("users").doc(firebaseUser.uid).update({
            "name": editName,
            "lastname": editLastName,
            "phone": editPhone,
          }).then((_) {
            _showErrorDialog("Se han guardado sus cambios satisfactoriamente!");
          });
      } catch (e) {
        print(e);
      }
    }

  }


       void _showErrorDialog(String msg){
                      showDialog(
                          context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text('Saved'),
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
}