import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diakonia/presentation/pages/chatList.dart';
import 'package:diakonia/presentation/pages/homePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class RequestInfo extends StatefulWidget {
  final DocumentSnapshot serviceRequest;

 RequestInfo(this.serviceRequest); 
 
  @override
  _RequestInfoState createState() => _RequestInfoState();
}

class _RequestInfoState extends State<RequestInfo> {
  DocumentSnapshot serviceRequest;
  Timestamp dateRequest;
  String imageRequest='';
  String infoRequest='';
  String idPrestadorServicio='';
  String namePrestadorServicio='';

  void initState() {
    super.initState();   
     serviceRequest = widget. serviceRequest;
    setState(() {
       
          dateRequest=serviceRequest.data()['dateGetService'];
          imageRequest=serviceRequest.data()['imgUrl'];
          infoRequest=serviceRequest.data()['infoService'];
          namePrestadorServicio=serviceRequest.data()['nameService'];
        });
        
  }

  @override
  Widget build(BuildContext context) {
     double width = MediaQuery.of(context).size.width;
   double height = MediaQuery.of(context).size.height;
       return MaterialApp(
        debugShowCheckedModeBanner: false,
         title: 'Material App',
          home: Scaffold(
        appBar: AppBar(
           backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
          actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              icon: Icon(
                Icons.home, 
                color: Color(int.parse("#F2BB35".replaceAll('#', '0xff'))),
                
                ),
                  onPressed: () {
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                          builder: (context) => new MyHomePage(),
                          ),
                      );
                },
            
            ),
            
          ),
        
        ],

        ),
        body: Stack(
           fit: StackFit.expand,
           children: [
             Positioned(
            bottom: 0,
            left: 0,
            right: 0,
          
            child: Container(
              height: height * 0.6,
              decoration: BoxDecoration(
                color: Color(int.parse("#41736C".replaceAll('#', '0xff'))),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
            ),
               ),
             Column(
            children: [
              Text(
                 infoRequest,
                
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 45,
                ),
              ),
            ],
          ), 
            Positioned(
            top: 0,
            left: 10,
            
            child: Container(
              width: width ,
              child: Hero(
                tag: 'shadow$infoRequest',
                child: Image.asset(
                  "assets/images/pana.png",
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
          ),
            Positioned(
            top: 0,
            left: 0,
           
            child: Container(
              width: width ,
              child: Hero(tag: infoRequest, 
              child: Image.asset("assets/images/pana.png")),
            ),
          ),
              Positioned(
            bottom: 20,
            left: 60,
            child: Container(
              height: height * 0.4,
              width: width * 0.7,
              decoration: BoxDecoration(
                color:  Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                
                  child: Column(
                    
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:60),
                        child: Text(
                          dateRequest.toDate().toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Nunito',
                            fontSize: 28,
                          ),
                        ),
                      ),
                     
                      SizedBox(
                        height: 30,
                      ),
                      
                      Material(
                        
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Color(int.parse("#D8A07D".replaceAll('#', '0xff'))),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top:10.0, bottom: 10.0, left:30, right: 30 ),
                            child: Text(
                              namePrestadorServicio,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Nunito',
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children:  [
                          
                          Padding(
                              padding: EdgeInsets.only(left:50, top:20, right: 20),
                              
                            child: OutlinedButton(
                              
                              // elevation: 6,
                              // borderRadius: BorderRadius.circular(25),
                              child: Container(
                                width: width*0.4,
                                //height: height*0.1,
                                decoration: BoxDecoration(
                                  color:  Color(int.parse("#F2BB35".replaceAll('#', '0xff'))),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left:50, top:20, bottom: 20),
                                  child: Text(
                                    '  Talk  ',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontFamily: 'Nunito'),
                                  ),
                                ),
                              ),
                                 onPressed: () {
                                  
                                    Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => ChatList(),
                                                        
                                    ),
                                  ) ;
                                },
                            ),
                          ),
                           
                       
                        ],
                      )
                    ],
                  ),
                
              ),
            ),
          ),
           ]
          
        ),
           
          ),
        
             
         
           
          
      
    );
  }
}