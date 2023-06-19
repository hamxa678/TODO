import 'package:firebaseex/login/login.dart';
import 'package:firebaseex/signup/signup_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../custom/custom_widget.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignupModel(),
      child: Consumer<SignupModel>(
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
                    text: "SIGNUP",
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  CustomTextFieldTwo(
                    controller: value.usernamecontroller,
                    labelText: 'User Name',
                    hintText: "Enter Your User Name",
                    prefixIcon: Icons.person_outline_outlined,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFieldTwo(
                    controller: value.emailcontroller,
                    labelText: 'Email',
                    hintText: "Enter Your Email",
                    prefixIcon: Icons.alternate_email_outlined,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFieldTwo(
                      controller: value.passwordcontroller,
                      labelText: 'Password',
                      hintText: "Enter Your Password",
                      prefixIcon: Icons.password_rounded,
                      suffixIcon:
                          value.flag ? Icons.visibility : Icons.visibility_off,
                      obscureText: value.flag,
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
                            "Signup",
                            style: TextStyle(color: Colors.white),
                          ),
                    buttonAction: () {
                      value.inverseLoading();
                      value.signUp(context);
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("LogIn"))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
