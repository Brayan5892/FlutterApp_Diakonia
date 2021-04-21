import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Results extends StatefulWidget {
  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    final List<DocumentSnapshot> services = ModalRoute.of(context).settings.arguments;
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Results'),
        ),
        body: Center(
          child: Container(
            child: ListView.builder(
            itemCount: services.length,
            itemBuilder: (BuildContext context, int index) {
              final service = services[index].data();
              return Card(
                child: Text('Nombre: '+service['name']+', Descripcion: '+service['description']),
              );
            },
          )),
        ),
      ),
    );
  }
}
