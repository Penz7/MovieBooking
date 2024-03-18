import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_booking/router/router_key_manager.dart';
import 'package:movie_booking/screens/auth/login_screen.dart';
import 'package:movie_booking/screens/auth/signup_screen.dart';
import 'package:movie_booking/screens/home/home.dart';
import 'package:movie_booking/screens/main_tabbar_screen.dart';
import 'package:movie_booking/screens/profile/profile_account.dart';
import 'package:movie_booking/screens/splash_screen/page_not_found.dart';
import 'package:movie_booking/screens/splash_screen/splash_screen.dart';

class AppRouter {
  AppRouter._();

  static AppRouter? _instance;

  static AppRouter get shareInstance {
    _instance ??= AppRouter._();
    return _instance!;
  }

  late final router = GoRouter(
    initialLocation: initRouter(),
    navigatorKey: RouterKeyManager.instance.rootNavigatorKey,
    debugLogDiagnostics: kDebugMode,
    routes: <RouteBase>[
      GoRoute(
        path: '/intro',
        parentNavigatorKey: RouterKeyManager.instance.rootNavigatorKey,
        builder: (BuildContext context, GoRouterState state) {
          return const SplashScreen();
        },
      ),
      StatefulShellRoute.indexedStack(
        restorationScopeId: 'shell',
        pageBuilder: (
          BuildContext context,
          GoRouterState state,
          StatefulNavigationShell navigationShell,
        ) {
          return MaterialPage<void>(
            restorationId: 'shellWidget',
            child: MainTabBarScreen(navigationShell: navigationShell),
          );
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            restorationScopeId: 'bHome',
            navigatorKey: RouterKeyManager.instance.homeNavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                // The screen to display as the root in the first tab of the
                // bottom navigation bar.
                path: '/home',
                pageBuilder: (BuildContext context, GoRouterState state) =>
                    const MaterialPage<void>(
                  restorationId: 'home',
                  child: HomeScreen(),
                ),
                routes: <RouteBase>[],
              ),
            ],
          ),
          StatefulShellBranch(
            restorationScopeId: 'bCalories',
            navigatorKey: RouterKeyManager.instance.nutritionNavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                path: '/calories',
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return const MaterialPage<void>(
                    restorationId: 'calories',
                    child: HomeScreen(),
                  );
                },
                routes: const <RouteBase>[],
              ),
            ],
          ),
          StatefulShellBranch(
            restorationScopeId: 'bCategory',
            navigatorKey: RouterKeyManager.instance.categoryNavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                // The screen to display as the root in the first tab of the
                // bottom navigation bar.
                path: '/category',
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return const MaterialPage<void>(
                    restorationId: 'category',
                    child: HomeScreen(),
                  );
                },
                routes: const <RouteBase>[],
              ),
            ],
          ),
          StatefulShellBranch(
            restorationScopeId: 'bProfile',
            navigatorKey: RouterKeyManager.instance.profileNavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                // The screen to display as the root in the second tab of the
                // bottom navigation bar.
                path: '/profile',
                pageBuilder: (BuildContext context, GoRouterState state) =>
                    const MaterialPage<void>(
                  restorationId: 'profile',
                  child: ProfileAccountScreen(),
                ),
                routes: <RouteBase>[],
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/login',
        parentNavigatorKey: RouterKeyManager.instance.rootNavigatorKey,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
        routes: [
          GoRoute(
            path: 'sign-up',
            parentNavigatorKey: RouterKeyManager.instance.rootNavigatorKey,
            builder: (BuildContext context, GoRouterState state) {
              return const SignUpScreen();
            },
            routes: [],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) {
      return const PageNotFoundScreen();
    },
  );

  String? initRouter() {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      return '/home';
    } else {
      return '/login';
    }
  }

  static Future<String?> _guard(
    BuildContext context,
    GoRouterState state,
  ) async {
    final auth = FirebaseAuth.instance;

    if (state.fullPath?.contains('/profile') == true) {
      final user = auth.currentUser;
      if (user != null) {
        return null;
      } else {
        return '/login';
      }
    }
    return null;
  }
}
