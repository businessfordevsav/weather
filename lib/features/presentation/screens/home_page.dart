import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:weather/core/assets/app_images.dart';
import 'package:weather/core/utils/logger.dart';
import 'package:weather/core/utils/routes.dart';
import 'package:weather/features/presentation/blocs/weather/weather_bloc.dart';
import 'package:weather/features/presentation/widgets/custom_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    BlocProvider.of<WeatherBloc>(context).add(GetLocalWeatherDataEvent());
    BlocProvider.of<WeatherBloc>(context).add(GetWeatherDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = true;
    String subLocality = "-:-";
    String currentTemperature = "-:-";
    String minTemperature = "-:-";
    String maxTemperature = "-:-";
    String sunriseTime = "-:-";
    String sunsetTime = "-:-";
    String weatherConditionText = "-:-";
    String weatherConditionImagePath = AppImages.icSunny;

    return BlocListener<WeatherBloc, GetWeatherState>(
      listener: (context, locationState) {
        if (locationState is CurrentLocationSuccess) {
        } else if (locationState is WeatherSuccess) {
          subLocality = locationState.weather.subLocality;
          currentTemperature = locationState.weather.currentTemperature;
          minTemperature = locationState.weather.minTemperature;
          maxTemperature = locationState.weather.maxTemperature;
          sunriseTime = locationState.weather.sunriseTime;
          sunsetTime = locationState.weather.sunsetTime;
          weatherConditionText = locationState.weather.weatherConditionText;
          weatherConditionImagePath =
              locationState.weather.weatherConditionImagePath;
          isLoading = false;
        } else if (locationState is WeatherFail) {
          isLoading = false;
          logger.error("LocationFail :: ${locationState.error}");
        } else if (locationState is GetLocationInitial) {
          isLoading = true;
          logger.error("GetLocationInitial :: ");
        } else if (locationState is WeatherLoading) {
          isLoading = true;
          logger.error("LocationLoading :: ");
        }
      },
      child: BlocBuilder<WeatherBloc, GetWeatherState>(
          builder: (context, locationState) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                CustomAppBar(
                  onPressed: () {
                    BlocProvider.of<WeatherBloc>(context)
                        .add(GetWeatherDataEvent());
                  },
                  subLocality: subLocality,
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        isLoading ? "in sync" : "synced",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        DateFormat('EEEE, dd MMMM yyyy').format(DateTime.now()),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          context
                              .pushNamed(AppRoutes.WEATGER_DETAILS_ROUTE_NAME);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              currentTemperature,
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            Text(
                              "°C",
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ],
                        ),
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
                            "$minTemperature°C",
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
                            "$maxTemperature°C",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      GestureDetector(
                        onTap: () =>
                            context.pushNamed(AppRoutes.FORECAST_ROUTE_NAME),
                        child: Image.asset(
                          weatherConditionImagePath,
                          width: 128,
                          height: 128,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        weatherConditionText,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppImages.icSunrise,
                            width: 21,
                            height: 21,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            sunriseTime,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Image.asset(
                            AppImages.icSunset,
                            width: 21,
                            height: 21,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            sunsetTime,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
