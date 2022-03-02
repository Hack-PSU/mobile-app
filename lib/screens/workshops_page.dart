import 'package:flutter/material.dart';

import '../widgets/default_text.dart';
import '../widgets/screen.dart';

class WorkshopsPage extends StatelessWidget {
  const WorkshopsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Screen.withHeader(
      withBottomNavigation: true,
      header: "Workshops",
      body: const WorkshopsScreen(),
    );
  }
}

class WorkshopsScreen extends StatelessWidget {
  const WorkshopsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DefaultText(
        "Workshops",
        textLevel: TextLevel.h1,
        fontSize: 38,
      ),
    );
  }
}
