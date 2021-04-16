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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Search'),
        ),
        body: Card(
          elevation: 20.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(2.0)),
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
                InkWell(
                  child: Icon(
                    Icons.arrow_downward,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void search() async {
    var result = await FirebaseFirestore.instance
        .collection('services')
        .where('name', isEqualTo: paramSearch)
        .get();
    result.docs.forEach((res) {
      print(res.data());
    });

    Navigator.of(context).pushNamed("/results");
  }
}
