import 'package:firebaseex/home.dart';
import 'package:firebaseex/login/login_viewmodel.dart';
import 'package:firebaseex/signup.dart';
import 'package:firebaseex/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../custom/custom_widget.dart';

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginModel(),
      child: Consumer<LoginModel>(
        builder: (context, value, child) => Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: value.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomText(
                    text: "LOGIN",
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  CustomTextField(
                    textfieldcontroller: value.emailcontroller,
                    labeltext: 'Email',
                    hinttext: "Enter Your Email",
                    prefexicon: Icons.alternate_email_outlined,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                      textfieldcontroller: value.passwordcontroller,
                      labeltext: 'Password',
                      hinttext: "Enter Your Password",
                      prefexicon: Icons.password_rounded,
                      suffexicon:
                          value.flag ? Icons.visibility : Icons.visibility_off,
                      obsecuretext: value.flag,
                      suffixIconAction: () {
                        value.inverseflag();
                      }),
                  const SizedBox(
                    height: 50,
                  ),
                  CustomElevatedButton(
                    child: value.loading
                        ? const CircularProgressIndicator(
                            strokeWidth: 3,
                            color: Colors.white,
                          )
                        : const Text(
                            "login",
                            style: TextStyle(color: Colors.white),
                          ),
                    buttonAction: () {
                      value.inverseLoading();
                      value.login(context);
                    },
                  ),
                  CustomButtomRow(
                    text: "Don't have an account?",
                    textButtonText: "SignUp",
                    textButtonAction: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
