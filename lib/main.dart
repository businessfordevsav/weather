import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather/core/routes/go_router_init.dart';
import 'package:weather/core/themes/app_themes.dart';
import 'package:weather/core/utils/logger.dart';
import 'package:weather/features/presentation/blocs/location_bloc/get_location_cubit.dart';
import 'package:weather/injection_container.dart';

void main() async {
  await initLocator();
  logger.runLogging(
    () => runZonedGuarded(
      () {
        WidgetsFlutterBinding.ensureInitialized();
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
        BlocProvider<GetLocationCubit>(
            create: (context) => locator<GetLocationCubit>()),
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
