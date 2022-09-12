import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../common/bloc/user/user_bloc.dart';
import '../../common/bloc/user/user_state.dart';
import '../../common/services/authentication_repository.dart';
import '../../styles/theme_colors.dart';
import '../../widgets/button.dart';
import '../../widgets/default_text.dart';
import '../../widgets/pin_card.dart';
import '../../widgets/screen/screen.dart';
import '../../widgets/view/keyboard_avoiding.dart';
import 'profile_page_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfilePageCubit(),
      child: Screen(
        body: const ProfileScreen(),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(children: const [
        _Toolbar(),
        _MainHeader(),
        SizedBox(height: 20.0),
        _ProfileOptions(),
      ]),
    );
  }
}

class _Toolbar extends StatelessWidget {
  const _Toolbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.arrow_back, size: 25.0),
          ),
        ],
      ),
    );
  }
}

class _MainHeader extends StatelessWidget {
  const _MainHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfilePageCubit, ProfilePageCubitState>(
      builder: (context, state) {
        return Column(children: [
          if (state.name != null)
            CircleAvatar(
              radius: 70,
              backgroundColor: Colors.white,
              child: DefaultText(
                state.initials ?? "",
                textLevel: TextLevel.h2,
                color: ThemeColors.StadiumOrange,
                fontSize: 48,
              ),
            ),
          if (state.name == null)
            CircleAvatar(
              radius: 70,
              backgroundColor: Colors.white,
              child: SvgPicture.asset(
                "assets/icons/person.svg",
                color: ThemeColors.StadiumOrange,
                width: 80,
                height: 80,
              ),
            ),
          const SizedBox(height: 10.0),
          DefaultText(
            state.name ?? "Hacker",
            textAlign: TextAlign.center,
            maxLines: 2,
            fontSize: 32,
            textLevel: TextLevel.h1,
          ),
          DefaultText(
            state.email ?? "",
            textLevel: TextLevel.caption,
            fontSize: 16,
          ),
        ]);
      },
    );
  }
}

class _ProfileOptions extends StatelessWidget {
  const _ProfileOptions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 25.0,
      ),
      child: Column(
        children: [
          Button(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              ),
            ),
            variant: ButtonVariant.TextButton,
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) => _ChangePassword(),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DefaultText("Change Password"),
                const Icon(Icons.arrow_forward, size: 25.0),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Button(
            onPressed: () {
              if (context.read<UserBloc>().state.pin != "") {
                showGeneralDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierLabel: MaterialLocalizations.of(context)
                      .modalBarrierDismissLabel,
                  barrierColor: Colors.black45,
                  transitionDuration: const Duration(milliseconds: 200),
                  pageBuilder: (BuildContext buildContext, animation,
                      secondaryAnimation) {
                    return const QRScreen();
                  },
                );
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              ),
            ),
            variant: ButtonVariant.TextButton,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<UserBloc, UserState>(
                  buildWhen: (previous, current) =>
                      previous != null &&
                      current != null &&
                      previous.pin != current.pin,
                  builder: (context, state) {
                    return DefaultText(
                      "View Pin: ${state.pin}",
                      color: Colors.blue,
                    );
                  },
                ),
                const Icon(
                  Icons.arrow_forward,
                  size: 25.0,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Button(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                ThemeColors.StadiumOrange,
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              ),
            ),
            variant: ButtonVariant.TextButton,
            onPressed: () {
              context.read<AuthenticationRepository>().signOut();
            },
            child: Center(
              child: DefaultText("Logout", color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChangePassword extends StatelessWidget {
  const _ChangePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    return BlocBuilder<ProfilePageCubit, ProfilePageCubitState>(
      builder: (context, state) {
        return KeyboardAvoiding(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 30.0,
              horizontal: 20.0,
            ),
            child: Column(
              children: [
                const SizedBox(height: 20.0),
                TextFormField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  autovalidateMode: AutovalidateMode.always,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: ThemeColors.HackyBlue,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(80),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: ThemeColors.HackyBlue,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(80),
                    ),
                    hintText: "Enter your old password",
                    labelText: 'Old Password',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: ThemeColors.StadiumOrange,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(80),
                    ),
                  ),
                  onChanged:
                      context.read<ProfilePageCubit>().onChangeOldPassword,
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  autovalidateMode: AutovalidateMode.always,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: ThemeColors.HackyBlue,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(80),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: ThemeColors.HackyBlue,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    hintText: "Enter your new password",
                    labelText: 'New Password',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: ThemeColors.StadiumOrange,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  onChanged:
                      context.read<ProfilePageCubit>().onChangeNewPassword,
                ),
                const SizedBox(height: 20.0),
                Button(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      ThemeColors.HackyBlue,
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 20.0),
                    ),
                  ),
                  variant: ButtonVariant.TextButton,
                  onPressed: () async {
                    await context.read<ProfilePageCubit>().changePassword();
                    navigator.pop();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DefaultText(
                        "Submit",
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
