/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User with ChangeNotifier{
  String id;
  String name;
  String lastname;
  String email;
  String phone;
  String cedula;
  String password;

User({
  this.id,
  this.name,
  this.lastname,
  this.phone,
  this.cedula,
  this.password,
});

  factory User.fromFirestore(DocumentSnapshot userDoc){
    Map userData = userDoc.data;
    return User(
      id: userDoc.documentID,
      name: userData['name'],
      lastname: userData['lastname'],
      phone: userData['phone'],
      cedula: userData['cedula'],
      password: userData['password']
    );
  }
  
  void setfromFirestore(DocumentSnapshot userDoc){
    Map userData = userDoc.data;
    this.id = userDoc.documentID;
    this.cedula= userData['cedula'];
    this.name= userData['name'];
    this.lastname= userData['lastname'];
    this.password=userData['password'];
    this.phone=userData['phone'];
    notifyListeners();

  }

}
 */