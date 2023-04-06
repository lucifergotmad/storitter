import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storitter/data/api/api_services.dart';
import 'package:storitter/data/preferences/preferences_helper.dart';
import 'package:storitter/provider/app_provider.dart';
import 'package:storitter/provider/detail_story_provider.dart';
import 'package:storitter/provider/home_provider.dart';
import 'package:storitter/provider/login_provider.dart';
import 'package:storitter/provider/register_provider.dart';
import 'package:storitter/routes/app_router.dart';
import 'package:storitter/shared/locale.dart';
import 'package:storitter/shared/theme.dart';

final ApiServices _apiServices = ApiServices(
  client: Dio(),
);

final PreferencesHelper _preferencesHelper = PreferencesHelper(
  sharedPreferences: SharedPreferences.getInstance(),
);

final AppProvider _appProvider = AppProvider(
  preferencesHelper: _preferencesHelper,
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
        ChangeNotifierProvider(create: (_) => _appProvider),
        ChangeNotifierProvider(
          create: (_) => LoginProvider(apiServices: _apiServices),
        ),
        ChangeNotifierProvider(
          create: (_) => RegisterProvider(apiServices: _apiServices),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeProvider(apiServices: _apiServices),
        ),
        ChangeNotifierProvider(
          create: (_) => DetailStoryProvider(apiServices: _apiServices),
        ),
        Provider(
          create: (_) => AppRouter(appProvider: _appProvider),
        ),
      ],
      child: MaterialApp.router(
        title: 'Story App',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: AppRouter(appProvider: _appProvider).router,
        theme: ThemeData(primarySwatch: Colors.blue, textTheme: textTheme),
      ),
    );
  }
}
