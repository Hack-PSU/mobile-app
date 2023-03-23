import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../styles/theme_colors.dart';
import '../default_text.dart';

class SelectItem<T> {
  SelectItem({
    required this.label,
    required this.value,
  });

  final String label;
  final T value;
}

class Select<T> extends StatelessWidget {
  const Select({
    Key? key,
    this.value,
    this.placeholder,
    this.width,
    required this.onChanged,
    required this.items,
  }) : super(key: key);

  final T? value;
  final Function(T?)? onChanged;
  final List<SelectItem<T>> items;
  final String? placeholder;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 500.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: ThemeColors.addAlpha(
              Colors.black,
              0.05,
            ),
            blurRadius: 10,
            spreadRadius: 1.0,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          borderRadius: BorderRadius.circular(10.0),
          hint: DefaultText(placeholder ?? "Select an option"),
          value: value,
          items: items
              .map(
                (item) => DropdownMenuItem(
                  value: item.value,
                  child: DefaultText(
                    item.label,
                    textLevel: TextLevel.body1,
                    maxLines: 5,
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
