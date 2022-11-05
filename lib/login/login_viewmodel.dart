import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseex/home.dart';
import 'package:firebaseex/utils/utils.dart';
import 'package:flutter/material.dart';

class LoginModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  bool loading = false;
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  bool flag = true;

  login(BuildContext context) {
    _auth
        .signInWithEmailAndPassword(
            email: emailcontroller.text.toString(),
            password: passwordcontroller.text.toString())
        .then((value) {
      Utils().toastMessage("${value.user!.email} logged in successfully");
      inverseLoading();
      notifyListeners();
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    }).onError((error, stackTrace) {
      inverseLoading();
      notifyListeners();
      Utils().toastMessage(error.toString());
    });
    notifyListeners();
  }

  inverseLoading() {
    loading = !loading;
    notifyListeners();
  }

  inverseflag() {
    flag = !(flag);
    notifyListeners();
  }
}
