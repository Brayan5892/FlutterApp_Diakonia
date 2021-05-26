import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
//import 'package:cached_network_image/cached_network_image.dart';
import 'chatList.dart';

class ChatRoom extends StatefulWidget {
  final String chatId, name, user1, user2, name2;
  ChatRoom(this.chatId, this.name, this.user1, this.user2, this.name2);

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final cloudinary = CloudinaryPublic('dfm8d2pyf', 'zjtb4tq2', cache: false);
  final textController = TextEditingController();
  String chatId, name, user1, user2, name2,profilePicture=" ";
  var message;
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();

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
       debugShowCheckedModeBanner: false,
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
                           message['type'] == 'image' ? 
                                Bubble(
                                  margin: BubbleEdges.only(top: 10),
                                  alignment: Alignment.topRight,
                                  nip: BubbleNip.rightTop,
                                        color: Color(int.parse("#F2BB35".replaceAll('#', '0xff'))),
                                  child: Column(
                                 children: [Container(
                                      height: 200,
                                      width: 200,
                                      child:  Image.network(message['text'])
                                    ),] 
                                  ),
                              )
                              :
                               Bubble(
                                margin: BubbleEdges.only(top: 10),
                                alignment: Alignment.topRight,
                                nip: BubbleNip.rightTop,
                                      color: Color(int.parse("#F2BB35".replaceAll('#', '0xff'))),
                                child: Text(message['text'], textAlign: TextAlign.right),
                              )
                          :
                          message['type'] == 'image' ? 
                           Bubble(
                            margin: BubbleEdges.only(top: 10),
                            alignment: Alignment.topLeft,
                            nip: BubbleNip.leftTop,
                            child: Column(
                                 children: [Container(
                                      height: 200,
                                      width: 200,
                                      child:  Image.network(message['text'])
                                    ),] 
                                  ),
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
                  margin: EdgeInsets.only(top: 10),
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
                              Icons.image_outlined,
                              color: Colors.black54,
                            ),
                            onTap: () {
                              showModalBottomSheet(
                                context: context, 
                                builder: ((builder) => bottomSheet()),
                                );
                             textController.clear();
                            },
                          ),
                           SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: TextField(
                            controller: textController,
                              key:Key('chatField'),
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


  Widget bottomSheet(){
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose profile photo",
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            
            TextButton.icon(
              key: Key("camera"),
              icon: Icon(
                Icons.camera,
                color: Color.fromARGB(255, 65, 115, 108),
                ),
              onPressed: () async {
                      await takePhoto(ImageSource.camera);
                      try {
                        CloudinaryResponse response = await cloudinary.uploadFile(
                        CloudinaryFile.fromFile(_imageFile.path, resourceType: CloudinaryResourceType.Image),
                      );

                        print(response.secureUrl);

                      sendImage(response.secureUrl);
                      

                    } on CloudinaryException catch (e) {
                      print(e.message);
                      print(e.request);
                    }
              }, 

               label: Text("Camera"),
               ),
              TextButton.icon(
                key: Key("gallery"),
                icon: Icon(
                Icons.image, 
                color: Color.fromARGB(255, 65, 115, 108),
                ),
              onPressed: () async {
               await takePhoto(ImageSource.gallery);
                      try {
                        CloudinaryResponse response = await cloudinary.uploadFile(
                        CloudinaryFile.fromFile(_imageFile.path, resourceType: CloudinaryResourceType.Image),
                      );

                        print(response.secureUrl);

                      sendImage(response.secureUrl);
                      

                    } on CloudinaryException catch (e) {
                      print(e.message);
                      print(e.request);
                    }
              }, 
               label: Text("Gallery"),
               ),
          ],)
        ],
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
          'type':'text'
      });
    });

  }

   void sendImage(String content) async {
    
    CollectionReference message = FirebaseFirestore.instance.collection('messages').doc(chatId).collection(chatId);

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(message.doc(DateTime.now().millisecondsSinceEpoch.toString()), {
          'createdAT':DateTime.now().millisecondsSinceEpoch.toString(),
          'fromID':user1,
          'toID':user2,
          'text':content,
          'type':'image'
      });
    });

  }

   takePhoto(ImageSource source) async{
  
    final pickedFile = await _picker.getImage(
      source: source,
    );
   
    setState(() {
      _imageFile = pickedFile;
    });
    
  }
}