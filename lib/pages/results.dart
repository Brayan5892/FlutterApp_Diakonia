import 'package:flutter/material.dart';

class Results extends StatefulWidget {
  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  List<String> services = ["Plomeria", "tecnico", "pintura"];

  @override
  Widget build(BuildContext context) {
    //final services = ModalRoute.of(context).settings.arguments;
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
              final service = services[index];
              return Card(
                child: Text(service),
              );
            },
          )),
        ),
      ),
    );
  }
}
