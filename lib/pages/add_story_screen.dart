import 'package:flutter/material.dart';

class AddStoryScreen extends StatelessWidget {
  const AddStoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text("AddStoryScreen"),
        ),
      ),
    );
  }
}
