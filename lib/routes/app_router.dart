import 'package:go_router/go_router.dart';

import 'package:storitter/pages/error_screen.dart';
import 'package:storitter/pages/home_screen.dart';
import 'package:storitter/pages/login_screen.dart';
import 'package:storitter/pages/register_screen.dart';

class AppRouter {
  late final GoRouter _router = GoRouter(
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
              builder: (context, state) => const LoginScreen(),
            ),
            GoRoute(
              name: "register",
              path: "register",
              builder: (context, state) => const RegisterScreen(),
            )
          ],
        ),
      ],
      errorBuilder: (context, state) => const ErrorScreen(),
      redirect: (context, state) {
        if (state.location == "/") {
          return "/register";
        }
        return null;
      });

  GoRouter get router => _router;
}
