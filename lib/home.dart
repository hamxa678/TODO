import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseex/UserModel.dart';
import 'package:firebaseex/login/login.dart';
import 'package:firebaseex/utils/utils.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User? user = FirebaseAuth.instance.currentUser;

  UserModel userModel = UserModel();
  final todocontroller = TextEditingController();
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("user")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.userModel = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance
        .collection("user")
        .doc(user!.uid)
        .collection('todos')
        .snapshots();
    CollectionReference ref = FirebaseFirestore.instance
        .collection("user")
        .doc(user!.uid)
        .collection('todos');
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Hello! ",
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
                (userModel.username == null)
                    ? CircularProgressIndicator()
                    : Expanded(
                        child: Text(
                          "${userModel.username}",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                      ),
                GestureDetector(
                  onTap: () async {
                    await FirebaseAuth.instance.signOut().then((value) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LogIn()));
                    });
                  },
                  child: Icon(
                    Icons.logout,
                    color: Colors.blue,
                    size: 20,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            RichText(
              text: TextSpan(
                  text: "Good ",
                  style: TextStyle(fontSize: 30, color: Colors.blue),
                  children: [
                    TextSpan(
                      text: label(),
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    )
                  ]),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    //color: Colors.grey.shade200,
                    // borderRadius: BorderRadius.all(Radius.circular(10),),
                    ),
                child: StreamBuilder<QuerySnapshot>(
                  stream: firestore,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Dismissible(
                              background: Container(
                                margin: EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                              onDismissed: (DismissDirection direction) {
                                ref
                                    .doc(snapshot.data!.docs[index]['id']
                                        .toString())
                                    .delete()
                                    .then((value) {
                                  Utils().toastMessage(
                                      "TODO deleted from database");
                                });
                              },
                              key: UniqueKey(),
                              child: Container(
                                padding: EdgeInsets.all(5),
                                margin: EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: ListTile(
                                  leading: Checkbox(
                                      value: snapshot.data!.docs[index]
                                          ['status'],
                                      onChanged: (Value) {
                                        ref
                                            .doc(snapshot
                                                .data!.docs[index]['id']
                                                .toString())
                                            .update({"status": Value}).then(
                                                (value) {
                                          Utils().toastMessage((Value == true)
                                              ? "TODO is marked completed"
                                              : "TODO is marked incompleted");
                                        });
                                      }),
                                  title: (snapshot.data!.docs[index]
                                              ['status'] ==
                                          true)
                                      ? Text(
                                          "${snapshot.data!.docs[index]['todo']}",
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough),
                                        )
                                      : Text(
                                          "${snapshot.data!.docs[index]['todo']}"),
                                ),
                              ),
                            );
                          });
                    }
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextField(
                controller: todocontroller,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        (todocontroller.text.isEmpty)
                            ? Utils().toastMessage("Field is Empty.")
                            : addTodo();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                      // Icon(
                      //   Icons.visibility,
                      //   color: Colors.blue,
                      // ),
                    ),
                    prefixIcon: Icon(
                      Icons.add_task_rounded,
                      color: Colors.blue,
                    ),
                    labelText: 'Add TODO',
                    labelStyle: TextStyle(color: Colors.grey),
                    hintText: 'Add your TODO'),
                autofillHints: const ["Email", "Email Address"],
              ),
            ),
          ],
        ),
      )
          // Center(
          //   child: const Text(
          //     "HOME",
          //     style: TextStyle(
          //         fontSize: 50, fontWeight: FontWeight.bold, color: Colors.blue),
          //   ),
          // ),
          ),
    );
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

  addTodo() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseFirestore FBFS = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    print("${todocontroller.text}");
    print("${user!.email}");
    TodoModel todoModel = TodoModel();
    todoModel.todo = todocontroller.text;
    todoModel.status = false;
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    todoModel.id = id;
    await FBFS
        .collection("user")
        .doc(user.uid)
        .collection('todos')
        .doc(id)
        .set(todoModel.toMap())
        .then((value) {
      Utils().toastMessage("TODO is uploaded successfully");
    });
    todocontroller.clear();
    //await FBFS.collection("user").doc(user!.uid).set(usermodel.toMap());
  }

  showTodos() {
    final firestore = FirebaseFirestore.instance
        .collection("user")
        .doc(user!.uid)
        .collection('todos')
        .snapshots();
    StreamBuilder<QuerySnapshot>(
      stream: firestore,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  background: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  onDismissed: (DismissDirection direction) {},
                  key: ValueKey<int>(1),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.add),
                      subtitle: Text("SubTitle"),
                      title: Text("${snapshot.data!.docs[index]['todo']}"),
                    ),
                  ),
                );
              });
        }
      },
    );
  }

  showTodos1() {
    return ListView.builder(
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            background: Container(
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
            onDismissed: (DismissDirection direction) {},
            key: ValueKey<int>(1),
            child: Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: ListTile(
                leading: Icon(Icons.add),
                subtitle: Text("SubTitle"),
                title: Text(
                    "hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello "),
              ),
            ),
          );
        });
  }
}






  // Widget? getUserName() {
  //   StreamBuilder(
  //     stream: FBFS,
  //     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return CircularProgressIndicator();
  //       } else {
  //         return Text(
  //           "${snapshot.data!.docs[user!.uid]['username']}",
  //           style: TextStyle(
  //               fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blue),
  //         );
  //       }
  //       ;
  //     },
  //   );
  //   User? user = FirebaseAuth.instance.currentUser;
  // }