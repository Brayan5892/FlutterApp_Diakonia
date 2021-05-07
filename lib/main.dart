import 'package:diakonia/pages/addService/addService.dart';
import 'package:diakonia/pages/homePage.dart';
import 'package:diakonia/pages/mainPage.dart';
import 'package:diakonia/pages/map.dart/map.dart';
import 'package:diakonia/pages/profile.dart';
import 'package:diakonia/pages/profileEdit.dart';
import 'package:diakonia/pages/results.dart';
import 'package:diakonia/pages/search_services.dart';
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
     // home: addService(),
        debugShowCheckedModeBanner: false,
     
      initialRoute: "/",
      routes: {
        "/home": (BuildContext context) => MyHomePage(),
        "/": (BuildContext context) => Login(),
        "/register": (BuildContext context) => Register(),
        "/search": (BuildContext context) => Search(),
        "/results": (BuildContext context) => Results(),
        "/profile": (BuildContext context) => Profile(),
        "/profileEdit": (BuildContext context) => ProfileEdit(),
        "/map": (BuildContext context) => map(),
        "/addService": (BuildContext context) => addService(),
      },
      //para pasar datos entre pantallas/routes
      // onGenerateRoute: (RouteSettings settings){
      //   final List<String>pathElements=settings.name.split('/');
      
      //   if(pathElements[0]!=''){
      //     return null;
      //   }
        
      //   switch(pathElements[1]){
      //     case 'home':
      //       return MaterialPageRoute(
      //         builder: (BuildContext context)=>Main());
      //     case 'register':
      //       return MaterialPageRoute(
      //         builder: (BuildContext context)=>Register());
      //     case 'map':
      //       return MaterialPageRoute(
      //         builder: (BuildContext context)=>map()); 
      //     case 'addService':
      //       return MaterialPageRoute(
      //         builder: (BuildContext context)=>addService());
      //     case 'login':
      //       return MaterialPageRoute(
      //         builder: (BuildContext context)=>Login());  
      //     default:
      //       return null;                           
      //   }
      // },
    );
  }
}