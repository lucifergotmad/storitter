import 'package:camera/camera.dart';
import 'package:go_router/go_router.dart';
import 'package:storitter/pages/add_story_screen.dart';
import 'package:storitter/pages/camera_screen.dart';
import 'package:storitter/pages/detail_story_screen.dart';

import 'package:storitter/pages/error_screen.dart';
import 'package:storitter/pages/home_screen.dart';
import 'package:storitter/pages/location_screen.dart';
import 'package:storitter/pages/login_screen.dart';
import 'package:storitter/pages/main_screen.dart';
import 'package:storitter/pages/register_screen.dart';
import 'package:storitter/pages/saved_screen.dart';
import 'package:storitter/pages/setting_screen.dart';
import 'package:storitter/provider/app_provider.dart';

class AppRouter {
  final AppProvider appProvider;

  AppRouter({required this.appProvider}) {
    appProvider.getToken();
  }

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
                        builder: (context, state) => CameraScreen(
                          cameras: state.extra as List<CameraDescription>,
                        ),
                      ),
                    ]),
                GoRoute(
                  name: "detail",
                  path: "detail/:id",
                  builder: (context, state) => DetailStoryScreen(
                    id: state.params["id"],
                  ),
                ),
              ],
            ),
            GoRoute(
              name: "maps",
              path: "maps",
              builder: (context, state) => const LocationScreen(),
            ),
            GoRoute(
              name: "saved",
              path: "saved",
              builder: (context, state) => const SavedScreen(),
            ),
            GoRoute(
              name: "settings",
              path: "settings",
              builder: (context, state) => const SettingScreen(),
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
        final token = appProvider.token;
        const loginLoc = "/login";
        final loggingIn = state.subloc == loginLoc;

        const createAccountLoc = "/register";
        final creatingAccount = state.subloc == createAccountLoc;

        final isLoggedIn = token.isNotEmpty;

        const rootLoc = "/";

        if (isLoggedIn && (loggingIn || creatingAccount)) return rootLoc;
        if (!isLoggedIn && !loggingIn && !creatingAccount) return loginLoc;


        return null;
      });

  GoRouter get router => _router;
}
