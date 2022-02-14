import 'package:flutter/material.dart';
import '../models/registration.dart';
import '../data/api.dart';

class UserPinCard extends StatelessWidget {
  UserPinCard(
    List<Registration> data,
  ) : _data = data;

  final List<Registration> _data;

  @override
  Widget build(BuildContext context) {
    if (_data == null) {
      _data.sort((a, b) => (a.time).compareTo(b.time));
      try {
        return Text(
            ("Your Pin: ${(_data.last.pin - _data.last.basePin).toString()}"));
      } on StateError catch (e) {
        return Text(
            "No Registration PIN because no registration data was found");
      } catch (e) {
        return Text("Error getting PIN");
      }
    }
    return Text("Error getting PIN");
    // else if (snapshot.hasError) {
    //   return Text('${snapshot.error.toString()}');
    // }
    // return const CircularProgressIndicator();
  }
}
