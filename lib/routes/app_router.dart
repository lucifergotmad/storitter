import 'package:camera/camera.dart';
import 'package:go_router/go_router.dart';
import 'package:storitter/pages/add_story_screen.dart';
import 'package:storitter/pages/camera_screen.dart';
import 'package:storitter/pages/detail_story_screen.dart';

import 'package:storitter/pages/error_screen.dart';
import 'package:storitter/pages/home_screen.dart';
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
          routes: [
            GoRoute(
              name: "home",
              path: "story",
              builder: (context, state) => const HomeScreen(),
              routes: [
                GoRoute(
                    name: "add",
                    path: "add",
                    builder: (context, state) =>
                        AddStoryScreen(file: state.extra as XFile?),
                    routes: [
                      GoRoute(
                        name: "camera",
                        path: "camera",
                        builder: (context, state) =>
                            CameraScreen(
                              cameras: state.extra as List<CameraDescription>,
                            ),
                      ),
                    ]),
                GoRoute(
                  name: "detail",
                  path: "detail/:id",
                  builder: (context, state) =>
                      DetailStoryScreen(
                        id: state.params["id"],
                      ),
                ),
              ],
            )
          ],
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
        final isUploaded = appProvider.isUploaded;

        if (!isLoggedIn) {
          if (state.location == "/login") {
            return "/login";
          } else {
            return "/register";
          }
        }

        if (state.location == "/login") {
          return "/";
        }

        return null;
      });

  GoRouter get router => _router;
}
