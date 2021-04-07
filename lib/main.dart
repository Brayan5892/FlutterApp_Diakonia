import 'package:diakonia/pages/mainPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:diakonia/pages/login.dart';
import 'package:diakonia/pages/register.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
} 
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      // home:  Login(),
      initialRoute: "/",
      routes: {
        "/home":(BuildContext context)=> Main(),
        "/":(BuildContext context)=> Login(),
        "/register":(BuildContext context)=> Register(),
      },
    );
  }
}