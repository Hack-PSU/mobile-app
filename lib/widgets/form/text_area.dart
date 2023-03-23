import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextArea extends StatelessWidget {
  const TextArea({
    Key? key,
    this.value,
    this.onChanged,
    this.placeholder,
    this.minLines = 3,
  }) : super(key: key);

  final String? value;
  final Function(String)? onChanged;
  final String? placeholder;
  final int minLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: placeholder ?? "Enter text",
        fillColor: Colors.white,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 0,
            style: BorderStyle.none,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusColor: Colors.transparent,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 0,
            style: BorderStyle.none,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 0,
            style: BorderStyle.none,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 20.0,
        ),
      ),
      initialValue: value,
      onChanged: onChanged,
      minLines: minLines,
      maxLines: null,
    );
  }
}
