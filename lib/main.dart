import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:provider/provider.dart';
import 'package:weather/core/routes/go_router_init.dart';
import 'package:weather/core/themes/app_themes.dart';
import 'package:weather/core/utils/logger.dart';
import 'package:weather/features/presentation/blocs/location/location_bloc.dart';
import 'package:weather/features/presentation/blocs/weather/weather_bloc.dart';
import 'package:weather/injection_container.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();

  logger.runLogging(
    () => runZonedGuarded(
      () async {
        await initPreAppServices();
        runApp(
          ChangeNotifierProvider(
            create: (_) => AppTheme(), // Provide the AppTheme
            child: const MyApp(),
          ),
        );
      },
      logger.logZoneError,
    ),
    const LogOptions(),
  );
}

Future<void> initPreAppServices() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // Bloc.observer = AppBlocObserver();

  await initLocator();

  // await Hive.initFlutter();

  // Hive.registerAdapter(WeatherDataModelAdapter());
  // Hive.openBox("weather_box");
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<AppTheme>(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherBloc>(create: (context) => locator<WeatherBloc>()),
        BlocProvider<LocationBloc>(create: (context) => locator<LocationBloc>()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeNotifier.themeMode,
        routerConfig: routerinit,
      ),
    );
  }
}
