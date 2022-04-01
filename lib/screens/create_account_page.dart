// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../cubit/create_account_cubit.dart';
import '../data/authentication_repository.dart';
import '../models/create_account_state.dart';
import '../utils/custom_icons.dart';
import '../widgets/input.dart';
import '../widgets/screen.dart';

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({
    Key key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Screen(
      backgroundColor: const Color(0xFF113654),
      body: const CreateAccountScreen(),
    );
  }
}

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const IconData chevron_left =
        IconData(0xe15e, fontFamily: 'MaterialIcons', matchTextDirection: true);
    return Stack(
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
                padding: EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0),
                child: _EmailInput(),
                // child: TextField(
                //   controller: emailController,
                //   keyboardType: TextInputType.emailAddress,
                //   onChanged: (value) {
                //     email = value;
                //   },
                //   decoration: const InputDecoration(
                //     labelText: "Email",
                //     filled: true,
                //     fillColor: Colors.white12,
                //     labelStyle: TextStyle(color: Colors.white),
                //   ),
                // ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
                child: _PasswordInput(),
                // child: TextField(
                //   controller: passwordController,
                //   keyboardType: TextInputType.visiblePassword,
                //   obscureText: true,
                //   onChanged: (value) {
                //     password = value;
                //   },
                //   decoration: const InputDecoration(
                //     labelText: "Password",
                //     filled: true,
                //     fillColor: Colors.white12,
                //     labelStyle: TextStyle(color: Colors.white),
                //   ),
                // ),
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
                      context
                          .read<CreateAccountCubit>()
                          .signUpWithEmailAndPassword();
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
                        context.read<CreateAccountCubit>().signUpWithGoogle();
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
                            .read<CreateAccountCubit>()
                            .signUpWithGitHub(context);
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
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ControlledInput<CreateAccountCubit, CreateAccountState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (dispatch, state) {
        return Input(
          label: "Email",
          autocorrect: false,
          inputType: TextInputType.emailAddress,
          onChanged: (newEmail) {
            dispatch.onEmailChanged(newEmail);
          },
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ControlledInput<CreateAccountCubit, CreateAccountState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (dispatch, state) {
        return PasswordInput(
          label: "Password",
          onChanged: (newPassword) {
            dispatch.onPasswordChanged(newPassword);
          },
        );
      },
    );
  }
}
