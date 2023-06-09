import 'package:flutter/material.dart';
import 'package:storitter/utils/form_validation.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordField({Key? key, required this.controller}) : super(key: key);

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _shown = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validatePassword,
      controller: widget.controller,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      obscureText: !_shown,
      decoration: InputDecoration(
        labelText: "Password",
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(
            _shown ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              _shown = !_shown;
            });
          },
        ),
      ),
    );
  }
}
