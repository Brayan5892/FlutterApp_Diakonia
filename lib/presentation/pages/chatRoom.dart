import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'chatList.dart';

class ChatRoom extends StatefulWidget {
  final String chatId, name, user1, user2, name2;
  ChatRoom(this.chatId, this.name, this.user1, this.user2, this.name2);

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final textController = TextEditingController();
  String chatId, name, user1, user2, name2;
  var message;

  void initState() {
    super.initState();
    chatId = widget.chatId;
    if (widget.user1 == FirebaseAuth.instance.currentUser.uid){
        user1=widget.user1;
        name=widget.name;
        user2=widget.user2;
        name2=widget.name2;
    }else{
        user1=widget.user2;
        name=widget.name2;
        user2=widget.user1;
        name2=widget.name;
    }
  }

  Future<void> getChat() async{
      
    var document = await FirebaseFirestore.instance.collection('chatList').where('chatGroupID', isEqualTo: chatId).limit(1).get(); 
   
  }

  @override
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
                      Icons.arrow_back,
                      size: 35,
                      color: Colors.white,
                    ),
                    onPressed: () {
                       Navigator.push(context, MaterialPageRoute(
                           builder: (context) => ChatList(),
                           settings: RouteSettings(name: '/chatRoom')
                       ));
                    }),
              ],
            ),
            
            backgroundColor:
                Color(int.parse("#41736C".replaceAll('#', '0xff'))),
            toolbarHeight: 100.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(67),
                    bottomLeft: Radius.circular(67))),
            title: Column(
              children: [
                Center(
                  child: Text(
                    name2,
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ],
            ),
          ),
        body: Column(
          children: [
            Expanded(
                    child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('messages')
                .doc(chatId)
                .collection(chatId)
                .orderBy('createdAT', descending: true)
                .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                        child: CircularProgressIndicator());
                  } else {
                    final List<DocumentSnapshot> listMessage = snapshot.data.docs;
                    return ListView(
                      reverse: true,
                      children: listMessage.map((message) => 
                       message['fromID'] == FirebaseAuth.instance.currentUser.uid ?
                        Bubble(
                            margin: BubbleEdges.only(top: 10),
                            alignment: Alignment.topRight,
                            nip: BubbleNip.rightTop,
                                  color: Color(int.parse("#F2BB35".replaceAll('#', '0xff'))),
                            child: Text(message['text'], textAlign: TextAlign.right),
                          )
                          :
                          Bubble(
                            margin: BubbleEdges.only(top: 10),
                            alignment: Alignment.topLeft,
                            nip: BubbleNip.leftTop,
                            child: Text(message['text']),
                          ),
                      )
                      .toList()
                    );
                  }
                },
              ),
            ),

          Container(
                  margin: EdgeInsets.only(top: 40),
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
                          Expanded(
                            child: TextField(
                            controller: textController,
                              key:Key('searchField'),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Send message"),
                              onChanged: (value) {
                                setState(() {
                                  message = value;
                                });
                                
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                         
                           GestureDetector(
                            child: Icon(
                              Icons.send,
                              color: Colors.black54,
                            ),
                            onTap: () {
                             send(message);
                            textController.clear();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
    
  }
   void send(String content) async {
    
    CollectionReference message = FirebaseFirestore.instance.collection('messages').doc(chatId).collection(chatId);

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(message.doc(DateTime.now().millisecondsSinceEpoch.toString()), {
          'createdAT':DateTime.now().millisecondsSinceEpoch.toString(),
          'fromID':user1,
          'toID':user2,
          'text':content,
    
      });
    });

  }
}