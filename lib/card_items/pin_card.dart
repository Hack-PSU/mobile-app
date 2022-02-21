import 'package:flutter/material.dart';

import '../models/registration.dart';

class UserPinCard extends StatelessWidget {
  const UserPinCard(
    List<Registration> data, {
    Key key,
  })  : _data = data,
        super(key: key);

  final List<Registration> _data;

  @override
  Widget build(BuildContext context) {
    if (_data != null) {
      _data.sort((a, b) => (a.time).compareTo(b.time));
      try {
        return Text(
          "Your Pin: ${(_data.last.pin - _data.last.basePin).toString()}",
        );
      } on StateError catch (e) {
        return const Text(
          "No Registration PIN because no registration data was found",
        );
      } catch (e) {
        return const Text(
          "Error getting PIN",
        );
      }
    }
    return const Text(
      "Error getting PIN",
    );
    // else if (snapshot.hasError) {
    //   return Text('${snapshot.error.toString()}');
    // }
    // return const CircularProgressIndicator();
  }
}
