import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './authentication_service.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: "Email",
            ),
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: "Password",
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<AuthenticationService>().signIn(
                    emailController.text.trim(),
                    passwordController.text.trim(),
                  );
            },
            child: Text("Sign in"),
          ),
          MaterialButton(
            onPressed: () {
              context.read<AuthenticationService>().signInWithGoogle();
            },
            color: Colors.white,
            textColor: Colors.blue,
            child: Text("Sign in with Google"),
          ),
          MaterialButton(
            onPressed: () {
              context.read<AuthenticationService>().signInWithGitHub(context);
            },
            color: Colors.black,
            textColor: Colors.white,
            child: Text("Sign in with GitHub"),
          ),
        ],
      ),
    );
  }
}
