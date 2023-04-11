import 'package:flutter/material.dart';
import 'package:storitter/shared/locale.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(AppLocalizations.of(context)!.dummyLocationText),
    );
  }
}
