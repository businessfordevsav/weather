import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:weather/core/utils/logger.dart';
import 'package:weather/features/presentation/blocs/location_bloc/get_location_cubit.dart';
import 'package:weather/features/presentation/widgets/custom_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<GetLocationCubit>().getCountry();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BlocBuilder<GetLocationCubit, GetLocationState>(
          builder: (context, locationState) {
        String subLocality = "Unknown Location";
        if (locationState is LocationSuccess) {
          if (locationState.place.subLocality.toString().isNotEmpty) {
            subLocality = locationState.place.subLocality.toString();
          } else if (locationState.place.locality.toString().isNotEmpty) {
            subLocality = locationState.place.locality.toString();
          } else if (locationState.place.administrativeArea
              .toString()
              .isNotEmpty) {
            subLocality = locationState.place.administrativeArea.toString();
          } else if (locationState.place.country.toString().isNotEmpty) {
            subLocality = locationState.place.country.toString();
          } else {
            subLocality = "Unknown Location";
          }

          logger.info("LocationSuccess:: ${locationState.place}");
        } else if (locationState is LocationFail) {
          logger.error("LocationFail :: ${locationState.error}");
        } else if (locationState is GetLocationInitial) {
          logger.error("GetLocationInitial :: ");
        } else if (locationState is LocationLoading) {
          logger.error("LocationLoading :: ");
        }
        logger.error("subLocality :: $subLocality");
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                CustomAppBar(
                  onPressed: () {
                    context.read<GetLocationCubit>().getCountry();
                  },
                  subLocality: subLocality,
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "in sync",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Friday, 25 December 2020",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          "22",
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        Text(
                          "°C",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          size: 21,
                          Icons.arrow_downward_outlined,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          "16°C",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Icon(
                          size: 21,
                          Icons.arrow_upward_outlined,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          "26°C",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Icon(Iconsax.cloud_drizzle,
                        size: 128,
                        color: Theme.of(context).colorScheme.primary),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Light Drizzle",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          size: 21,
                          Icons.sunny,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          "16°C",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Icon(
                          size: 21,
                          Icons.sunny,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          "26°C",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        );
      });
    });
  }
}
