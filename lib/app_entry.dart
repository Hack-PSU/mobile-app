import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'common/api/event.dart';
import 'common/api/notification.dart';
import 'common/api/sponsorship/sponsorship_repository.dart';
import 'common/api/user.dart';
import 'common/bloc/auth/auth_bloc.dart';
import 'common/bloc/favorites/favorites_bloc.dart';
import 'common/bloc/user/user_bloc.dart';
import 'common/cubit/sponsor_cubit.dart';
import 'common/services/authentication_repository.dart';
import 'routers/root_router.dart';
import 'screens/event/events_page_cubit.dart';
import 'screens/home/home_page_cubit.dart';
import 'screens/workshop/workshops_page_cubit.dart';
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
          BlocProvider<HomePageCubit>(
            create: (context) => HomePageCubit(
              context.read<EventRepository>(),
              context.read<UserRepository>(),
              context.read<SponsorshipRepository>(),
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
          BlocProvider<EventsPageCubit>(
            create: (context) => EventsPageCubit(
              context.read<EventRepository>(),
              BlocProvider.of<FavoritesBloc>(context),
            ),
          ),
          BlocProvider<WorkshopsPageCubit>(
            create: (context) => WorkshopsPageCubit(
              context.read<EventRepository>(),
              BlocProvider.of<FavoritesBloc>(context),
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
