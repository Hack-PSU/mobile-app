import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/bloc/app/app_bloc.dart';
import '../common/bloc/app/app_state.dart';
import '../common/bloc/auth/auth_bloc.dart';
import '../common/bloc/auth/auth_state.dart';
import '../common/bloc/user/user_bloc.dart';
import '../common/bloc/user/user_state.dart';
import '../screens/offline/offline_page.dart';
import '../screens/profile/profile_page.dart';
import 'auth_router.dart';
import 'create_profile_router.dart';
import 'main_router.dart';
import 'registration_router.dart';

class RootRouter extends StatelessWidget {
  const RootRouter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      buildWhen: (previous, current) =>
          previous.isConnected != current.isConnected,
      builder: (appContext, appState) {
        if (appState.isConnected == true) {
          return BlocBuilder<AuthBloc, AuthState>(
            buildWhen: (previous, current) => previous.status != current.status,
            builder: (context, state) {
              if (state.status == AuthStatus.authenticated) {
                return BlocBuilder<UserBloc, UserState>(
                  builder: (context, userState) {
                    if (userState.exists) {
                      return Navigator(
                        initialRoute:
                            userState.exists ? "/" : "/create-profile",
                        onGenerateRoute: (RouteSettings settings) {
                          WidgetBuilder builder;
                          if (settings.name == "/") {
                            builder =
                                (BuildContext context) => const MainRouter();
                          } else if (settings.name!
                              .startsWith("/registration")) {
                            builder = (BuildContext context) =>
                                RegistrationRouter(route: settings.name!);
                          } else if (settings.name == "/profile") {
                            builder =
                                (BuildContext context) => const ProfilePage();
                          } else {
                            throw Exception("Invalid route ${settings.name}");
                          }

                          return MaterialPageRoute<void>(
                            builder: builder,
                            settings: settings,
                          );
                        },
                      );
                    } else {
                      return const CreateProfileRouter();
                    }
                  },
                );
              } else {
                return const AuthRouter();
              }
            },
          );
        } else {
          return const OfflinePage();
        }
      },
    );
  }
}
