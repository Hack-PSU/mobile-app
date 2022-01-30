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
          snapshot.data.sort((a, b) => (a.time).compareTo(b.time));
          return Text(
              ("Your Pin: ${(snapshot.data.last.pin - snapshot.data.last.basePin).toString()}"));
        } else if (snapshot.hasError) {
          return Text('${snapshot.error.toString()}');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
