import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather/core/utils/logger.dart';
import 'package:weather/core/utils/routes.dart';
import 'package:weather/features/presentation/screens/city_selection_page.dart';
import 'package:weather/features/presentation/screens/forecast_page.dart';
import 'package:weather/features/presentation/screens/home_page.dart';
import 'package:weather/features/presentation/screens/settings_page.dart';
import 'package:weather/features/presentation/screens/splash_page.dart';
import 'package:weather/features/presentation/screens/weather_details_page.dart';
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

    ///  =================================================================
    ///  ********************** Home Route *******************************
    /// ==================================================================
    GoRoute(
      name: AppRoutes.HOME_ROUTE_NAME,
      path: AppRoutes.HOME_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
    ),

    ///  =================================================================
    ///  ********************** Settings Route ***************************
    /// ==================================================================
    GoRoute(
      name: AppRoutes.SETTINGS_ROUTE_NAME,
      path: AppRoutes.SETTINGS_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        return const SettingsPage();
      },
    ),

    ///  ================================================================
    ///  ********************** Weatger Details Route *******************
    /// =================================================================
    GoRoute(
      name: AppRoutes.WEATGER_DETAILS_ROUTE_NAME,
      path: AppRoutes.WEATGER_DETAILS_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        return const WeatherDetailsPage();
      },
    ),

    ///  ================================================================
    ///  ********************** City Selection Route *******************
    /// =================================================================
    GoRoute(
      name: AppRoutes.CITY_SELECTION_ROUTE_NAME,
      path: AppRoutes.CITY_SELECTION_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        return const CitySelectionPage();
      },
    ),

    ///  ================================================================
    ///  ********************** Forecast Route *******************
    /// =================================================================
    GoRoute(
      name: AppRoutes.FORECAST_ROUTE_NAME,
      path: AppRoutes.FORECAST_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        return const ForecastPage();
      },
    ),
  ],
  errorPageBuilder: (context, state) {
    return const MaterialPage(child: ErrorScreen());
  },
  redirect: (context, state) {
    logger.info('redirect: ${state.uri}');
    return null;
  },
);
