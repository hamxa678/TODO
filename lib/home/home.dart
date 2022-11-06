import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseex/home/home_viewmodel.dart';
import 'package:firebaseex/login/login.dart';
import 'package:firebaseex/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../custom/custom_widget.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeModel(),
      child: Consumer<HomeModel>(
        builder: (context, value, child) => SafeArea(
          child: Scaffold(
              body: Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Hello! ",
                      style: TextStyle(fontSize: 20, color: Colors.blue),
                    ),
                    (value.username == null)
                        ? const CircularProgressIndicator()
                        : Expanded(
                            child: Text(
                              "${value.username}",
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                          ),
                    GestureDetector(
                      onTap: () async {
                        await FirebaseAuth.instance.signOut().then((value) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LogIn()));
                        });
                      },
                      child: const Icon(
                        Icons.logout,
                        color: Colors.blue,
                        size: 20,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(
                      text: "Good ",
                      style: const TextStyle(fontSize: 30, color: Colors.blue),
                      children: [
                        TextSpan(
                          text: value.label(),
                          style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        )
                      ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: value.firestore,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Dismissible(
                                  background: Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    decoration: const BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                  ),
                                  onDismissed: (DismissDirection direction) {
                                    value.ref!
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
                                    padding: const EdgeInsets.all(5),
                                    margin: const EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: ListTile(
                                      leading: Checkbox(
                                          value: snapshot.data!.docs[index]
                                              ['status'],
                                          onChanged: (Value) {
                                            value.ref!
                                                .doc(snapshot
                                                    .data!.docs[index]['id']
                                                    .toString())
                                                .update({"status": Value}).then(
                                                    (value) {
                                              Utils().toastMessage((Value ==
                                                      true)
                                                  ? "TODO is marked completed"
                                                  : "TODO is marked incompleted");
                                            });
                                          }),
                                      title: (snapshot.data!.docs[index]
                                                  ['status'] ==
                                              true)
                                          ? Text(
                                              "${snapshot.data!.docs[index]['todo']}",
                                              style: const TextStyle(
                                                  decoration: TextDecoration
                                                      .lineThrough),
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
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  textfieldcontroller: value.todocontroller,
                  labeltext: 'Add TODO',
                  hinttext: "Add your TODO",
                  prefexicon: Icons.add_task_rounded,
                  suffexicon: Container(
                    decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                  suffixIconAction: () {
                    (value.todocontroller.text.isEmpty)
                        ? Utils().toastMessage("Field is Empty.")
                        : value.addTodo();
                  },
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
