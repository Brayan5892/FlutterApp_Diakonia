import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
 

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String _email;
  String _password;

  final auth = FirebaseAuth.instance;

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
            image: AssetImage("assets/images/fondoLogin.png"),
            fit: BoxFit.cover,
          ),
        ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
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
                            _email = value;
                        },
                         validator: (value){
                          if(value.isEmpty){
                            return "Please enter the email";
                          }else{
                            return null;
                          }
                        
                       },
                       key: Key("emailLogin"),
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
                          obscureText: true,
                          onSaved:  (value){
                             _password = value;
                          },        
                           validator: (value){
                                if(value.isEmpty){
                                  return "Please enter the password";
                                }else{
                                  return null;
                                }
                             },  
                          key: Key("passwordLogin"),
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
                                      onPressed: (){
                                        _logIn();
                                                  },
                                      child: Text(
                                        "Log in",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      key: Key("login"),
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
                            
            void _logIn() async {
              if(formKey.currentState.validate()){
                try {
                    formKey.currentState.save();
                    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email:  _email,
                    password: _password
                    );
    
                      Navigator.of(context).pushNamed("/home");  
                  
                    }  on FirebaseAuthException catch (e) {
                      
                      if (e.code == 'user-not-found') {
                        _showErrorDialog('Usuario no encontrado');
                      } else if (e.code == 'wrong-password') {
                        _showErrorDialog('Contraseña incorrecta');
                      }
                    }
                }
            }

            void _showErrorDialog(String msg){
                      showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                          title: Text('An Error Occured'),
                          content: Text(msg),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Okay'),
                              onPressed: (){
                                Navigator.of(ctx).pop();
                              },
                            )
                          ],
                        )
                      );
                    }

}