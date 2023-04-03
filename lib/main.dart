import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storitter/data/api/api_services.dart';
import 'package:storitter/data/preferences/preferences_helper.dart';
import 'package:storitter/provider/login_provider.dart';
import 'package:storitter/provider/preferences_provider.dart';
import 'package:storitter/provider/register_provider.dart';
import 'package:storitter/routes/app_router.dart';
import 'package:storitter/shared/locale.dart';

final ApiServices _apiServices = ApiServices(client: Dio());

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
        )
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: AppRouter().router,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
