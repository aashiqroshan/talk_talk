import 'package:flutter/material.dart';
import 'package:talk_talk/services/auth/auth_service.dart';
import 'package:talk_talk/components/my_button.dart';
import 'package:talk_talk/components/my_textfield.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final void Function()? onTap;
  LoginPage({super.key, required this.onTap});

  void login(BuildContext context) async {
    final authService = AuthService();
    try {
      await authService.signInWithEmailPassword(
          _emailController.text, _passwordcontroller.text);
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(title: Text(e.toString()),),
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
              controller: _emailController,
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
              height: 25,
            ),

            // login button

            MyButton(
              text: 'Login',
              onTap: () => login(context),
            ),
            //register
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('not a member ?'),
                GestureDetector(
                    onTap: onTap,
                    child: const Text(
                      'Register now',
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
