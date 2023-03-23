import 'package:flutter/material.dart';

import '../screens/create-profile/hackathon_create_profile.dart';
import '../screens/create-profile/start_create_profile.dart';
import '../screens/create-profile/submit_create_profile.dart';
import '../screens/create-profile/university_create_profile.dart';

class CreateProfileRouter extends StatelessWidget {
  const CreateProfileRouter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: "/",
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name!) {
          case "/":
            builder = (BuildContext context) => const StartCreateProfile();
            break;
          case '/university':
            builder = (BuildContext context) => const UniversityCreateProfile();
            break;
          case "/hackathon":
            builder = (BuildContext context) => const HackathonCreateProfile();
            break;
          case "/submit":
            builder = (BuildContext context) => const SubmitCreateProfile();
            break;
          default:
            throw Exception("Invalid route ${settings.name}");
        }

        return MaterialPageRoute(
          builder: builder,
          settings: settings,
        );
      },
    );
  }
}
