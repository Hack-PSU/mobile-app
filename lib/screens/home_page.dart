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
            EventWorkshopCard(),
            Text("HOME"),
            ElevatedButton(
              onPressed: () {
                context.read<AuthenticationService>().signOut();
              },
              child: Text("Sign out"),
            ),
          ],
        ),
      ),
    );
  }
}
