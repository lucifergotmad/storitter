import 'package:flutter/material.dart';
import 'package:storitter/shared/locale.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(AppLocalizations.of(context)!.dummySavedText),
    );
  }
}
