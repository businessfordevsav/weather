import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather/core/utils/logger.dart';
import 'package:weather/core/utils/routes.dart';
import 'package:weather/features/presentation/screens/home_page.dart';
import 'package:weather/features/presentation/screens/splash_page.dart';
import 'package:weather/features/presentation/widgets/error_screen.dart';

GoRouter routerinit = GoRouter(
  routes: <RouteBase>[
    ///  =================================================================
    ///  ********************** Splash Route *****************************
    /// ==================================================================
    GoRoute(
      name: AppRoutes.SPLASH_ROUTE_NAME,
      path: AppRoutes.SPLASH_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
    ),

    GoRoute(
      name: AppRoutes.HOME_ROUTE_NAME,
      path: AppRoutes.HOME_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
    )
  ],
  errorPageBuilder: (context, state) {
    return const MaterialPage(child: ErrorScreen());
  },
  redirect: (context, state) {
    logger.info('redirect: ${state.uri}');
    return null;
  },
);
