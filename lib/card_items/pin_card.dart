import 'package:flutter/material.dart';
import '../models/registration.dart';
import '../data/api.dart';

class UserPinCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Registration>>(
      future: Api.getUserInfo(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(
              ("Your Pin: ${(snapshot.data[0].pin - snapshot.data[0].basePin).toString()}"));
        } else if (snapshot.hasError) {
          return Text('${snapshot.error.toString()}');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
