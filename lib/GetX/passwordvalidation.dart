import 'package:get/get.dart';

class FormX extends GetxController {
  RxString password = ''.obs;
  RxString errorText = RxString(null);
  Rx<Function> submitFunc = Rx<Function>(null);

  @override
  void onInit() {
    super.onInit();
    debounce(password, validations, time: Duration(milliseconds: 10));
  }
  void validations(String val) async {
    errorText.value = null; // reset validation errors to nothing
    submitFunc.value = null; // disable submit while validating
    if (val.isNotEmpty) {
      if (lower(val) && upper(val) && numbe(val) && lengthOK(val)) {
        print('All validations passed, enable submit btn...');
        //submitFunc.value = submitFunction();
        errorText.value = null;
      }
    }
  }

  bool lower(String val){
    if(!RegExp(r'^(?=.*?[a-z])').hasMatch(val)){
      //errorText.value = 'enter at list lowerchar';
      return false;
    }
    return true;
  }
  bool upper(String val){
    if(!RegExp(r'^(?=.*?[A-Z])').hasMatch(val)){
      //errorText.value = 'enter at list upperchar';
      return false;
    }
    return true;
  }
  bool numbe(String val){
    if(!RegExp(r'^(?=.*?[0-9])').hasMatch(val)){
      //errorText.value = 'enter at list one number';
      return false;
    }
    return true;
  }
  bool lengthOK(String val) {
    if (val.length < 8) {
      //errorText.value = 'min. 8 chars';
      return false;
    }
    return true;
  }
  void passwordChanged(String val) {
    password.value = val;
  }
}
/*Future<bool> available(String val) async {
    print('Query availability of: $val');
    await Future.delayed(
        Duration(seconds: 1),
            () => print('Available query returned')
    );

    if (val == "Sylvester") {
      errorText.value = 'Name Taken';
      return false;
    }
    return true;
  }*/
/*Future<bool> Function() submitFunction() {
    return () async {
      print('Make database call to create ${username.value} account');
      await Future.delayed(Duration(seconds: 1), () => print('User account created'));
      return true;
    };
  }*/