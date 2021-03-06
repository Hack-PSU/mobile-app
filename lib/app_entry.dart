import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'bloc/auth/auth_bloc.dart';
import 'bloc/favorites/favorites_bloc.dart';
import 'bloc/user/user_bloc.dart';
import 'cubit/event_cubit.dart';
import 'cubit/favorites_cubit.dart';
import 'cubit/registration_cubit.dart';
import 'cubit/sponsor_cubit.dart';
import 'cubit/workshop_cubit.dart';
import 'data/authentication_repository.dart';
import 'data/event_repository.dart';
import 'data/notification_repository.dart';
import 'data/sponsorship_repository.dart';
import 'data/user_repository.dart';
import 'models/event.dart';
import 'routers/root_router.dart';
import 'utils/flavor_constants.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
        RepositoryProvider(
          create: (_) =>
              NotificationRepository('${Config.fcmUrl}/notifications'),
        ),
        RepositoryProvider(
          create: (_) => SponsorshipRepository(
            bucket: Config.storageBucket,
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<EventCubit>(
            create: (context) => EventCubit(context.read<EventRepository>()),
          ),
          BlocProvider<WorkshopCubit>(
            create: (context) => WorkshopCubit(context.read<EventRepository>()),
          ),
          BlocProvider<RegistrationCubit>(
            create: (context) =>
                RegistrationCubit(context.read<UserRepository>()),
          ),
          BlocProvider<UserBloc>(
            create: (context) => UserBloc(
              userRepository: context.read<UserRepository>(),
              notificationRepository: context.read<NotificationRepository>(),
            ),
          ),
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authenticationRepository:
                  context.read<AuthenticationRepository>(),
              userBloc: BlocProvider.of<UserBloc>(context),
            ),
          ),
          BlocProvider<FavoritesBloc>(
            create: (context) => FavoritesBloc(
              userBloc: BlocProvider.of<UserBloc>(context),
            ),
          ),
          BlocProvider<SponsorshipCubit>(
            create: (context) => SponsorshipCubit(
              context.read<SponsorshipRepository>(),
            ),
          ),
        ],
        child: const ImageCache(
          images: [
            AssetImage("assets/images/header_mountains.png"),
          ],
          child: MaterialApp(
            title: "HackPSU",
            home: RootRouter(),
          ),
        ),
      ),
    );
  }
}

class ImageCache extends StatelessWidget {
  const ImageCache({
    Key? key,
    required this.images,
    required this.child,
  }) : super(key: key);

  final List<ImageProvider> images;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    for (final ImageProvider image in images) {
      precacheImage(image, context);
    }

    return child;
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
