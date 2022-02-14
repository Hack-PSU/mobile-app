import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackpsu/data/authentication_repository.dart';
import 'package:hackpsu/data/event_repository.dart';
import 'package:hackpsu/screens/events_page.dart';
import 'package:hackpsu/screens/sign_in_page.dart';
import 'package:hackpsu/screens/workshops_page.dart';
import 'package:hackpsu/utils/bloc/auth/auth_bloc.dart';
import 'package:hackpsu/utils/bloc/auth/auth_state.dart';
import 'package:hackpsu/utils/cubits/event_cubit.dart';
import 'package:hackpsu/screens/home_page_cubit.dart';
import 'package:hackpsu/utils/flavor_constants.dart';
import 'package:hackpsu/utils/cubits/bottom_navigation_cubit.dart';
import 'package:hackpsu/widgets/bottom_navigation.dart';
import 'package:hackpsu/widgets/screen.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => EventRepository(Config.baseUrl + '/live/events'),
        ),
        RepositoryProvider(
          create: (_) => AuthenticationRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<BottomNavigationCubit>(
            create: (_) => BottomNavigationCubit(),
          ),
          BlocProvider<EventCubit>(
            create: (context) => EventCubit(context.read<EventRepository>()),
          ),
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
                authenticationRepository:
                    context.read<AuthenticationRepository>()),
          ),
        ],
        child: MaterialApp(
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
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          return MainRouter();
        } else {
          return SignInPage();
        }
      },
    );
  }
}

class MainRouter extends StatelessWidget {
  final List<Widget> _pages = [
    HomeScreen(),
    EventsScreen(),
    WorkshopsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationCubit, Routes>(
      builder: (context, route) => Screen(
        withBottomNavigation: true,
        body: _pages[Routes.values.indexOf(route)],
      ),
    );
  }
}
