import 'package:go_router/go_router.dart';

import 'package:storitter/pages/error_screen.dart';
import 'package:storitter/pages/home_screen.dart';
import 'package:storitter/pages/login_screen.dart';
import 'package:storitter/pages/register_screen.dart';
import 'package:storitter/provider/app_provider.dart';

class AppRouter {
  final AppProvider appProvider;

  AppRouter({required this.appProvider});

  late final GoRouter _router = GoRouter(
      refreshListenable: appProvider,
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          name: "home",
          path: "/",
          builder: (context, state) => const HomeScreen(),
          routes: [
            GoRoute(
              name: "login",
              path: "login",
              builder: (context, state) => LoginScreen(),
            ),
            GoRoute(
              name: "register",
              path: "register",
              builder: (context, state) => RegisterScreen(),
            )
          ],
        ),
      ],
      errorBuilder: (context, state) => const ErrorScreen(),
      redirect: (context, state) {
        final isLoggedIn = appProvider.isLoggedIn;

        if (isLoggedIn) {
          return "/";
        }

        return "/login";
      });

  GoRouter get router => _router;
}
