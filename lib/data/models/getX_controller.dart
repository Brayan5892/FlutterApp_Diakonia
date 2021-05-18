import 'package:get/state_manager.dart';

class SimpleGetXController extends GetxController{
  var _email = "".obs;
  var _password = "".obs;

  setEmail(email){
    _email.value=email;
  }

  setPassword(password){
    _password.value = password;
  }


  
}