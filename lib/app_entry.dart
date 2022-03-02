import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackpsu/bloc/navigation/bottom_navigation_bloc.dart';
import 'package:provider/provider.dart';

import 'bloc/auth/auth_bloc.dart';
import 'bloc/auth/auth_state.dart';
import 'bloc/navigation/bottom_navigation_state.dart';
import 'cubit/bottom_navigation_cubit.dart';
import 'cubit/event_cubit.dart';
import 'cubit/registration_cubit.dart';
import 'data/authentication_repository.dart';
import 'data/event_repository.dart';
import 'data/user_repository.dart';
import 'screens/create_account_page.dart';
import 'screens/events_page.dart';
import 'screens/home_page.dart';
import 'screens/sign_in_page.dart';
import 'screens/workshops_page.dart';
import 'utils/flavor_constants.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => EventRepository('${Config.baseUrl}/live/events'),
        ),
        RepositoryProvider(
          create: (_) => AuthenticationRepository(),
        ),
        RepositoryProvider(
          create: (_) => UserRepository('${Config.baseUrl}/users/register'),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<BottomNavigationBloc>(
            create: (context) {
              return BottomNavigationBloc(Routes.Home,
                  onNavigationRouteChange: (route) {
                switch (route) {
                  case Routes.Home:
                    break;
                  case Routes.Events:
                    context.read<EventCubit>().getEvents();
                    break;
                  case Routes.Workshops:
                    break;
                }
              });
            },
          ),
          BlocProvider<EventCubit>(
            create: (context) => EventCubit(context.read<EventRepository>()),
          ),
          BlocProvider<RegistrationCubit>(
            create: (context) =>
                RegistrationCubit(context.read<UserRepository>()),
          ),
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
                authenticationRepository:
                    context.read<AuthenticationRepository>()),
          ),
        ],
        child: const MaterialApp(
          title: "HackPSU",
          home: RootRouter(),
        ),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class RootRouter extends StatelessWidget {
  const RootRouter({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          return const MainRouter();
        } else {
          return const AuthRouter();
        }
      },
    );
  }
}

class MainRouter extends StatelessWidget {
  const MainRouter({Key key}) : super(key: key);

  static const List<Widget> _pages = [
    HomePage(),
    EventsPage(),
    WorkshopsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationCubit, Routes>(
      builder: (context, route) => _pages[Routes.values.indexOf(route)],
    );
  }
}

class AuthRouter extends StatelessWidget {
  const AuthRouter({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: "signIn",
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'signIn':
            builder = (BuildContext context) => const SignInPage();
            break;
          case 'signUp':
            builder = (BuildContext context) => CreateAccount();
            break;
          default:
            throw Exception("Invalid route ${settings.name}");
        }
        return MaterialPageRoute<void>(builder: builder, settings: settings);
      },
    );
  }
}
