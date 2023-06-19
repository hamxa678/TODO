import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseex/home/home.dart';
import 'package:firebaseex/login/login.dart';
import 'package:firebaseex/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'TODO',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home:
          // SignUp(),
          // const Home()
          // LogIn(),
          user != null ? const Home() : const LogIn(),
    );
  }
}
