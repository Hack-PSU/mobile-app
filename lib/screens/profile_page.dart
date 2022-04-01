import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../bloc/user/user_bloc.dart';
import '../card_items/pin_card.dart';
import '../cubit/profile_cubit.dart';
import '../data/authentication_repository.dart';
import '../models/profile_state.dart';
import '../styles/theme_colors.dart';
import '../widgets/button.dart';
import '../widgets/default_text.dart';
import '../widgets/input.dart';
import '../widgets/screen.dart';

class ProfileRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (context) => ProfileCubit(
        context.read<AuthenticationRepository>(),
      ),
      child: Navigator(
        initialRoute: "profile/main",
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case "profile/main":
              builder = (_) => const ProfilePage();
              break;
            case "profile/password":
              // builder = (_) => const ChangePassword();
              break;
            default:
              throw Exception("Invalid route ${settings.name}");
          }
          return MaterialPageRoute(
            builder: builder,
            settings: settings,
          );
        },
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Screen(
      body: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (context) => ProfileCubit(
        context.read<AuthenticationRepository>(),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            _Toolbar(),
            const _MainHeader(),
            const SizedBox(height: 20.0),
            _ProfileOptions(),
          ],
        ),
      ),
    );
  }
}

class _Toolbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 25.0,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.arrow_back,
              size: 25.0,
            ),
          ),
        ],
      ),
    );
  }
}

class _MainHeader extends StatelessWidget {
  const _MainHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, profile) {
        return Column(
          children: [
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
              profile.name ?? "Hacker",
              textAlign: TextAlign.center,
              maxLines: 2,
              fontSize: 32,
              textLevel: TextLevel.h1,
            ),
            DefaultText(
              profile.email,
              textLevel: TextLevel.caption,
              fontSize: 16,
            ),
          ],
        );
      },
    );
  }
}

class _ProfileOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);
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
                  borderRadius: BorderRadius.circular(20.0),
                ),
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
                const Icon(
                  Icons.arrow_forward,
                  size: 25.0,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Button(
            onPressed: () {
              showGeneralDialog(
                context: context,
                barrierDismissible: true,
                barrierLabel:
                    MaterialLocalizations.of(context).modalBarrierDismissLabel,
                barrierColor: Colors.black45,
                transitionDuration: const Duration(milliseconds: 200),
                pageBuilder:
                    (BuildContext buildContext, animation, secondaryAnimation) {
                  return QRScreen();
                },
              );
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
                DefaultText(
                  "View Pin: ${userBloc.state.pin}",
                  color: Colors.blue,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DefaultText(
                  "Logout",
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChangePassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    return BlocProvider<ProfileCubit>(
      create: (context) => ProfileCubit(
        context.read<AuthenticationRepository>(),
      ),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 30.0,
              horizontal: 20.0,
            ),
            child: Column(
              children: [
                const SizedBox(height: 20.0),
                TextFormField(
                  autocorrect: false,
                  autovalidateMode: AutovalidateMode.always,
                  decoration: InputDecoration(
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
                  onChanged: (newValue) {
                    context.read<ProfileCubit>().oldPasswordChanged(newValue);
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  autocorrect: false,
                  autovalidateMode: AutovalidateMode.always,
                  decoration: InputDecoration(
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
                  onChanged: (newValue) {
                    context.read<ProfileCubit>().newPasswordChanged(newValue);
                  },
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
                    await context.read<ProfileCubit>().changePassword();
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
          );
        },
      ),
    );
  }
}
