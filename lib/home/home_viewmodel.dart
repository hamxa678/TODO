import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseex/UserModel.dart';
import 'package:firebaseex/utils/utils.dart';
import 'package:flutter/material.dart';

class HomeModel extends ChangeNotifier {
  User? user = FirebaseAuth.instance.currentUser;
  String? username;
  dynamic firestore;
  CollectionReference? ref;
  final todocontroller = TextEditingController();

  HomeModel() {
    FirebaseFirestore.instance
        .collection("user")
        .doc(user!.uid)
        .get()
        .then((value) {
      userModel = UserModel.fromMap(value.data());
      username = userModel.username;
      notifyListeners();
    });
    firestore = FirebaseFirestore.instance
        .collection("user")
        .doc(user!.uid)
        .collection('todos')
        .snapshots();

    ref = FirebaseFirestore.instance
        .collection("user")
        .doc(user!.uid)
        .collection('todos');
  }

  UserModel userModel = UserModel();

  addTodo() async {
    notifyListeners();
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseFirestore FBFS = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    TodoModel todoModel = TodoModel();
    todoModel.todo = todocontroller.text;
    todoModel.status = false;
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    todoModel.id = id;
    await FBFS
        .collection("user")
        .doc(user!.uid)
        .collection('todos')
        .doc(id)
        .set(todoModel.toMap())
        .then((value) {
      Utils().toastMessage("TODO is uploaded successfully");
    });
    todocontroller.clear();
  }

  String label() {
    int currentTime = DateTime.now().hour;
    if (currentTime > 5 && currentTime <= 12) {
      return 'Morning';
    } else if (currentTime > 12 && currentTime <= 17) {
      return 'Afternoon';
    } else {
      return 'Evening';
    }
  }
}
