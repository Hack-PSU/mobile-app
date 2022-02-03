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
          try {
            return Text(
                ("Your Pin: ${(snapshot.data.last.pin - snapshot.data.last.basePin).toString()}"));
          } on StateError catch (e) {
            return Text(
                "No Registration PIN because no registration data was found");
          } catch (e) {
            return Text("Error getting PIN");
          }
        } else if (snapshot.hasError) {
          return Text('${snapshot.error.toString()}');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
