import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Intento extends StatefulWidget {
  final Color grisClaro = Color(0xffE6EEED);
  @override
  _IntentoState createState() => _IntentoState();
}

class _IntentoState extends State<Intento> {
  var paramSearch;
  var iconSelected;

  List<IconData> _icons = [
    FontAwesomeIcons.chalkboardTeacher,
    FontAwesomeIcons.paintRoller,
    FontAwesomeIcons.wrench,
    FontAwesomeIcons.biking,
    FontAwesomeIcons.dumbbell,
  ];

  Widget _buildIcon(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          iconSelected = index;
          searchByCategory();
        });
      },
      child: Container(
        margin: EdgeInsets.only(left: 20),
        height: 80.0,
        width: 60.0,
        decoration: BoxDecoration(
          color: Color(int.parse("#F2BB35".replaceAll('#', '0xff'))),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Icon(
          _icons[index],
          size: 25.0,
          color: Colors.brown,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              pinned: true,
              floating: false,
              delegate: CustomSliverDelegate(
                expandedHeight: 400.0,
              ),
            ),
            SliverFillRemaining(
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      height: 100.0,
                      child: new ListView.builder(
                        itemCount: _icons.length,
                        itemBuilder: (context, index) {
                          return _buildIcon(index);
                        },
                        scrollDirection: Axis.horizontal,
                      )),
                  Text(
                    'SERVICES',
                    style: TextStyle(fontSize: 25),
                  ),
                  Container(
                    width: 350,
                    height: 350,
                    child: FutureBuilder<QuerySnapshot>(
                        future: FirebaseFirestore.instance
                            .collection('services')
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final List<DocumentSnapshot> documents =
                                snapshot.data.docs;
                            return ListView(

                                //Service card
                                children: documents
                                    .map((doc) => Card(
                                          child: Container(
                                            color: Color(int.parse("#E6EEED"
                                                .replaceAll('#', '0xff'))),
                                            height: 200,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Stack(
                                                    children: [
                                                      Align(
                                                        child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                            child: Image.asset(
                                                                'assets/images/plomero.jpg')),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: 60,
                                                            bottom: 20),
                                                        decoration: BoxDecoration(
                                                            color: Color(int
                                                                .parse("#E6EEED"
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
                                                      ),
                                                      Align(
                                                        child: Stack(children: [
                                                          ListTile(
                                                            title: Text(
                                                                doc['name']),
                                                            subtitle: Text(
                                                              doc['price']
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 60,
                                                                    bottom: 20),
                                                            decoration: BoxDecoration(
                                                                color: Color(int.parse(
                                                                    "#8B9A99"
                                                                        .replaceAll(
                                                                            '#',
                                                                            '0xff'))),
                                                                borderRadius: BorderRadius.only(
                                                                    topRight: Radius
                                                                        .circular(
                                                                            20),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            20))),
                                                            child: ListTile(
                                                              subtitle: Text(
                                                                doc['description'],
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

                                          /* color: Color(int.parse("#8B9A99".replaceAll('#', '0xff'))),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                      child: ListTile(
                                        title: Text(doc['name']),
                                        subtitle: Text(doc['price'], style: TextStyle(fontWeight: FontWeight.bold),),
                                      ), */
                                        ))
                                    .toList());
                          } else if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void searchByCategory() async {
    var cat = "";

    switch (iconSelected) {
      case 0:
        cat = "teacher";
        break;
      case 1:
        cat = "painter";
        break;
      case 2:
        cat = "plumber";
        break;
      case 3:
        cat = "biking";
        break;
      case 4:
        cat = "coach";
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

class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final bool hideTitleWhenExpanded;
  List<String> _categorias = ["biking", "dumbbell", "painter"];
  var paramSearch;

  CustomSliverDelegate({
    @required this.expandedHeight,
    this.hideTitleWhenExpanded = true,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final appBarSize = expandedHeight - shrinkOffset;
    final cardTopPosition = expandedHeight / 2 - shrinkOffset;
    final proportion = 2 - (expandedHeight / appBarSize);
    final percent = proportion < 0 || proportion > 1 ? 0.0 : proportion;
    return SizedBox(
      height: expandedHeight + expandedHeight / 2,
      child: Stack(
        children: [
          SizedBox(
            height: appBarSize < kToolbarHeight ? kToolbarHeight : appBarSize,
            child: AppBar(
              backgroundColor:
                  Color(int.parse("#41736C".replaceAll('#', '0xff'))),
              toolbarHeight: 200.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(67),
                      bottomLeft: Radius.circular(67))),
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
              elevation: 0.0,
              title: Opacity(
                opacity: hideTitleWhenExpanded ? 1.0 - percent : 1.0,
                child: Column(
                  children: [
                    Text(
                      'SEARCH',
                      style: TextStyle(fontSize: 25),
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
                              GestureDetector(
                                child: Icon(
                                  Icons.search,
                                  color: Colors.black54,
                                ),
                                onTap: () {
                                  print('HoOLLAAAA');
                                  search(context);
                                },
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                key: Key("searchField"),
                                child: TextField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Search..."),
                                  onChanged: (value) {
                                    paramSearch = value;
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
            ),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            top: cardTopPosition > 0 ? cardTopPosition : 0,
            bottom: 0.0,
            child: Opacity(
              opacity: percent,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30 * percent),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color:
                          Color(int.parse("#E6EEED".replaceAll('#', '0xff')))),
                  child: Center(
                    child: ListView.builder(
                        itemCount: _categorias.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return Container(
                            margin: EdgeInsets.only(
                                left: 20, right: 160, bottom: 16, top: 16),
                            height: 40.0,
                            width: 20.0,
                            decoration: BoxDecoration(
                              color: Color(
                                  int.parse("#F2BB35".replaceAll('#', '0xff'))),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Text(_categorias[index].toString(),
                                textAlign: TextAlign.center),
                          );
                        }),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => 200;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  void search(context) async {
    var result = await FirebaseFirestore.instance
        .collection('services')
        .where('name', isGreaterThanOrEqualTo: paramSearch)
        .get();
    final List<DocumentSnapshot> documents = result.docs;

    Navigator.of(context).pushNamed("/results", arguments: documents);
  }
}
