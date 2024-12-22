import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final VoidCallback onPressed;
  final String subLocality;
  const CustomAppBar(
      {required this.onPressed, required this.subLocality, super.key});

  @override
  Widget build(BuildContext context) {
    // logger.info("subLocality :: $subLocality");
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Align left and right
        children: [
          // Left-aligned widget
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
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.settings,
                  size: 21,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
