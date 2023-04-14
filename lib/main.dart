import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storitter/data/api/api_services.dart';
import 'package:storitter/data/preferences/preferences_helper.dart';
import 'package:storitter/provider/add_story_provider.dart';
import 'package:storitter/provider/app_provider.dart';
import 'package:storitter/provider/detail_story_provider.dart';
import 'package:storitter/provider/home_provider.dart';
import 'package:storitter/provider/login_provider.dart';
import 'package:storitter/provider/register_provider.dart';
import 'package:storitter/routes/app_router.dart';
import 'package:storitter/shared/locale.dart';
import 'package:storitter/shared/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final ApiServices apiServices = ApiServices(
    client: Dio(),
  );
  final PreferencesHelper preferencesHelper = PreferencesHelper(
    sharedPreferences: await SharedPreferences.getInstance(),
  );
  final AppProvider appProvider = AppProvider(
    preferencesHelper: preferencesHelper,
  );

  runApp(MyApp(
    apiServices: apiServices,
    appProvider: appProvider,
  ));
}

class MyApp extends StatelessWidget {
  final ApiServices apiServices;
  final AppProvider appProvider;

  const MyApp(
      {super.key, required this.appProvider, required this.apiServices});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => appProvider),
        ChangeNotifierProvider(
          create: (_) => LoginProvider(apiServices: apiServices),
        ),
        ChangeNotifierProvider(
          create: (_) => RegisterProvider(apiServices: apiServices),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeProvider(apiServices: apiServices),
        ),
        ChangeNotifierProvider(
          create: (_) => DetailStoryProvider(apiServices: apiServices),
        ),
        ChangeNotifierProvider(
          create: (_) => AddStoryProvider(apiServices: apiServices),
        ),
        Provider(
          create: (_) => AppRouter(appProvider: appProvider),
        ),
      ],
      child: MaterialApp.router(
        title: 'Story App',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: AppRouter(appProvider: appProvider).router,
        theme: ThemeData(primarySwatch: Colors.blue, textTheme: textTheme),
      ),
    );
  }
}
