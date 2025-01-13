import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather/core/utils/logger.dart';
import 'package:weather/core/utils/weather_condition.dart';
import 'package:weather/features/data/models/weather_data_model.dart';
import 'package:weather/features/presentation/blocs/weather/weather_bloc.dart';
import 'package:weather/features/presentation/widgets/custom_app_bar.dart';

class ForecastPage extends StatefulWidget {
  const ForecastPage({super.key});

  @override
  State<ForecastPage> createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  @override
  void initState() {
    BlocProvider.of<WeatherBloc>(context).add(GetLocalWeatherDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String subLocality = "-:-";
    List<HourlyWeather> hourlyData = [];
    List<DailyWeather> dailyData = [];
    return BlocListener<WeatherBloc, GetWeatherState>(
      listener: (context, locationState) {
        if (locationState is WeatherSuccess) {
          subLocality = locationState.weather.subLocality;
          hourlyData =
              getHourlyWeatherForNext24Hours(locationState.weather.hourlyData);

          dailyData = locationState.weather.dailyData;
          logger.info('dailyData: $dailyData');
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
                    // Expanded widget that wraps the entire scrollable content
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Forecast',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    Text(
                                      'Hourly Forecast',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),

                              // Expanded ListView wrapped with Container to provide constraints
                              Container(
                                height:
                                    80, // Provide a fixed height for ListView
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: hourlyData.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    bool isFirst = index == 0;
                                    bool isLast =
                                        index == hourlyData.length - 1;

                                    final hourlyWeather = hourlyData[index];
                                    logger.info(
                                        'hourlyWeather :: dateTime: ${hourlyWeather.dateTime} :: tamp : ${hourlyWeather.tamp}');
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        left: isFirst
                                            ? 30.0
                                            : 15.0, // No padding on the left for the first item
                                        right: isLast
                                            ? 30.0
                                            : 15.0, // No padding on the right for the last item
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            isWeatherDataNearCurrentTime(
                                                    hourlyWeather.dateTime)
                                                ? 'Now'
                                                : formatTime(hourlyWeather
                                                    .dateTime), // Assuming 'tamp' is the temperature
                                            style: isWeatherDataNearCurrentTime(
                                                    hourlyWeather.dateTime)
                                                ? Theme.of(context)
                                                    .textTheme
                                                    .labelMedium
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w600)
                                                : Theme.of(context)
                                                    .textTheme
                                                    .titleSmall,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Image.asset(
                                            WeatherCondition.fromCode(
                                                    hourlyWeather.weatherCode)
                                                .dayImage,
                                            width: 24,
                                            height: 24,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            '${hourlyWeather.tamp.toInt()}°C', // Assuming 'tamp' is the temperature
                                            style: isWeatherDataNearCurrentTime(
                                                    hourlyWeather.dateTime)
                                                ? Theme.of(context)
                                                    .textTheme
                                                    .labelMedium
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w600)
                                                : Theme.of(context)
                                                    .textTheme
                                                    .titleSmall,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Text(
                                  'Daily Forecast',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                height:
                                    180, // Provide a fixed height for ListView
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: dailyData.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    bool isFirst = index == 0;
                                    bool isLast = index == dailyData.length - 1;

                                    final dailyWeather = dailyData[index];

                                    return Padding(
                                      padding: EdgeInsets.only(
                                        left: isFirst
                                            ? 30.0
                                            : 15.0, // No padding on the left for the first item
                                        right: isLast
                                            ? 30.0
                                            : 15.0, // No padding on the right for the last item
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            DateTime.parse(dailyWeather
                                                                .dateTime)
                                                            .day ==
                                                        DateTime.now().day &&
                                                    DateTime.parse(dailyWeather
                                                                .dateTime)
                                                            .month ==
                                                        DateTime.now().month &&
                                                    DateTime.parse(dailyWeather
                                                                .dateTime)
                                                            .year ==
                                                        DateTime.now().year
                                                ? 'Today'
                                                : formatDate(dailyWeather
                                                    .dateTime), // Assuming 'tamp' is the temperature
                                            style: DateTime.parse(dailyWeather.dateTime)
                                                            .day ==
                                                        DateTime.now().day &&
                                                    DateTime.parse(dailyWeather
                                                                .dateTime)
                                                            .month ==
                                                        DateTime.now().month &&
                                                    DateTime.parse(dailyWeather
                                                                .dateTime)
                                                            .year ==
                                                        DateTime.now().year
                                                ? Theme.of(context)
                                                    .textTheme
                                                    .labelMedium
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w600)
                                                : Theme.of(context)
                                                    .textTheme
                                                    .titleSmall,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Image.asset(
                                            WeatherCondition.fromCode(
                                                    dailyWeather.weatherCode)
                                                .dayImage,
                                            width: 24,
                                            height: 24,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                size: 8,
                                                Icons.arrow_upward_outlined,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                              ),
                                              const SizedBox(
                                                width: 3,
                                              ),
                                              Text(
                                                "${dailyWeather.maxTamp.toInt()}°C",
                                                style: DateTime.parse(dailyWeather.dateTime).day ==
                                                            DateTime.now()
                                                                .day &&
                                                        DateTime.parse(dailyWeather
                                                                    .dateTime)
                                                                .month ==
                                                            DateTime.now()
                                                                .month &&
                                                        DateTime.parse(
                                                                    dailyWeather
                                                                        .dateTime)
                                                                .year ==
                                                            DateTime.now().year
                                                    ? Theme.of(context)
                                                        .textTheme
                                                        .labelMedium
                                                        ?.copyWith(
                                                            fontWeight:
                                                                FontWeight.w600)
                                                    : Theme.of(context)
                                                        .textTheme
                                                        .titleSmall,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                size: 8,
                                                Icons.arrow_downward_outlined,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                              ),
                                              const SizedBox(
                                                width: 3,
                                              ),
                                              Text(
                                                "${dailyWeather.minTamp.toInt()}°C",
                                                style: DateTime.parse(dailyWeather.dateTime).day ==
                                                            DateTime.now()
                                                                .day &&
                                                        DateTime.parse(dailyWeather
                                                                    .dateTime)
                                                                .month ==
                                                            DateTime.now()
                                                                .month &&
                                                        DateTime.parse(
                                                                    dailyWeather
                                                                        .dateTime)
                                                                .year ==
                                                            DateTime.now().year
                                                    ? Theme.of(context)
                                                        .textTheme
                                                        .labelMedium
                                                        ?.copyWith(
                                                            fontWeight:
                                                                FontWeight.w600)
                                                    : Theme.of(context)
                                                        .textTheme
                                                        .titleSmall,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
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

  bool isWeatherDataNearCurrentTime(String dateTime) {
    // Loop through each weather entry
    Duration difference = DateTime.now().difference(DateTime.parse(dateTime));

    // Check if the difference is within the threshold (positive or negative)
    if (difference.abs() <= Duration(minutes: 60)) {
      return true; // Found a weather entry close to the current time
    }
    return false; // No weather entry close to the current time
  }

  // Function to filter hourly data for the next 24 hours
  List<HourlyWeather> getHourlyWeatherForNext24Hours(
      List<HourlyWeather> hourlyData) {
    DateTime now = DateTime.now();
    // Current time
    DateTime twentyFourHoursLater =
        now.add(Duration(hours: 24)); // 24 hours from now

    // Print for debugging purposes
    print("Current time: $now");
    print("24 hours later: $twentyFourHoursLater");

    // Filter hourlyData based on the current time and the next 24 hours
    List<HourlyWeather> filteredData = hourlyData.where(
      (weather) {
        return DateTime.parse(weather.dateTime).isAfter(now) &&
            DateTime.parse(weather.dateTime).isBefore(twentyFourHoursLater);

        // Log each entry for debugging purposes
      },
    ).toList();

    return filteredData;
  }

  String formatTime(String dateTime) {
    // Define the time format (HH:mm)
    DateFormat timeFormat = DateFormat('d MMM HH:mm');

    // Format the local time and return it as a string
    return timeFormat.format(
      DateTime.parse(dateTime).toLocal(),
    );
  }

  String formatDate(String dateTime) {
    // Define the time format (HH:mm)
    DateFormat timeFormat = DateFormat('d MMM');

    // Format the local time and return it as a string
    return timeFormat.format(DateTime.parse(dateTime).toLocal());
  }
}
