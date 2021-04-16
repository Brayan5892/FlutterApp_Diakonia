import 'package:flutter/material.dart';
 
 

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Home page'),
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal:50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:[
                        Container(
                          child: IconButton(
                            icon: Icon(Icons.account_circle_outlined,size: 130,), 
                            onPressed: (){
                               Navigator.of(context).pushNamed("/profile");
                            }
                            ),
                        ),
                        Spacer(),
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
                 margin: EdgeInsets.only(top:150),
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
                 margin: EdgeInsets.only(top:150),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
