import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackpsu/styles/theme_colors.dart';

import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_state.dart';
import '../bloc/favorites/favorites_bloc.dart';
import '../bloc/favorites/favorites_event.dart';
import '../bloc/favorites/favorites_state.dart';
import '../cubit/event_cubit.dart';
import '../cubit/favorites_cubit.dart';
import '../models/event.dart';
import '../widgets/loading.dart';
import 'auth_router.dart';
import 'main_router.dart';

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
