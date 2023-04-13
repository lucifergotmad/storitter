import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:storitter/provider/app_provider.dart';
import 'package:storitter/shared/locale.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppProvider provider = context.read<AppProvider>();

    return Center(
      child: ElevatedButton(
        onPressed: () {
          provider
            ..removeToken()
            ..getToken();

          context.goNamed("login");
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Text(
            AppLocalizations.of(context)!.logout,
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(color: Colors.white70, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
