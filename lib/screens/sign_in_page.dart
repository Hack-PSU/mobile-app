import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hackpsu/data/authentication_repository.dart';
import 'package:hackpsu/models/sign_in_state.dart';
import 'package:hackpsu/utils/cubits/sign_in_cubit.dart';
import 'package:hackpsu/utils/custom_icons.dart';
import 'package:hackpsu/widgets/button.dart';
import 'package:hackpsu/widgets/default_text.dart';
import 'package:hackpsu/widgets/input.dart';
import 'package:hackpsu/widgets/screen.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Screen(
      withDismissKeyboard: true,
      withBottomNavigation: false,
      body: BlocProvider<SignInCubit>(
        create: (context) =>
            SignInCubit(context.read<AuthenticationRepository>()),
        child: SignInScreen(),
      ),
    );
  }
}

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
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
                      image: AssetImage("assets/images/Logo.png"),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 50.0, left: 20.0),
                alignment: Alignment.topLeft,
                child: DefaultText(
                  "LOGIN",
                  fontLevel: FontLevel.h2,
                  color: Color(0xFF113654),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0),
                child: _EmailInput(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
                child: _PasswordInput(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Button(
                      variant: ButtonVariant.TextButton,
                      onPressed: () {},
                      child: DefaultText(
                        "Forgot password?",
                        fontLevel: FontLevel.button,
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0x00FAFAFA)),
                      ),
                    ),
                    Button(
                      variant: ButtonVariant.TextButton,
                      child: DefaultText(
                        "Create account",
                        fontLevel: FontLevel.button,
                      ),
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0x00FAFAFA)),
                      ),
                    ),
                  ],
                ),
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
                  child: Button(
                    variant: ButtonVariant.IconButton,
                    icon: Icon(Icons.send),
                    iconSize: 20,
                    color: Colors.white,
                    onPressed: () {
                      context.read<SignInCubit>().signInWithEmailAndPassword();
                    },
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.00),
                child: Column(
                  children: [
                    Button(
                      variant: ButtonVariant.ElevatedButton,
                      icon: Icon(CustomIcons.google),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 37),
                      ),
                      onPressed: () {
                        context.read<SignInCubit>().signInWithGoogle();
                      },
                      child: DefaultText(
                        "Sign in with Google",
                      ),
                    ),
                    Button(
                      variant: ButtonVariant.ElevatedButton,
                      icon: Icon(CustomIcons.github),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 37),
                        primary: Colors.black,
                      ),
                      onPressed: () {
                        context.read<SignInCubit>().signInWithGitHub(context);
                      },
                      child: DefaultText(
                        "Sign in with GitHub",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ControlledInput<SignInCubit, SignInState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (dispatch, state) {
        return Input(
          label: "Email",
          onChanged: (newEmail) {
            dispatch.emailChanged(newEmail);
          },
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ControlledInput<SignInCubit, SignInState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (dispatch, state) {
        return PasswordInput(
          label: "Password",
          onChanged: (newPassword) {
            dispatch.passwordChanged(newPassword);
          },
        );
      },
    );
  }
}
