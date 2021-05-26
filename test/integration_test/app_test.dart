import 'package:diakonia/presentation/pages/addService.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:diakonia/main.dart' as app;
import 'package:diakonia/presentation/pages/addService.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:integration_test/integration_test.dart';


void main() {

    //enableFlutterDriverExtension();
 IntegrationTestWidgetsFlutterBinding.ensureInitialized();

group('test integration', () {

 IntegrationTestWidgetsFlutterBinding.ensureInitialized();
 
 app.main();
testWidgets("Register", 
 (tester) async{
   app.main();
   await tester.pumpAndSettle();
   //await tester.tap(find.byKey(Key('register')));
   await tester.tap(find.text("Create account"));
   await tester.pumpAndSettle(Duration(seconds: 4));
   final emailRField = find.byKey(Key("emailRegister"));
   final passwordRField = find.byKey(Key("passwordRegister"));
   final confirmRField = find.byKey(Key("confirmRegister"));
   final signUpButton = find.text("Sign Up");

     await tester.enterText(emailRField, "karolbb@gmail.com");
     await tester.enterText(passwordRField, "K123456b.");
     await tester.enterText(confirmRField, "K123456b.");
     await tester.pumpAndSettle(Duration(seconds: 4));
     await tester.tap(signUpButton);
     await tester.pumpAndSettle(Duration(seconds: 4));
 });
 
 testWidgets("login with correct email and password", 
 (tester) async {
  app.main();
     await tester.pumpAndSettle();
     await tester.tap(find.text("Sign in"));
     await tester.pumpAndSettle(Duration(seconds: 4));

     await tester.pumpAndSettle();
     final emailField = find.byKey(Key("emailLogin"));
     final passwordField = find.byKey(Key("passwordLogin"));
     final signInButton = find.text("Log in");
    
     await tester.enterText(emailField, "Brayaaan@gmail.com");
     await tester.enterText(passwordField, "zxcasdqwe123");
     await tester.pumpAndSettle(Duration(seconds: 3));

     await tester.tap(signInButton);
     await tester.pumpAndSettle(Duration(seconds: 4));


 });

 
 testWidgets("login with incorrect email and password", 
 (tester) async {
 
     app.main();
 
     await tester.pumpAndSettle();
     await tester.tap(find.text("Sign in"));
     await tester.pumpAndSettle(Duration(seconds: 4));

     await tester.pumpAndSettle();
     final emailField = find.byKey(Key("emailLogin"));
     final passwordField = find.byKey(Key("passwordLogin"));
     final signInButton = find.text("Log in");
     
     await tester.enterText(emailField, "Brayaan@gmail.com");
     await tester.enterText(passwordField, "zxcasdqwe");
     await tester.pumpAndSettle(Duration(seconds: 5));
 
     await tester.tap(signInButton);
     await tester.pumpAndSettle(Duration(seconds: 5));
     
     expect(find.byType(AlertDialog), findsOneWidget);
 
 
 });


 testWidgets("login with correct email and password, search service by name", 
 (tester) async {
 
     app.main();

     await tester.pumpAndSettle();
     await tester.tap(find.text("Sign in"));
     await tester.pumpAndSettle(Duration(seconds: 4));

     await tester.pumpAndSettle();
     final emailField = find.byKey(Key("emailLogin"));
     final passwordField = find.byKey(Key("passwordLogin"));
     final signInButton = find.text("Log in");
     
     await tester.enterText(emailField, "Brayaaan@gmail.com");
     await tester.enterText(passwordField, "zxcasdqwe123");
     await tester.pumpAndSettle(Duration(seconds: 5));
 
     await tester.tap(signInButton);
     await tester.pumpAndSettle(Duration(seconds: 5));
     
     await tester.tap(find.text('Search'));
     await tester.pumpAndSettle();
 
     await tester.enterText(find.byKey(Key('searchField')), 'Pro');
     await tester.tap(find.widgetWithIcon(GestureDetector, Icons.search));
     await tester.pumpAndSettle(Duration(seconds: 5));
     expect(find.byType(ListView), findsOneWidget);
 
 
 });
 

 testWidgets("login with correct email and password, search service by category", 
 (tester) async {
 
     app.main();

     await tester.pumpAndSettle();
     await tester.tap(find.text("Sign in"));
     await tester.pumpAndSettle(Duration(seconds: 4));

     await tester.pumpAndSettle();
     final emailField = find.byKey(Key("emailLogin"));
     final passwordField = find.byKey(Key("passwordLogin"));
     final signInButton = find.text("Log in");
     
     await tester.enterText(emailField, "Brayaaan@gmail.com");
     await tester.enterText(passwordField, "zxcasdqwe123");
     await tester.pumpAndSettle(Duration(seconds: 5));
 
     await tester.tap(signInButton);
     await tester.pumpAndSettle(Duration(seconds: 5));
     
     await tester.tap(find.text('Search'));
     await tester.pumpAndSettle(Duration(seconds: 5));
    
    

     await tester.tap(find.widgetWithIcon(GestureDetector,FontAwesomeIcons.paintRoller));
     await tester.pumpAndSettle(Duration(seconds: 8));
     expect(find.byType(ListView), findsOneWidget);
 
 
  });

   

   testWidgets("Editar perfil: login, homepage, profile, editprofile", 
  (tester) async {
    app.main();
     await tester.pumpAndSettle();
     await tester.tap(find.text("Sign in"));
     await tester.pumpAndSettle(Duration(seconds: 4));

     await tester.pumpAndSettle();
     final emailField = find.byKey(Key("emailLogin"));
     final passwordField = find.byKey(Key("passwordLogin"));
     final signInButton = find.text("Log in");
    
     await tester.enterText(emailField, "Brayaaan@gmail.com");
     await tester.enterText(passwordField, "zxcasdqwe123");
     await tester.pumpAndSettle(Duration(seconds: 3));

     await tester.tap(signInButton);
     await tester.pumpAndSettle(Duration(seconds: 4));

     //go to profile edit 
     await tester.tap(find.text("My Account"));
     await tester.pumpAndSettle(Duration(seconds: 3));
     await tester.tap(find.byKey(Key("settings"))); 
     await tester.pumpAndSettle(Duration(seconds: 5));

     //edit name  
      await tester.enterText(find.byKey(Key('Name')), 'A new name');
      await tester.pumpAndSettle(Duration(seconds: 5));
      await tester.enterText(find.byKey(Key('LastName')), 'A new lastname');
      await tester.enterText(find.byKey(Key('phone')), '300134');
      await tester.pumpAndSettle(Duration(seconds: 5));
      await tester.enterText(find.byKey(Key('description')), 'A new description');
      await tester.pumpAndSettle(Duration(seconds: 10));
          
       // save
      await tester.tap(find.byKey(Key('saveEdit')));
      await tester.pumpAndSettle(Duration(seconds: 15));
      
      await tester.tap(find.text("Okay"));
      await tester.pumpAndSettle(Duration(seconds: 15));
     
 });


    
 
 testWidgets("Chat, enviar mensajes", 
  (tester) async {
    app.main();
     await tester.pumpAndSettle();
     await tester.tap(find.text("Sign in"));
     await tester.pumpAndSettle(Duration(seconds: 4));

     final emailField = find.byKey(Key("emailLogin"));
     final passwordField = find.byKey(Key("passwordLogin"));
     final signInButton = find.text("Log in");
    
     await tester.enterText(emailField, "Brayaaan@gmail.com");
     await tester.enterText(passwordField, "zxcasdqwe123");
     await tester.pumpAndSettle(Duration(seconds: 3));

     await tester.tap(signInButton);
     await tester.pumpAndSettle(Duration(seconds: 4));

     //go to messages
     await tester.tap(find.text("Messages"));
     await tester.pumpAndSettle(Duration(seconds: 15));

     //enter chat
     await tester.tap(find.text("Camila"));
     await tester.pumpAndSettle(Duration(seconds: 5));
       // save
     await tester.enterText(find.byKey(Key('chatField')), 'Prueba');
     await tester.pumpAndSettle(Duration(seconds: 5));
     await tester.tap(find.byIcon(Icons.send));
     await tester.pumpAndSettle(Duration(seconds: 5));
       // save
 });

  testWidgets("Requests", 
  (tester) async {
    app.main();
     await tester.pumpAndSettle();
     await tester.tap(find.text("Sign in"));
     await tester.pumpAndSettle(Duration(seconds: 4));

     final emailField = find.byKey(Key("emailLogin"));
     final passwordField = find.byKey(Key("passwordLogin"));
     final signInButton = find.text("Log in");
    
     await tester.enterText(emailField, "Brayaaan@gmail.com");
     await tester.enterText(passwordField, "zxcasdqwe123");
     await tester.pumpAndSettle(Duration(seconds: 3));

     await tester.tap(signInButton);
     await tester.pumpAndSettle(Duration(seconds: 4));

     //go to messages
     await tester.tap(find.text("request"));
     await tester.pumpAndSettle(Duration(seconds: 15));

     //enter chat
     await tester.tap(find.text("Karol"));
     await tester.pumpAndSettle(Duration(seconds: 5));
   
       // save
 });
 
testWidgets("Request a service", (tester)async{
     app.main();
     await tester.pumpAndSettle();
    
     await tester.pumpAndSettle();
     await tester.tap(find.text("Sign in"));
     await tester.pumpAndSettle(Duration(seconds: 4));

     final emailField = find.byKey(Key("emailLogin"));
     final passwordField = find.byKey(Key("passwordLogin"));
     final signInButton = find.text("Log in");
    
     await tester.enterText(emailField, "Brayaaan@gmail.com");
     await tester.enterText(passwordField, "zxcasdqwe123");
     await tester.pumpAndSettle(Duration(seconds: 3));

     await tester.tap(signInButton);
     await tester.pumpAndSettle(Duration(seconds: 4));

     await tester.tap(find.text("Search"));
     await tester.pumpAndSettle(Duration(seconds: 3));

     await tester.tap(find.text("Carpinteria Karol"));
     await tester.pumpAndSettle(Duration(seconds: 3));

     await tester.tap(find.text("Request"));
     await tester.pumpAndSettle(Duration(seconds: 10));

     await tester.tap(find.text("Request"));
     await tester.pumpAndSettle(Duration(seconds: 5));

     await tester.tap(find.byIcon(Icons.home_outlined));
     await tester.pumpAndSettle(Duration(seconds: 3));
    });


    
   });


    
     

} 

         

   
 
