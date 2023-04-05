import 'package:flutter/material.dart';

class StoritterTextField extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextEditingController controller;

  const StoritterTextField({
    Key? key,
    required this.label,
    required this.icon,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(icon),
      ),
    );
  }
}
