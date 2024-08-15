import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hinttext;
  final bool obscureText;
  final TextEditingController controller;
  final FocusNode? focusNode;
  const MyTextField(
      {super.key,
      required this.hinttext,
      required this.obscureText,
      required this.controller,
      required this.focusNode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        obscureText: obscureText,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.secondary)),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.primary)),
            fillColor: Theme.of(context).colorScheme.secondary,
            filled: true,
            hintText: hinttext,
            hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary)),
      ),
    );
  }
}
