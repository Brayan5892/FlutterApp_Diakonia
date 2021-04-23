import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  var paramSearch;
  var iconSelected;
  List<IconData> _icons=[
    FontAwesomeIcons.chalkboardTeacher,
    FontAwesomeIcons.paintRoller,
    FontAwesomeIcons.wrench,
    FontAwesomeIcons.biking,
    FontAwesomeIcons.dumbbell,
  ];

  Widget _buildIcon(int index){
    return GestureDetector(
        onTap: (){
          setState(() {
            iconSelected=index;
            searchByCategory();
          });
        },
        child: Container(
        margin: EdgeInsets.only(left:20),
        height:80.0,
        width:60.0,
        decoration: BoxDecoration(
          color: Color(int.parse("#F2BB35".replaceAll('#', '0xff'))),
          borderRadius: BorderRadius.circular(30.0),
          ),
        child: Icon(_icons[index],size: 25.0,color: Colors.brown,),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(

        appBar: AppBar(
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(Icons.home_outlined,size: 35,color: Colors.white,),
                onPressed: (){
                     Navigator.of(context).pushNamed("/home");
                   }
                ),
            ],
          ),
          actions: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.account_circle_outlined,size: 35,color: Colors.white,),
                  onPressed: (){
                     Navigator.of(context).pushNamed("/profile");
                   }
                   ),
              ],
            )
          ],
          backgroundColor: Color(int.parse("#41736C".replaceAll('#', '0xff'))),
          toolbarHeight: 200.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(67),bottomLeft: Radius.circular(67))),
          title: Column(
            children: [
              Text('SEARCH',
                style: TextStyle(fontSize: 25 ),
              ),
              Container(
                margin: EdgeInsets.only(top:40),
                child: Card(
                elevation: 20.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        child: Icon(
                          Icons.search,
                          color: Colors.black54,
                        ),
                        onTap: () {
                          search();
                        },
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: "Search..."),
                          onChanged: (value) {
                            setState(() {
                              paramSearch = value;
                            });
                          },
                        ),
                      ),
                     
                    ],
                  ),
                ),
        ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top:10,bottom: 10),
              height:100.0,
              child: new ListView.builder(
                itemCount: _icons.length,
                itemBuilder: (context, index){
                return _buildIcon(index);
              },
              scrollDirection: Axis.horizontal,
              )

            ),

            Text('SERVICES',
            style: TextStyle(fontSize: 25),
            ),
              
            Container(
              width: 350,
              height: 300,

              child: FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance.collection('services').get(),
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    final List<DocumentSnapshot> documents = snapshot.data.docs;
                    return ListView(

                      //Service card
                      children: documents.
                          map((doc) => Card(
                            color: Color(int.parse("#E6EEED".replaceAll('#', '0xff'))),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            child: ListTile(
                              title: Text(doc['name']),
                              subtitle: Text(doc['price'].toString(), style: TextStyle(fontWeight: FontWeight.bold),),
                            ),
                          )).toList()
                    );
                  }else if (!snapshot.hasData){
                    return Center(child: CircularProgressIndicator(),);
                  }

                }
                
              ),
            )
          ],
          )
      ),
    );
  }

  void search() async {
    var result = await FirebaseFirestore.instance
        .collection('services')
        .where('name', isGreaterThanOrEqualTo: paramSearch)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    
    Navigator.of(context).pushNamed("/results", arguments: documents);
  }

   void searchByCategory() async {
     var cat="";

    switch(iconSelected){
        case 0:
          cat="teacher";
        break;
        case 1:
          cat="painter";
        break;
        case 2:
          cat="plumber";
        break;
        case 3:
          cat="biking";
        break;
        case 4:
          cat="coach";
        break;
    }  

    var result = await FirebaseFirestore.instance
        .collection('services')
        .where('category', isEqualTo: cat)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    
    Navigator.of(context).pushNamed("/results", arguments: documents);
    
  }

}
