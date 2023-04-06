import 'package:flutter/material.dart';
import 'package:storitter/utils/form_validation.dart';

class StoritterTextField extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final TextEditingController controller;
  final String type;
  final int maxLines;

  const StoritterTextField(
      {Key? key,
      required this.label,
      required this.icon,
      required this.controller,
      this.maxLines = 1,
      this.type = "Text"})
      : super(key: key);

  const StoritterTextField.email(
      {Key? key,
      required this.label,
      required this.icon,
      required this.controller,
      this.maxLines = 1,
      this.type = "Email"})
      : super(key: key);

  const StoritterTextField.description(
      {Key? key,
      required this.label,
      required this.icon,
      required this.controller,
      this.maxLines = 6,
      this.type = "Email"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: type == "Email" ? validateEmail : null,
      controller: controller,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: icon != null ? Icon(icon) : null,
      ),
      maxLines: maxLines,
    );
  }
}
