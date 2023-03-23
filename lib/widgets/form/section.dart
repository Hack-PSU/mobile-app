import 'package:flutter/material.dart';

import '../default_text.dart';

class Section extends StatelessWidget {
  const Section({
    Key? key,
    this.required = true,
    required this.label,
    required this.child,
  }) : super(key: key);

  final String label;
  final bool required;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              DefaultText(
                label,
                textLevel: TextLevel.body1,
                weight: FontWeight.bold,
              ),
              if (required)
                DefaultText(
                  "*",
                  color: Colors.red,
                  fontSize: 18.0,
                ),
            ],
          ),
          const SizedBox(height: 10.0),
          child,
        ],
      ),
    );
  }
}
