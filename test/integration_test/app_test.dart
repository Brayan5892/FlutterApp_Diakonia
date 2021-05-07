import 'package:diakonia/main.dart' as app;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
group('integration test', () {
IntegrationTestWidgetsFlutterBinding.ensureInitialized();
testWidgets("login with correct email and password", 
(tester) async {

    app.main();
   
    await tester.pumpAndSettle();
    final emailField = find.byKey(Key("emailLogin"));
    final passwordField = find.byKey(Key("passwordLogin"));
    final signInButton = find.text("Log in");
    
    await tester.enterText(emailField, "Brayaaan@gmail.com");
    await tester.enterText(passwordField, "zxcasdqwe123");
    await tester.pumpAndSettle(Duration(seconds: 5));

    await tester.tap(signInButton);
    await tester.pumpAndSettle(Duration(seconds: 5));
    
    

});
});
} 

         
   
   
 




