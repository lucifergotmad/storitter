import 'package:go_router/go_router.dart';

import 'package:storitter/pages/error_screen.dart';
import 'package:storitter/pages/login_screen.dart';
import 'package:storitter/pages/main_screen.dart';
import 'package:storitter/pages/register_screen.dart';
import 'package:storitter/provider/app_provider.dart';

class AppRouter {
  final AppProvider appProvider;

  AppRouter({required this.appProvider});

  late final GoRouter _router = GoRouter(
      initialLocation: "/",
      refreshListenable: appProvider,
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          name: "main",
          path: "/",
          builder: (context, state) => const MainScreen(),
        ),
        GoRoute(
          name: "login",
          path: "/login",
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          name: "register",
          path: "/register",
          builder: (context, state) => const RegisterScreen(),
        )
      ],
      errorBuilder: (context, state) => const ErrorScreen(),
      redirect: (context, state) {
        final isLoggedIn = appProvider.isLoggedIn;

        if (!isLoggedIn) {
          if (state.location == "/login") {
            return "/login";
          } else {
            return "/register";
          }
        }

        return "/";
      });

  GoRouter get router => _router;
}
