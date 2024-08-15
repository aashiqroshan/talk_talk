import 'package:flutter/material.dart';
import 'package:talk_talk/services/auth/auth_service.dart';
import 'package:talk_talk/components/my_button.dart';
import 'package:talk_talk/components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _confirmpasswordcontroller =
      TextEditingController();
  final void Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  void register(BuildContext context) {
    final _auth = AuthService();
    if (_passwordcontroller.text == _confirmpasswordcontroller.text) {
      try {
        _auth.signUpWithEmailPassword(
            _emailcontroller.text, _passwordcontroller.text);
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Passwords don't match"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),

            const SizedBox(
              height: 50,
            ),

            //welcome back
            Text(
              "Welcome back, you've been missed! ",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary, fontSize: 16),
            ),

            const SizedBox(
              height: 25,
            ),

            //textfield

            MyTextField(
              hinttext: 'Email',
              obscureText: false,
              controller: _emailcontroller,
            ),

            const SizedBox(
              height: 10,
            ),

            MyTextField(
              hinttext: 'Password',
              obscureText: true,
              controller: _passwordcontroller,
            ),
            const SizedBox(
              height: 10,
            ),
            MyTextField(
              hinttext: 'Confirm Password',
              obscureText: true,
              controller: _confirmpasswordcontroller,
            ),
            const SizedBox(
              height: 25,
            ),

            // login button

            MyButton(
              text: 'Register ',
              onTap: () => register(context),
            ),
            //register
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('already have an account? '),
                GestureDetector(
                    onTap: onTap,
                    child: const Text(
                      'Login now',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ],
            )
            //
          ],
        ),
      ),
    );
  }
}
