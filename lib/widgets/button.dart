import 'package:flutter/material.dart';
import 'package:hackpsu/widgets/default_text.dart';

enum ButtonVariant {
  TextButton,
  ElevatedButton,
}

class _TextButton extends TextButton {
  const _TextButton({
    ButtonStyle style,
    DefaultText child,
    Function() onPressed,
  }) : super(
          style: style,
          child: child,
          onPressed: onPressed,
        );
}

class _ElevatedButton extends ElevatedButton {
  const _ElevatedButton({
    ButtonStyle style,
    DefaultText child,
    Function() onPressed,
  }) : super(
          style: style,
          child: child,
          onPressed: onPressed,
        );
}

// Currently implements TextButton and ElevatedButton
class Button extends StatelessWidget {
  const Button({
    @required this.variant,
    @required this.child,
    @required this.onPressed,
    this.style,
  });

  final ButtonVariant variant;
  final ButtonStyle style;
  final DefaultText child;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    if (this.variant == ButtonVariant.TextButton) {
      return _TextButton(
        style: style,
        child: child,
        onPressed: onPressed,
      );
    } else if (this.variant == ButtonVariant.ElevatedButton) {
      return _ElevatedButton(
        style: style,
        child: child,
        onPressed: onPressed,
      );
    }
  }
}
