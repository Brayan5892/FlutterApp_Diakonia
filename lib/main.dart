import 'package:diakonia/pages/addService/addService.dart';
import 'package:diakonia/pages/mainPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:diakonia/pages/login.dart';
import 'package:diakonia/pages/register.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //runApp(MyApp());
  runApp(addService());
} 
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: "/",
      routes: {
        "/home":(BuildContext context)=> Main(),
        "/":(BuildContext context)=> Login(),
        "/register":(BuildContext context)=> Register(),
      },
    );
  }
}