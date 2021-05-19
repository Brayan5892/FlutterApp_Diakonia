import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
          body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/landingicon.png"),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Image.asset("assets/images/logo.png"),
                  ),
                  Spacer(),
                  Container(
                    height: 70,
                    width: 375,
                    margin: EdgeInsets.only(top: 10.0),
                    child: OutlinedButton(
                      onPressed: () {
                        _showlogIn();
                      },
                      child: Text(
                        "Sign in",
                        style: TextStyle(color: Colors.white),
                      ),
                      //key: Key("login"),
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          backgroundColor: Color(
                              int.parse("#F2BB35".replaceAll('#', '0xff')))),
                    ),
                  ),
                  Container(
                    height: 70,
                    width: 375,
                    margin: EdgeInsets.only(top: 10.0),
                    //key: Key("register"),
                    child: OutlinedButton(
                      onPressed: () {
                        _showRegisterPage(context);
                      },
                      child: Text(
                        "Create account",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          backgroundColor: Color(
                              int.parse("#41736C".replaceAll('#', '0xff')))),
                    ),
                  )
                ],
              )),
        ),
      )),
    );
  }

  void _showRegisterPage(BuildContext context) {
    Navigator.of(context).pushNamed("/register");
  }

  void _showlogIn() async {
    Navigator.of(context).pushNamed("/");
  }
}
