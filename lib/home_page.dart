import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import './authentication_service.dart';

class HomePage extends StatelessWidget {
  void fetch() async {
    var url = Uri.parse('https://staging.hackpsu18.appspot.com/v2/live/events');
    var response = await http.get(url);
    var jsonResponse = convert.jsonDecode(response.body);

    print(jsonResponse);
  }

  @override
  Widget build(BuildContext context) {
    fetch();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("HOME"),
            ElevatedButton(
              onPressed: () {
                context.read<AuthenticationService>().signOut();
              },
              child: Text("Sign out"),
            )
          ],
        ),
      ),
    );
  }
}
