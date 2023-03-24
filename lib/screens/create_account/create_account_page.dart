import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../common/bloc/auth/auth_bloc.dart';
import '../../common/services/authentication_repository.dart';
import '../../styles/theme_colors.dart';
import '../../widgets/custom_icons.dart';
import '../../widgets/default_text.dart';
import '../../widgets/input.dart';
import '../../widgets/loading.dart';
import '../../widgets/screen/screen.dart';
import '../../widgets/view/keyboard_avoiding.dart';
import 'create_account_page_cubit.dart';

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateAccountPageCubit>(
      create: (context) => CreateAccountPageCubit(
        context.read<AuthenticationRepository>(),
        context.read<AuthBloc>(),
      ),
      child: BlocBuilder<CreateAccountPageCubit, CreateAccountPageCubitState>(
        builder: (context, state) {
          if (state.status == FormzSubmissionStatus.inProgress) {
            return const Loading(label: "Creating Account...", repeat: true);
          }
          return Screen(
            withDismissKeyboard: true,
            safeAreaBottom: false,
            body: const CreateAccountScreen(),
          );
        },
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
                // BlocBuilder<CreateAccountPageCubit,
                //     CreateAccountPageCubitState>(
                //   buildWhen: (previous, current) =>
                //       previous != null &&
                //       current != null &&
                //       previous.error != current.error,
                //   builder: (context, state) {
                //     return Row(
                //       children: [
                //         if (state.error != null) ...[
                //           const Padding(
                //             padding: EdgeInsets.only(
                //                 top: 14.0, left: 20.0, right: 5.0),
                //             child: Icon(
                //               Icons.error,
                //               size: 23.0,
                //               color: Colors.red,
                //             ),
                //           ),
                //           Padding(
                //             padding:
                //                 const EdgeInsets.only(top: 10.0, right: 5.0),
                //             child: DefaultText(
                //               state.error ?? "",
                //               color: Colors.red,
                //               weight: FontWeight.w600,
                //             ),
                //           ),
                //         ]
                //       ],
                //     );
                //   },
                // ),
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.only(right: 23.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
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
                          onPressed: () async {
                            await context
                                .read<CreateAccountPageCubit>()
                                .signUpWithEmailAndPassword();
                          },
                        ),
                      ),
                    ],
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
            onPressed: context.read<CreateAccountPageCubit>().signUpWithGoogle,
            label: const Text('Sign up with Google'),
          ),
          ElevatedButton.icon(
            icon: const Icon(CustomIcons.github),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 37),
            ),
            onPressed: () => context
                .read<CreateAccountPageCubit>()
                .signUpWithGitHub(context),
            label: const Text('Sign up with GitHub'),
          ),
          if (Platform.isIOS)
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: SignInWithAppleButton(
                text: "Sign up with Apple",
                onPressed:
                    context.read<CreateAccountPageCubit>().signUpWithApple,
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
    return ControlledInput<CreateAccountPageCubit, CreateAccountPageCubitState>(
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
    return ControlledInput<CreateAccountPageCubit, CreateAccountPageCubitState>(
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
