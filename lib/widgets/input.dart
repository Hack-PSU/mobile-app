import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackpsu/models/base_model.dart';

class Input extends StatelessWidget {
  const Input({
    @required this.label,
    this.inputType,
    this.fillColor,
    this.decoration,
    this.password,
    @required this.onChanged,
    this.autocorrect,
  });

  final String label;
  final TextInputType inputType;
  final Color fillColor;
  final InputDecoration decoration;
  final bool password;
  final Function(String) onChanged;
  final bool autocorrect;

  static InputDecoration getDefaultStyles() => InputDecoration(
        labelText: "",
        filled: true,
        fillColor: Colors.black12,
      );

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: inputType ?? TextInputType.text,
      obscureText: password != null,
      onChanged: onChanged,
      autocorrect: autocorrect ?? true,
      decoration: decoration != null
          ? decoration.copyWith(
              labelText: label,
              fillColor: fillColor,
            )
          : getDefaultStyles().copyWith(
              labelText: label,
              fillColor: fillColor,
            ),
    );
  }
}

class PasswordInput extends Input {
  const PasswordInput({
    String label,
    Function(String) onChanged,
  }) : super(
          label: label,
          password: true,
          inputType: TextInputType.visiblePassword,
          onChanged: onChanged,
          autocorrect: false,
        );
}

class ControlledInput<B extends StateStreamable<M>, M extends BaseModel>
    extends StatelessWidget {
  ControlledInput({
    @required this.buildWhen,
    @required this.builder,
  });

  final bool Function(M, M) buildWhen;
  final Input Function(B dispatch, M state) builder;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, M>(
      buildWhen: buildWhen,
      builder: (context, state) {
        final dispatch = context.read<B>();
        return builder(dispatch, state);
      },
    );
  }
}
