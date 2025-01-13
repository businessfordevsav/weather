import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/core/utils/utils.dart';
import 'package:weather/features/presentation/blocs/weather/weather_bloc.dart';
import 'package:weather/features/presentation/widgets/custom_app_bar.dart';

class WeatherDetailsPage extends StatefulWidget {
  const WeatherDetailsPage({super.key});

  @override
  State<WeatherDetailsPage> createState() => _WeatherDetailsPageState();
}

class _WeatherDetailsPageState extends State<WeatherDetailsPage> {
  @override
  void initState() {
    BlocProvider.of<WeatherBloc>(context).add(GetLocalWeatherDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String subLocality = "-:-";
    double precipitation = 0.0;
    double windSpeed = 0.0;
    String windDirection = 'n';
    int humidity = 0;
    double visibility = 0.0;
    String uvIndex = "-:-";
    int surfacePressure = 0;
    return BlocListener<WeatherBloc, GetWeatherState>(
      listener: (context, locationState) {
        if (locationState is WeatherSuccess) {
          subLocality = locationState.weather.subLocality;
          precipitation = locationState.weather.precipitation.toPrecision(2);
          windSpeed = locationState.weather.windSpeed.toPrecision(2);
          windDirection = locationState.weather.windDirection;
          humidity = locationState.weather.humidity.round();
          visibility = locationState.weather.visibility.toPrecision(2);
          uvIndex = getUVLevel(locationState.weather.uvIndex);
          surfacePressure = locationState.weather.surfacePressure.round();
        }
      },
      child: BlocBuilder<WeatherBloc, GetWeatherState>(
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Container(
                color: Theme.of(context).colorScheme.surface,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomAppBar(
                      onPressed: () {
                        // context.read<GetLocationCubit>().getCurrentWether();
                      },
                      subLocality: subLocality,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Details',
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Precipitation',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                '$precipitation mm',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                '$windDirection Wind',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                '$windSpeed km/h',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Humidity',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                '$humidity %',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Visibility',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                '$visibility km',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'UV',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                '$uvIndex',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Pressure',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                '$surfacePressure hPa',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
