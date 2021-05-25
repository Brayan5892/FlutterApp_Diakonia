import 'package:diakonia/presentation/pages/addService.dart';
import 'package:diakonia/presentation/pages/chatList.dart';
import 'package:diakonia/presentation/pages/homePage.dart';
import 'package:diakonia/presentation/pages/map.dart';
import 'package:diakonia/presentation/pages/profile.dart';
import 'package:diakonia/presentation/pages/profileEdit.dart';
import 'package:diakonia/presentation/pages/request.dart';
import 'package:diakonia/presentation/pages/results.dart';
import 'package:diakonia/presentation/pages/search_services.dart';
import 'package:diakonia/presentation/widgets/landing.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:diakonia/presentation/pages/login.dart';
import 'package:diakonia/presentation/pages/register.dart';


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
      
      debugShowCheckedModeBanner: false,
     
      initialRoute: "/landing",
      routes: {
        "/landing": (BuildContext context) => Landing(),
        "/home": (BuildContext context) => MyHomePage(),
        "/": (BuildContext context) => Login(),
        "/register": (BuildContext context) => Register(),
        "/search": (BuildContext context) => Search(),
        "/results": (BuildContext context) => Results(),
        "/profile": (BuildContext context) => Profile(),
        "/profileEdit": (BuildContext context) => ProfileEdit(),
        "/map": (BuildContext context) => map(),
        "/addService": (BuildContext context) => addService(),
        "/request": (BuildContext context) => Request(),
        "/chatList": (BuildContext context) => ChatList(),
      },
   
    );
  }
}
