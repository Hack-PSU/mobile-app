import 'package:flutter/material.dart';
import 'package:hackpsu/card_items/countdown_timer_card.dart';
import 'package:provider/provider.dart';

import '../card_items/pin_card.dart';
import '../card_items/event_workshop_card.dart';
import '../data/authentication_service.dart';
import '../data/api.dart';
import '../models/event.dart';
import '../models/registration.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("HOME"),
            CountdownTimerCard(),
            UserPinCard(),
            EventWorkshopCard(),
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
