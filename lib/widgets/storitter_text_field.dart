import 'package:flutter/material.dart';

class StoritterTextField extends StatelessWidget {
  final String label;
  final IconData icon;

  const StoritterTextField({
    Key? key,
    required this.label,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(icon),
      ),
    );
  }
}
