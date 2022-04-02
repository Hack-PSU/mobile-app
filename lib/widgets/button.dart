import 'package:flutter/material.dart';
import 'default_text.dart';

enum ButtonVariant {
  TextButton,
  ElevatedButton,
  IconButton,
}

class ButtonConfig {
  const ButtonConfig({
    this.style,
    this.icon,
    this.iconSize,
    this.color,
    this.child,
    this.onPressed,
  });

  final ButtonStyle style;
  final Widget icon;
  final double iconSize;
  final Color color;
  final Widget child;
  final Function() onPressed;
}

class _TextButton extends StatelessWidget {
  const _TextButton({
    this.config,
  });

  final ButtonConfig config;

  @override
  Widget build(BuildContext context) {
    if (config.icon != null) {
      return TextButton.icon(
        style: config.style,
        label: config.child,
        onPressed: config.onPressed,
        icon: config.icon,
      );
    }
    return TextButton(
      style: config.style,
      onPressed: config.onPressed,
      child: config.child,
    );
  }
}

class _ElevatedButton extends StatelessWidget {
  const _ElevatedButton({
    this.config,
  });

  final ButtonConfig config;

  @override
  Widget build(BuildContext context) {
    if (config.icon != null) {
      return ElevatedButton.icon(
        onPressed: config.onPressed,
        icon: config.icon,
        label: config.child,
        style: config.style,
      );
    }
    return ElevatedButton(
      style: config.style,
      onPressed: config.onPressed,
      child: config.child,
    );
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({
    this.config,
  });

  final ButtonConfig config;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: config.onPressed,
      icon: config.icon,
      color: config.color,
      iconSize: config.iconSize,
    );
  }
}

// Currently implements TextButton/TextButton.icon,
// ElevatedButton/ElevatedButton.icon, and IconButton
class Button extends StatelessWidget {
  Button({
    @required this.variant,
    Function() onPressed,
    Widget child,
    ButtonStyle style,
    Widget icon,
    double iconSize,
    Color color,
    Key key,
  })  : config = ButtonConfig(
          onPressed: onPressed,
          child: child,
          style: style,
          icon: icon,
          iconSize: iconSize,
          color: color,
        ),
        super(key: key);

  final ButtonConfig config;
  final ButtonVariant variant;

  @override
  Widget build(BuildContext context) {
    switch (variant) {
      case ButtonVariant.TextButton:
        return _TextButton(
          config: config,
        );
        break;
      case ButtonVariant.ElevatedButton:
        return _ElevatedButton(
          config: config,
        );
        break;
      case ButtonVariant.IconButton:
        return _IconButton(
          config: config,
        );
        break;
    }
    return _TextButton(
      config: config,
    );
  }
}
