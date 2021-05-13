import 'package:diakonia/pages/addService/addService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main(){
  group('Integration test',(){
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets("add service page", (tester)async{
      await tester.pumpWidget(addService());
      //pruebas dropdown button------------------------------------------
      await tester.tap(find.text('Categories'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Carpenter').last);
      await tester.pumpAndSettle(Duration(seconds: 2));
      //pruebas text field nombre----------------------------------------
      var input='nombre prueba';
      await tester.enterText(find.widgetWithText(TextField, 'Name'), input);
      await tester.pump();

      input='666';
      await tester.enterText(find.widgetWithText(TextField, 'Price'), input);
      await tester.pump();

      input='descripcion prueba';
      await tester.enterText(find.widgetWithText(TextField, 'Description'), input);
      await tester.pump();

      input='ubicacion prueba';
      await tester.enterText(find.widgetWithText(TextField, 'Location'), input);
      await tester.pump();      
      //prueba para obtener geopunto del mapa---------------------------
      await tester.tap(find.widgetWithText(ElevatedButton, 'pick location'));  
      await tester.pumpAndSettle(Duration(seconds: 5));
      
      await tester.longPressAt(Offset(270,700));
      await tester.pump();   

      await tester.tap(find.byIcon(Icons.keyboard_return));//esto puede fallar  
      await tester.pump(); 
      //prueba para agregar el servicio y terminar----------------------
      await tester.tap(find.widgetWithText(ElevatedButton, 'AddService'));  
      await tester.pump(); 
      //resultados------------------------------------------------------
      expect(find.text('Carpenter'), findsOneWidget);
      expect(find.text('nombre prueba'), findsOneWidget);
      expect(find.text('666'), findsOneWidget);
      expect(find.text('descripcion prueba'), findsOneWidget);
      expect(find.text('ubicacion prueba'), findsOneWidget);
    });
  });
}