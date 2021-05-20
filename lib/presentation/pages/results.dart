import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Results extends StatefulWidget {
  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    final List<DocumentSnapshot> services =
        ModalRoute.of(context).settings.arguments;
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
                      //Navigator.of(context).pushNamed("/profile");
                      Navigator.of(context).pushNamed("/profile");
                    }),
              ],
            )
          ],
          backgroundColor: Color(int.parse("#41736C".replaceAll('#', '0xff'))),
          toolbarHeight: 200.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(67),
                  bottomLeft: Radius.circular(67))),
          title: Column(
            children: [
              Text(
                'RESULTS',
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
                            //search();
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
                              setState(() {
                                //paramSearch = value;
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
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 20, bottom: 20, top: 20),
                height: 90.0,
                width: 107.0,
                decoration: BoxDecoration(
                  color: Color(int.parse("#F2BB35".replaceAll('#', '0xff'))),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                //PREGUNTAR COMO SERÁ FILTRO DE CIUDADES
                child: Text("WHERE BARRANQUILLA",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold))),
            Text(
              'CHOOSE',
              style: TextStyle(fontSize: 25),
            ),
            Expanded(
                child: Container(
                    child: ListView.builder(
              itemCount: services.length,
              itemBuilder: (BuildContext context, int index) {
                final service = services[index].data();
                return Card(
                  //child: Text('Nombre: ' +
                  //  service['name'] +
                  //', Descripcion: ' +
                  //service['description']),

                  child: Container(
                    color: Color(int.parse("#E6EEED".replaceAll('#', '0xff'))),
                    height: 200,
                    child: Row(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              Align(
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                        'assets/images/serviciosgeneral.png')),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 60, bottom: 20),
                                decoration: BoxDecoration(
                                    color: Color(int.parse(
                                        "#E6EEED".replaceAll('#', '0xff'))),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        bottomRight: Radius.circular(20))),
                              ),
                              Align(
                                child: Stack(children: [
                                  ListTile(
                                    title: Text(service['name']),
                                    subtitle: Text(
                                      service['price'].toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 60, bottom: 20),
                                    decoration: BoxDecoration(
                                        color: Color(int.parse(
                                            "#8B9A99".replaceAll('#', '0xff'))),
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            bottomRight: Radius.circular(20))),
                                    child: ListTile(
                                      subtitle: Text(
                                        service['description'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
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
                );
              },
            )))
          ],
        ),
      ),
    );
  }
}
