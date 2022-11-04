import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseex/UserModel.dart';
import 'package:firebaseex/home.dart';
import 'package:firebaseex/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  bool flag = true;

  final usernamecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "SIGNUP",
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: TextField(
                  controller: usernamecontroller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.person_outline_outlined,
                        color: Colors.blue,
                      ),
                      labelText: 'User Name',
                      labelStyle: TextStyle(color: Colors.grey),
                      hintText: 'Enter Your User Name'),

                  autofillHints: const ["Email", "Email Address"],
                  // obscuringCharacter: "x",
                  // obscureText: true,
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
                  controller: emailcontroller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.alternate_email_outlined,
                        color: Colors.blue,
                      ),
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.grey),
                      hintText: 'Enter Your Email'),

                  autofillHints: const ["Email", "Email Address"],
                  // obscuringCharacter: "x",
                  // obscureText: true,
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
                  controller: passwordcontroller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            flag = !(flag);
                          });
                        },
                        child: Icon(
                          flag ? Icons.visibility : Icons.visibility_off,
                          color: Colors.blue,
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.password_rounded,
                        color: Colors.blue,
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.grey),
                      hintText: 'Enter Your Password'),
                  autofillHints: const ["Email", "Email Address"],
                  obscuringCharacter: "*",
                  obscureText: flag,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  // onPressed: () {
                  //   if (_formKey.currentState!.validate()) {}
                  // },
                  onPressed: () {
                    setState(() {
                      loading = true;
                    });
                    signUp();
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => Home()));
                  },
                  child: loading
                      ? CircularProgressIndicator(
                          strokeWidth: 3,
                          color: Colors.white,
                        )
                      : Text(
                          "SignUp",
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("LogIn"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  addUserName() async {
    FirebaseFirestore FBFS = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel usermodel = UserModel();
    usermodel.username = usernamecontroller.text;

    await FBFS.collection("user").doc(user!.uid).set(usermodel.toMap());
  }

  signUp() {
    _auth
        .createUserWithEmailAndPassword(
            email: emailcontroller.text.toString(),
            password: passwordcontroller.text.toString())
        .then((value) {
      addUserName();
      Utils().toastMessage(value.user!.email.toString() +
          " with user name ${usernamecontroller.text} is signed up successfully");
      setState(() {
        loading = false;
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
      });
      Utils().toastMessage(error.toString());
    });
  }
}
