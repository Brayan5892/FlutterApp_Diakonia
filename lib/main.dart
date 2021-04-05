import 'package:flutter/material.dart';
import 'package:diakonia/pages/login.dart';
import 'package:diakonia/pages/register.dart';


void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      // home:  Login(),
      initialRoute: "/",
      routes: {
        "/":(BuildContext context)=> Login(),
        "/register":(BuildContext context)=> Register(),
      },
    );
  }
}