import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storitter/data/api/api_services.dart';
import 'package:storitter/data/preferences/preferences_helper.dart';
import 'package:storitter/provider/app_provider.dart';
import 'package:storitter/provider/login_provider.dart';
import 'package:storitter/provider/preferences_provider.dart';
import 'package:storitter/provider/register_provider.dart';
import 'package:storitter/routes/app_router.dart';
import 'package:storitter/shared/locale.dart';
import 'package:storitter/shared/theme.dart';

final ApiServices _apiServices = ApiServices(client: Dio());
final AppProvider _appProvider = AppProvider(
  preferencesHelper: PreferencesHelper(
    sharedPreferences: SharedPreferences.getInstance(),
  ),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginProvider(apiServices: _apiServices),
        ),
        ChangeNotifierProvider(
          create: (_) => RegisterProvider(apiServices: _apiServices),
        ),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        Provider(
          create: (_) => AppRouter(appProvider: _appProvider),
        ),
      ],
      child: MaterialApp.router(
        title: 'Story App',
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: AppRouter(appProvider: _appProvider).router,
        theme: ThemeData(primarySwatch: Colors.blue, textTheme: textTheme),
      ),
    );
  }
}
