// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../common/bloc/auth/auth_bloc.dart';
import '../common/services/authentication_repository.dart';
import '../cubit/create_account_cubit.dart';
import '../models/create_account_state.dart';
import '../styles/theme_colors.dart';
import '../utils/custom_icons.dart';
import '../widgets/default_text.dart';
import '../widgets/input.dart';
import '../widgets/keyboard_avoiding.dart';
import '../widgets/screen.dart';

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Screen(
      withDismissKeyboard: true,
      safeAreaBottom: false,
      body: BlocProvider<CreateAccountCubit>(
        create: (context) => CreateAccountCubit(
          authenticationRepository: context.read<AuthenticationRepository>(),
          authBloc: context.read<AuthBloc>(),
        ),
        child: const CreateAccountScreen(),
      ),
    );
  }
}

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(height: MediaQuery.of(context).size.height),
        Positioned.fill(
          child: SvgPicture.asset(
            'assets/images/mountain.svg',
            alignment: Alignment.bottomCenter,
          ),
        ),
        Positioned.fill(
          child: KeyboardAvoiding(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: TextButton(
                      child: Row(
                        children: const [
                          Icon(Icons.chevron_left),
                          Text(
                            "BACK",
                          ),
                        ],
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.black12,
                    image: const DecorationImage(
                      image: AssetImage("assets/images/Logo.png"),
                    ),
                  ),
                ),
                const SizedBox(height: 23.0),
                Container(
                  padding: const EdgeInsets.only(left: 20.0),
                  alignment: Alignment.topLeft,
                  child: DefaultText(
                    "SIGN UP",
                    textLevel: TextLevel.h2,
                    color: ThemeColors.UniversityBlue,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0),
                  child: _EmailInput(),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
                  child: _PasswordInput(),
                ),
                const SizedBox(height: 10.0),
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
                _SignUpButtons()
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SignUpButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
              context.read<CreateAccountCubit>().signUpWithGitHub(context);
            },
            label: const Text('Sign up with GitHub'),
          ),
          if (Platform.isIOS)
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: SignInWithAppleButton(
                text: "Sign up with Apple",
                onPressed: () {
                  context.read<CreateAccountCubit>().signUpWithApple();
                },
              ),
            ),
        ],
      ),
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
