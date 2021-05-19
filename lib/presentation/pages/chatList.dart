import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diakonia/presentation/pages/chatRoom.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatList extends StatefulWidget {
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {

  @override

  void initState() { 
    super.initState();
    getChats();
  }
   List<DocumentSnapshot> chats=[];

  Future<void> getChats() async{
      
      var document = await FirebaseFirestore.instance.collection('chatList').where('User1', isEqualTo: FirebaseAuth.instance.currentUser.uid).get(); 
      var document2 = await FirebaseFirestore.instance.collection('chatList').where('User2', isEqualTo: FirebaseAuth.instance.currentUser.uid).get(); 
      final List<DocumentSnapshot> chats1 = document.docs;
      final List<DocumentSnapshot> chats2 = document2.docs;
      final List<DocumentSnapshot> chats3 =  new List.from(chats1)..addAll(chats2);
      
      setState(() {
       chats=chats3;
      });
  }


  Widget build(BuildContext context) {
    return MaterialApp(
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
                      Navigator.of(context).pushNamed("/home");
                    }),
              ],
            ),
            actions: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.account_circle_outlined,
                        size: 35,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed("/profile");
                      }),
                ],
              )
            ],
            backgroundColor:
                Color(int.parse("#41736C".replaceAll('#', '0xff'))),
            toolbarHeight: 200.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(67),
                    bottomLeft: Radius.circular(67))),
            title: Column(
              children: [
                Center(
                  child: Text(
                    'MESSAGES',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ],
            ),
          ),
        body: Container(
            child: ListView.builder(
            itemCount: chats.length,
            itemBuilder: (BuildContext context, int index) {
              final chat = chats[index].data();
                      return GestureDetector(
                                   onTap: (){
                                              Navigator.push(context, MaterialPageRoute(
                                                  builder: (context) => ChatRoom(chat['chatGroupID'],chat['User1Name'],chat['User1'],chat['User2'],chat['User2Name']),
                                                  settings: RouteSettings(name: '/chatRoom')
                                              ));
                                            },
                                        child: Card(
                                  
                                          child: Container(
                                            padding: EdgeInsets.only(top:10,bottom: 10),
                                              margin: EdgeInsets.only(left:20,right: 20,top: 20),
                                              decoration: BoxDecoration(
                                                color: Color(int.parse("#F2BB35".replaceAll('#', '0xff'))),
                                                borderRadius: BorderRadius.circular(30.0),
                                              ),
                                            height: 80,
                                               
                                            child: Row(
                                       
                                              children: [
                                                Expanded(
                                                  child: Stack(
                                                    children: [
                                                      Align(
                                                        child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(50.0),
                                                            child:   chat['User1'] == FirebaseAuth.instance.currentUser.uid ?
                                                            Image.network(chat['ImageUser2']) : Image.network(chat['ImageUser1']))
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Stack(
                                                    children: [
                        
                                                      Align(
                                                        child: Stack(children: [
                                                          ListTile(
                                                            title:
                                                              chat['User1'] == FirebaseAuth.instance.currentUser.uid ? Text(chat['User2Name']) : Text(chat['User1Name'])
                                                                
                                                          ),
                                                        ]),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),

                                          /* color: Color(int.parse("#8B9A99".replaceAll('#', '0xff'))),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                child: ListTile(
                                  title: Text(doc['name']),
                                  subtitle: Text(doc['price'], style: TextStyle(fontWeight: FontWeight.bold),),
                                ), */
                                        ),
                      );
            },
          )),
      ),
    );
    
  }
   

  String getValue(DocumentReference documentReference) {
    String val;
    documentReference.get().then((onData) {
        val = onData.data()['name'];
        print(val);
      });
    return val;
  }
}