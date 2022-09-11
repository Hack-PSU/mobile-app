import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/bloc/auth/auth_bloc.dart';
import '../common/bloc/auth/auth_state.dart';
import '../screens/profile/profile_page.dart';
import 'auth_router.dart';
import 'main_router.dart';

class RootRouter extends StatelessWidget {
  const RootRouter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          return Navigator(
            initialRoute: "main",
            onGenerateRoute: (RouteSettings settings) {
              WidgetBuilder builder;
              switch (settings.name) {
                case 'main':
                  builder = (BuildContext context) => const MainRouter();
                  break;
                case "profile":
                  builder = (BuildContext context) => const ProfilePage();
                  break;
                default:
                  throw Exception("Invalid route ${settings.name}");
              }
              return MaterialPageRoute<void>(
                builder: builder,
                settings: settings,
              );
            },
          );
          // return const MainRouter();
        } else {
          return const AuthRouter();
        }
      },
    );
  }
}
