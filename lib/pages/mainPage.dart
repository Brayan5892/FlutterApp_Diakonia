import 'package:flutter/material.dart';
 
 
 
class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom:20),
                child: Text("HOME PAGE",
                style: TextStyle(fontSize: 25),
                )
                ),
              Container(
                child: Center(
                  child: Image.asset("assets/images/teamwork.png")
                  )
                ),
            ],
          ),
          backgroundColor: Color(int.parse("#41736C".replaceAll('#', '0xff'))),
          toolbarHeight: 200.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(67),bottomLeft: Radius.circular(67))),
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal:50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                          Container(
                            child: IconButton(
                              icon: Image.asset("assets/images/user.png",),  
                              onPressed: (){
                                 Navigator.of(context).pushNamed("/profile");
                              }
                              ),
                          ),
                          
                           Container(
                            margin: EdgeInsets.only(right:90.0),
                             child: IconButton(
                              icon: Icon(Icons.addchart_outlined,size: 130,), 
                              onPressed: null
                              ),
                           ),
                           
                        ],
                      ),
                    ),
                  ),

                 Container(
                    margin: EdgeInsets.only(top:90),
                    
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal:50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                          Container(
                            margin: EdgeInsets.only(left:30),
                            child: Text(
                              "Account",
                              style: TextStyle(fontSize: 20),
                              ),
                          ),
                          
                           Container(
                              margin: EdgeInsets.only(left:30),
                              child: Text(
                              "Add service",
                              style: TextStyle(fontSize: 20),
                              ),
                           ),
                           
                        ],
                      ),
                    ),
                  ),

                 Container(
                    
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal:50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:[
                          Container(
                            child: IconButton(
                              icon: Icon(Icons.search,size: 130,), 
                              onPressed: ()=>{
                                    Navigator.of(context).pushNamed("/search"),
                              }
                              ),
                          ),
                          Spacer(),
                           Container(
                            margin: EdgeInsets.only(right:90.0),
                             child: IconButton(
                              icon: Icon(Icons.request_page,size:130,), 
                              onPressed: null
                              ),
                           ),
                           
                        ],
                      ),
                    ),
                  ),

                   Container(
                    margin: EdgeInsets.only(top:90),
                    
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal:50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                          Container(
                            margin: EdgeInsets.only(left:30),
                            child: Text(
                              "Search",
                              style: TextStyle(fontSize: 20),
                              ),
                          ),
                          
                           Container(
                              margin: EdgeInsets.only(left:30),
                              child: Text(
                              "Request",
                              style: TextStyle(fontSize: 20),
                              ),
                           ),
                           
                        ],
                      ),
                    ),
                  ),


                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal:50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:[
                          Container(
                            child: IconButton(
                              icon: Icon(Icons.map_outlined,size: 130,), 
                              onPressed: null
                              ),
                          ),
                          Spacer(),
                           Container(
                            margin: EdgeInsets.only(right:90.0),
                             child: IconButton(
                              icon: Icon(Icons.message_outlined,size:130,), 
                              onPressed: null
                              ),
                           ),
                           
                        ],
                      ),
                    ),
                  ),

       Container(
                    margin: EdgeInsets.only(top:90),
                    
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal:50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                          Container(
                            margin: EdgeInsets.only(left:30),
                            child: Text(
                              "Map",
                              style: TextStyle(fontSize: 20),
                              ),
                          ),
                          
                           Container(
                              margin: EdgeInsets.only(left:30),
                              child: Text(
                              "Messages",
                              style: TextStyle(fontSize: 20),
                              ),
                           ),
                           
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
