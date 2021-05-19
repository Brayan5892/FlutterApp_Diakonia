import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diakonia/presentation/pages/homePage.dart';
import 'package:diakonia/presentation/pages/serviceInfo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Request extends StatefulWidget {
  @override
  _RequestState createState() => _RequestState();
}

class _RequestState extends State<Request> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
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
                          builder: (context) => new MyHomePage(),
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
                  '  REQUEST LIST ',
                  style: TextStyle(fontSize: 25),
                ),
                         ),
                      ],
                    ),
         ),
         body: Column(
           children: [

               Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  height: 20.0,
               )

             ,
             Container(
               width: 350,
               height: 370,
               child: FutureBuilder<QuerySnapshot>(
                   future:
                      FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).collection('request').get(),
                   // ignore: missing_return
                   builder: (context, snapshot) {
                     if (snapshot.hasData) {
                       final List<DocumentSnapshot> documents =
                           snapshot.data.docs;
                       return ListView(
                           //Service card
                            children: documents
                               .map((doc) => Card(
                                     child: Container(
                                       color: Color(int.parse(
                                           "#E6EEED".replaceAll('#', '0xff'))),
                                       height: 200,
                                       child: GestureDetector(
                                        
                                         onTap: (){
                                           Navigator.push(context, MaterialPageRoute(
                                             builder: (context) => ServiceInfo(doc),
                                         
                                           ),
                                         ) ;
                                         },
                                         child: Row(
                                           
                                           children: [
                                             Expanded(
                                               
                                               child: Stack(
                                                 children: [
                                                   Align(
                                                     child: ClipRRect(
                                                         borderRadius:
                                                             BorderRadius
                                                                 .circular(8.0),
                                                         child: Image.asset(
                                                             'assets/images/plomero.jpg')
                                                             
                                                             ),
                                                   )
                                                 ],
                                               ),
                                             ),
                                             Expanded(
                                               child: Stack(
                                                 children: [
                                                   Container(
                                                     margin: EdgeInsets.only(
                                                         top: 60, bottom: 20),
                                                     decoration: BoxDecoration(
                                                         color: Color(int.parse(
                                                             "#E6EEED"
                                                                 .replaceAll('#',
                                                                     '0xff'))),
                                                         borderRadius:
                                                             BorderRadius.only(
                                                                 topRight: Radius
                                                                     .circular(
                                                                         20),
                                                                 bottomRight: Radius
                                                                     .circular(
                                                                         20))),
                                                   ),
                                                    Align(
                                                          child: Stack(children: [
                                                            ListTile(
                                                              title:
                                                                  Text(doc['nameService']),
                                                             
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets.only(
                                                                  top: 60,
                                                                  bottom: 20),
                                                              decoration: BoxDecoration(
                                                                  color: Color(int
                                                                      .parse("#8B9A99"
                                                                          .replaceAll(
                                                                              '#',
                                                                              '0xff'))),
                                                                  borderRadius: BorderRadius.only(
                                                                      topRight: Radius
                                                                          .circular(
                                                                              20),
                                                                      bottomRight: Radius
                                                                          .circular(
                                                                              20))),
                                                              child: ListTile(
                                                                subtitle: Text(
                                                                  doc['infoService'],
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                            )
                                                          ]),
                                                        )
                                                 ],
                                               ),
                                             )
                                           ],
                                         ),
                                       ),
                                     ),

                        
                                   ))
                               .toList());
                     } else if (!snapshot.hasData) {
                       return Center(
                         child: CircularProgressIndicator(),
                       );
                     }
                   }),
             ),
           ],
         ),

      ),
    );
  }
}