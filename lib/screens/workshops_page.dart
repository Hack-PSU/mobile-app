import 'package:flutter/material.dart';
import 'package:hackpsu/widgets/default_text.dart';
import 'package:hackpsu/widgets/screen.dart';

class WorkshopsScreen extends StatelessWidget {
  const WorkshopsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DefaultText(
        "Workshops",
        fontLevel: FontLevel.h1,
        fontSize: 38,
      ),
    );
  }
}
