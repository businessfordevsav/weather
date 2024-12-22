import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather/core/utils/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _navigateToHome();
    super.initState();
  }

  void _navigateToHome() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        context.pushReplacementNamed(AppRoutes.HOME_ROUTE_NAME);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: 375,
      height: 812,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(0, 0, 0, 1),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
              top: 771,
              left: 145,
              child: Text(
                'A minimal weather app',
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.titleMedium,
              )),
          Positioned(
              top: 392,
              left: 149,
              child: Text(
                'Weather',
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.labelLarge,
              )),
        ],
      ),
    ));
  }
}
