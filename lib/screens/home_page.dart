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
            FutureBuilder<List<dynamic>>(
              future: Api.getEvents(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data[0]['event_title']);
                } else if (snapshot.hasError) {
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
