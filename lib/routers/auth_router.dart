import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/bloc/auth/auth_bloc.dart';
import '../common/bloc/auth/auth_state.dart';
import '../screens/create_account/create_account_page.dart';
import '../screens/sign_in/sign_in_page.dart';

class AuthRouter extends StatelessWidget {
  const AuthRouter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return Navigator(
          initialRoute: "signIn",
          onGenerateRoute: (RouteSettings settings) {
            WidgetBuilder builder;
            switch (settings.name) {
              case 'signIn':
                builder = (BuildContext context) => const SignInPage();
                break;
              case 'signUp':
                builder = (BuildContext context) => const CreateAccountPage();
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
      },
    );
  }
}
