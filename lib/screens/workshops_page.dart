import 'package:flutter/material.dart';

import '../widgets/default_text.dart';

class WorkshopsScreen extends StatelessWidget {
  const WorkshopsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DefaultText(
        "Workshops",
        fontLevel: TextLevel.h1,
        fontSize: 38,
      ),
    );
  }
}
