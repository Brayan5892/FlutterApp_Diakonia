import 'package:diakonia/presentation/pages/addService.dart';
<<<<<<< HEAD
import 'package:diakonia/presentation/pages/chatList.dart';
import 'package:diakonia/presentation/pages/chatRoom.dart';
=======
import 'package:diakonia/presentation/pages/calendar.dart';
>>>>>>> karol
import 'package:diakonia/presentation/pages/homePage.dart';
import 'package:diakonia/presentation/pages/map.dart';
import 'package:diakonia/presentation/pages/profile.dart';
import 'package:diakonia/presentation/pages/profileEdit.dart';
import 'package:diakonia/presentation/pages/request.dart';
import 'package:diakonia/presentation/pages/results.dart';
import 'package:diakonia/presentation/pages/search_services.dart';
import 'package:diakonia/presentation/pages/serviceInfo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:diakonia/presentation/pages/login.dart';
import 'package:diakonia/presentation/pages/register.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get.dart';
import 'data/models/getX_controller.dart';


void main() async { 

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
} 
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Material App',
      
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
<<<<<<< HEAD
        "/chatList": (BuildContext context) => ChatList(),
=======
        "/request": (BuildContext context) => Request(),
      //   "/calendar": (BuildContext context) => Calendar(),
>>>>>>> karol
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