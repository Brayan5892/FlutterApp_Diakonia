import 'package:diakonia/presentation/pages/homePage.dart';
import 'package:diakonia/presentation/pages/request.dart';
import 'package:flutter/material.dart';

class RequestAdd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      double width = MediaQuery.of(context).size.width;
   double height = MediaQuery.of(context).size.height;
    return MaterialApp(
       debugShowCheckedModeBanner: false,
       home: Scaffold(
         appBar: AppBar(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.home_outlined,
                      size: 35,
                      color: Colors.white,
                    ),
                    onPressed: () {
                           Navigator.push(
                          context,
                          new MaterialPageRoute(
                          builder: (context) => new Request(),
                          ),
                      );
                    }),
              ],
            ),
             backgroundColor:
                Color(int.parse("#41736C".replaceAll('#', '0xff'))),
            toolbarHeight: 200.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(67),
                    bottomLeft: Radius.circular(67))),
                    title: Column(
                         
                      children: [
                         Padding(
                           padding: const EdgeInsets.only(right:10, left: 60),
                           child: Text(
                  '  REQUEST  ',
                  style: TextStyle(fontSize: 25),
                ),
                         ),
                      ],
                    ),
         ),
         body: Stack(
      
            fit: StackFit.expand,
            children: [
              Positioned(
                top: 17,
                bottom: 250,
                
            left: 45,
            right: 45,
                 child: Container(
               
            
                decoration: BoxDecoration(
                  color: Color(int.parse("#E6EEED".replaceAll('#', '0xff'))),
                 borderRadius: BorderRadius.circular(55),
                ),
                  
                   child: Container(
                     padding: EdgeInsets.only(top:85,left: 0, bottom: 5),
                     child: Column(
                       children: [
                         Center(
                           child: Text (
                               'SUCCESFUL REQUEST',
                        style: TextStyle(
                            
                            color: Colors.black,
                            fontFamily: 'Nunito',
                            fontSize: 18,
                        ),
                           ),
                         ),
                       ],
                     ),
                     
                      ),
              ),
                ),
                Positioned(
                 top: 210,
                 width: width,
                  child: Container(
                      height: height * 0.4,
                   child: Image.asset("assets/images/add.jpeg"),
                  )
                )
            ],
          
         ),

         ),
    );
  }
}