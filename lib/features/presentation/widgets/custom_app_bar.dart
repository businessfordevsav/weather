import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather/core/utils/routes.dart';

class CustomAppBar extends StatelessWidget {
  final VoidCallback onPressed;
  final String subLocality;
  const CustomAppBar(
      {required this.onPressed, required this.subLocality, super.key});

  @override
  Widget build(BuildContext context) {
    // logger.info("subLocality :: $subLocality");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Align left and right
        children: [
          // Left-aligned widg et
          GestureDetector(
            onTap: onPressed,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subLocality,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  'Current Location',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),

          // Right-aligned widgets
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.map_outlined,
                  size: 21,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: () {
                  context.pushNamed(AppRoutes.CITY_SELECTION_ROUTE_NAME);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.settings,
                  size: 21,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: () {
                  context.pushNamed(AppRoutes.SETTINGS_ROUTE_NAME);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
