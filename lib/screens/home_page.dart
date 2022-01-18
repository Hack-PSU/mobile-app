import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../card_items/event_workshop_card.dart';
import '../data/authentication_service.dart';
import '../data/api.dart';
import '../models/event.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<List<Event>>(
              future: Api.getEvents(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data[0].eventTitle);
                  return Text(snapshot.data[0].eventTitle);
                } else if (snapshot.hasError) {
                  print('death is here');
                  return Text('${snapshot.error}');
                }

                return const CircularProgressIndicator();
              },
            ),
            Text("HOME"),
            ElevatedButton(
              onPressed: () {
                context.read<AuthenticationService>().signOut();
              },
              child: Text("Sign out"),
            ),
            //EventWorkshopCard()
          ],
        ),
      ),
    );
  }
}
