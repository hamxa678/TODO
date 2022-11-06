import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseex/UserModel.dart';
import 'package:firebaseex/home/home.dart';
import 'package:firebaseex/utils/utils.dart';
import 'package:flutter/material.dart';

class SignupModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  bool loading = false;
  final usernamecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  bool flag = true;

  signUp(BuildContext context) {
    _auth
        .createUserWithEmailAndPassword(
            email: emailcontroller.text.toString(),
            password: passwordcontroller.text.toString())
        .then((value) {
      addUserName();
      Utils().toastMessage(
          "${value.user!.email} with user name ${usernamecontroller.text} is signed up successfully");
      inverseLoading();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    }).onError((error, stackTrace) {
      inverseLoading();
      Utils().toastMessage(error.toString());
    });
    notifyListeners();
  }

  addUserName() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel usermodel = UserModel();
    usermodel.username = usernamecontroller.text;

    await firebaseFirestore
        .collection("user")
        .doc(user!.uid)
        .set(usermodel.toMap());
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
