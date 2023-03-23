import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/registration/experience_registration.dart';
import '../screens/registration/mlh_registration.dart';
import '../screens/registration/profile_registration.dart';
import '../screens/registration/start_registration.dart';
import '../screens/registration/submit_registration.dart';

class RegistrationRouter extends StatelessWidget {
  const RegistrationRouter({
    Key? key,
    required this.route,
  }) : super(key: key);

  final String route;

  @override
  Widget build(BuildContext context) {
    switch (route) {
      case "/registration":
        return const StartRegistration();
      case "/registration/profile":
        return const ProfileRegistration();
      case "/registration/experience":
        return const ExperienceRegistration();
      case "/registration/mlh":
        return const MlhRegistration();
      case "/registration/submit":
        return const SubmitRegistration();
      default:
        throw Exception("Invalid route $route");
    }
  }
}
