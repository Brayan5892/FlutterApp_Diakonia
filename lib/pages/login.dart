import 'package:flutter/material.dart';
 

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String email;
  String password;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
       
        body: Container(
          decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/fondoLogin.png"),
            fit: BoxFit.cover,
          ),
        ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              child:Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top:30),
                   child: Image.asset("assets/images/logo.png"),
                   ),
                   Spacer(),
                    Container(
                      height: 55,
                      child: TextFormField(
                        onSaved:  (value){
                            email = value;
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.white, filled: true,
                          labelText: "ID:",
                          border: OutlineInputBorder(borderRadius: const BorderRadius.all(
                            const Radius.circular(30.0),
                          ),
                          borderSide: BorderSide(
                                width: 0, 
                                style: BorderStyle.none,
                          ),
                          )
                          ),
                        )
                      ),
                      Container(
                        height: 55,
                        margin: EdgeInsets.only(top:8.0),
                        child: TextFormField(
                          onSaved:  (value){
                             password = value;
                          },                      
                          decoration: InputDecoration(
                          fillColor: Colors.white, filled: true,
                          labelText: "Password:",
                          border: OutlineInputBorder(borderRadius: const BorderRadius.all(
                            const Radius.circular(30.0)
                          ),
                           borderSide: BorderSide(
                                width: 0, 
                                style: BorderStyle.none,
                          ),
                          )
                          ),
                        )
                      ),
                      Container(
                        height: 50,
                        width: 375,
                        margin: EdgeInsets.only(top:30.0),
                        child: OutlinedButton(
                          onPressed: null,
                          child: Text(
                            "Log in",
                            style: TextStyle(color: Colors.black),
                          ),
                          style: OutlinedButton.styleFrom(
                            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                            backgroundColor: Color(int.parse("#F2BB35".replaceAll('#', '0xff')))
                            
                          ),
                          ),
                      ),
                      Container(
                        height: 50,
                        width: 375,
                        margin: EdgeInsets.only(top:10.0),
                        child: OutlinedButton(
                          onPressed: (){
                            _showRegisterPage(context);
                          },
                          child: Text(
                            "Create account",
                            style: TextStyle(color: Colors.black),
                          ),
                          style: OutlinedButton.styleFrom(
                            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                            backgroundColor: Color(int.parse("#41736C".replaceAll('#', '0xff')))
                            
                          ),
                          ),
                      )
                ],
                )
              ),
          ),
        )
      ),
    );



  }

  void _showRegisterPage(BuildContext context) {
      Navigator.of(context).pushNamed("/register");
  }
}