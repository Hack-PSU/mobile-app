// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../data/authentication_service.dart';
import '../utils/custom_icons.dart';

class CreateAccount extends StatelessWidget {
  CreateAccount({Key key}) : super(key: key);

  static const IconData chevron_left =
      IconData(0xe15e, fontFamily: 'MaterialIcons', matchTextDirection: true);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String email, password;
  // TODO -- auth can be obtained through AuthRepository instead
  // TODO -- create a CreateAccountCubit and build page using BlocBuilder
  // TODO -- wrap email and password within the cubit state and just call
  // TODO -- authRepository from cubit using the email and password states
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF113654),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 200,
              alignment: Alignment.bottomCenter,
              color: const Color(0xFF113654),
              child: SvgPicture.asset(
                'assets/images/mountain.svg',
                alignment: Alignment.bottomCenter,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: TextButton(
                      child: Row(
                        children: const [
                          Icon(chevron_left),
                          Text(
                            "BACK",
                          ),
                        ],
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      color: Colors.white12,
                      image: DecorationImage(
                        image: AssetImage('assets/images/Logo.png'),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 50.0, left: 20.0),
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "SIGN UP",
                    style: TextStyle(
                      fontSize: 36.0,
                      fontFamily: 'Cornerstone',
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0),
                  child: TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: const InputDecoration(
                      labelText: "Email",
                      filled: true,
                      fillColor: Colors.white12,
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
                  child: TextField(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: const InputDecoration(
                      labelText: "Password",
                      filled: true,
                      fillColor: Colors.white12,
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 300),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFF4603D),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.5),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.send),
                      iconSize: 20,
                      color: Colors.white,
                      onPressed: () {
                        context.read<AuthenticationService>().signIn(
                              emailController.text.trim(),
                              passwordController.text.trim(),
                            );
                      },
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.00),
                  child: Column(
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(CustomIcons.google),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 37),
                        ),
                        onPressed: () {
                          context
                              .read<AuthenticationService>()
                              .signInWithGoogle();
                        },
                        label: const Text('Sign up with Google'),
                      ),
                      ElevatedButton.icon(
                        icon: const Icon(CustomIcons.github),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 37),
                          primary: Colors.black,
                        ),
                        onPressed: () {
                          context
                              .read<AuthenticationService>()
                              .signInWithGitHub(context);
                        },
                        label: const Text('Sign up with GitHub'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
