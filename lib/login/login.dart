import 'package:firebaseex/login/login_viewmodel.dart';
import 'package:firebaseex/signup/signup.dart';
import 'package:flutter/material.dart';
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
            child:
                //  Text("Login"),
                Form(
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
                  CustomTextFieldTwo(
                      controller: value.emailcontroller,
                      labelText: 'Email',
                      hintText: "Enter Your Email",
                      prefixIcon: Icons.alternate_email_outlined),
                  // CustomTextField(
                  //   textfieldcontroller: value.emailcontroller,
                  //   labeltext: 'Email',
                  //   hinttext: "Enter Your Email",
                  //   prefexicon: Icons.alternate_email_outlined,
                  //   // obsecuretext: false,
                  //   // suffexicon: value.flag
                  //   //     ? const Icon(Icons.visibility)
                  //   //     : const Icon(Icons.visibility_off),
                  // ),
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUp()));
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

class CustomTextFieldTwo extends StatelessWidget {
  CustomTextFieldTwo(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.hintText,
      required this.prefixIcon,
      this.suffixIcon,
      this.obscureText,
      this.suffixIconAction,
      this.onSubmitted});
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final IconData prefixIcon;
  IconData? suffixIcon;
  bool? obscureText;
  VoidCallback? suffixIconAction;
  Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 65,
      child: TextField(
        controller: controller,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            prefixIcon,
            color: Colors.blue,
          ),
          suffixIcon: GestureDetector(
            onTap: suffixIconAction,
            child: Icon(
              suffixIcon,
              color: Colors.blue,
            ),
          ),
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.grey),
          hintText: hintText,
        ),
        obscureText: obscureText ?? false,
        obscuringCharacter: "*",
      ),
    );
  }
}
