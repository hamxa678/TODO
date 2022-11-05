import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {required this.textfieldcontroller,
      required this.labeltext,
      required this.hinttext,
      required this.prefexicon,
      this.obsecuretext = false,
      this.suffexicon,
      this.suffixIconAction});
  final TextEditingController textfieldcontroller;
  final String labeltext;
  final String hinttext;
  final IconData prefexicon;
  IconData? suffexicon;
  bool obsecuretext;
  VoidCallback? suffixIconAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
          controller: textfieldcontroller,
          decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(
                prefexicon,
                color: Colors.blue,
              ),
              suffixIcon: GestureDetector(
                onTap: suffixIconAction,
                child: Icon(
                  suffexicon,
                  color: Colors.blue,
                ),
              ),
              labelText: labeltext,
              labelStyle: const TextStyle(color: Colors.grey),
              hintText: hinttext),
          obscureText: obsecuretext,
          obscuringCharacter: "*"),
    );
  }
}

class CustomText extends StatelessWidget {
  const CustomText({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 50, fontWeight: FontWeight.bold, color: Colors.blue),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton({super.key, this.buttonAction, required this.child});
  VoidCallback? buttonAction;
  Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
        onPressed: buttonAction,
        child: child,
      ),
    );
  }
}

class CustomButtomRow extends StatelessWidget {
  CustomButtomRow(
      {super.key,
      required this.text,
      required this.textButtonText,
      this.textButtonAction});
  final String text;
  final String textButtonText;
  VoidCallback? textButtonAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text),
        TextButton(onPressed: textButtonAction, child: Text(textButtonText))
      ],
    );
  }
}