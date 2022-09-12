import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../common/bloc/auth/auth_bloc.dart';
import '../../common/services/authentication_repository.dart';
import '../../widgets/button.dart';
import '../../widgets/custom_icons.dart';
import '../../widgets/default_text.dart';
import '../../widgets/input.dart';
import '../../widgets/screen/screen.dart';
import '../../widgets/view/keyboard_avoiding.dart';
import 'sign_in_page_cubit.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Screen(
      withDismissKeyboard: true,
      safeAreaBottom: false,
      safeAreaTop: false,
      body: const SignInScreen(),
    );
  }
}

class SignInScreen extends StatelessWidget {
  const SignInScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInPageCubit>(
      create: (context) => SignInPageCubit(
        context.read<AuthenticationRepository>(),
        context.read<AuthBloc>(),
      ),
      child: Stack(
        children: [
          Container(height: MediaQuery.of(context).size.height),
          // refer to this code to resolve bottom positioning
          // https://stackoverflow.com/questions/51230076/background-image-at-bottom-of-screen-in-flutter-app
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/images/mountain.svg',
              alignment: Alignment.bottomCenter,
            ),
          ),
          Positioned.fill(
            // refer to this code to fix single child scroll view for text field
            // http://www.engincode.com/flutter-stack-positioned-column-scroll-doesnt-work
            child: KeyboardAvoiding(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        color: Colors.black12,
                        image: DecorationImage(
                          image: AssetImage("assets/images/Logo.png"),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 50.0, left: 20.0),
                    alignment: Alignment.topLeft,
                    child: DefaultText(
                      "LOGIN",
                      textLevel: TextLevel.h2,
                      color: const Color(0xFF113654),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 5.0, left: 20.0, right: 20.0),
                    child: _EmailInput(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 15.0, left: 20.0, right: 20.0),
                    child: _PasswordInput(),
                  ),
                  BlocBuilder<SignInPageCubit, SignInPageCubitState>(
                    buildWhen: (previous, current) =>
                        previous != null &&
                        current != null &&
                        previous.error != current.error,
                    builder: (context, state) {
                      return Row(
                        children: [
                          if (state.error != null)
                            const Padding(
                              padding: EdgeInsets.only(
                                  top: 14.0, left: 20.0, right: 5.0),
                              child: Icon(
                                Icons.error,
                                size: 23.0,
                                color: Colors.red,
                              ),
                            ),
                          if (state.error != null)
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, right: 5.0),
                              child: DefaultText(
                                state.error ?? "",
                                color: Colors.red,
                                weight: FontWeight.w600,
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Button(
                          variant: ButtonVariant.TextButton,
                          onPressed:
                              context.read<SignInPageCubit>().forgotPassword,
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              const Color(0x00FAFAFA),
                            ),
                          ),
                          child: DefaultText(
                            "Forgot password?",
                            textLevel: TextLevel.button,
                          ),
                        ),
                        Button(
                          variant: ButtonVariant.TextButton,
                          onPressed: () {
                            Navigator.of(context).pushNamed("signUp");
                            // _navigateCreatAccount(context)
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              const Color(0x00FAFAFA),
                            ),
                          ),
                          child: DefaultText(
                            "Create account",
                            textLevel: TextLevel.button,
                          ),
                        ),
                      ],
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
                      child: Button(
                        variant: ButtonVariant.IconButton,
                        icon: const Icon(Icons.send),
                        iconSize: 20,
                        color: Colors.white,
                        onPressed: context
                            .read<SignInPageCubit>()
                            .signInWithEmailAndPassword,
                      ),
                    ),
                  ),
                  _SignInButtons(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SignInButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.00),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Button(
            variant: ButtonVariant.ElevatedButton,
            icon: const Icon(CustomIcons.google),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 37),
            ),
            onPressed: context.read<SignInPageCubit>().signInWithGoogle,
            child: DefaultText(
              "Sign in with Google",
            ),
          ),
          Button(
            variant: ButtonVariant.ElevatedButton,
            icon: const Icon(CustomIcons.github),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 37),
              primary: Colors.black,
            ),
            onPressed: () =>
                context.read<SignInPageCubit>().signInWithGitHub(context),
            child: DefaultText(
              "Sign in with GitHub",
            ),
          ),
          if (Platform.isIOS)
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: SignInWithAppleButton(
                onPressed: context.read<SignInPageCubit>().signInWithApple,
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
    return ControlledInput<SignInPageCubit, SignInPageCubitState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (dispatch, state) {
        return Input(
          label: "Email",
          autocorrect: false,
          inputType: TextInputType.emailAddress,
          onChanged: dispatch.onEmailChanged,
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ControlledInput<SignInPageCubit, SignInPageCubitState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (dispatch, state) {
        return PasswordInput(
          label: "Password",
          onChanged: dispatch.onPasswordChanged,
        );
      },
    );
  }
}
