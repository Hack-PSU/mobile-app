import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackpsu/custom_icons.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import './authentication_service.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 200,
              alignment: Alignment.bottomCenter,
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
                  padding: EdgeInsets.only(top: 50.0),
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      color: Colors.black12,
                      image: DecorationImage(
                        image: AssetImage('assets/images/Logo.png'),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 50.0, left: 20.0),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "LOGIN",
                    style: TextStyle(
                      fontSize: 36.0,
                      fontFamily: 'Cornerstone',
                      color: Color(0xFF113654),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0),
                  child: TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email",
                      filled: true,
                      fillColor: Colors.black12,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
                  child: TextField(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      filled: true,
                      fillColor: Colors.black12,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 100),
                      child: TextButton(
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(
                            fontFamily: 'SpaceGrotesk',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    TextButton(
                      child: Text(
                        'Create account',
                        style: TextStyle(
                          fontFamily: 'SpaceGrotesk',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 300),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFF4603D),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.5),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(Icons.send),
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
                  padding: EdgeInsets.only(top: 15),
                  width: 360,
                  child: ElevatedButton.icon(
                    icon: Icon(CustomIcons.google),
                    onPressed: () {},
                    label: Text('Sign in with Google'),
                  ),
                ),
              ],
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
