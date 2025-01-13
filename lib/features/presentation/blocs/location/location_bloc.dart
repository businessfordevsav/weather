import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:open_meteo/open_meteo.dart';
import 'package:weather/core/assets/app_images.dart';
import 'package:weather/core/utils/logger.dart';
import 'package:weather/core/utils/weather_condition.dart';
import 'package:weather/features/data/models/location_model.dart';
import 'package:weather/features/data/models/weather_data_model.dart';
import 'package:weather/features/domain/usecases/location_usecase.dart';
import 'package:weather/features/domain/usecases/weather_usecase.dart';

part 'location_state.dart';
part 'location_event.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final WeatherUsecase weatherUsecase;
  final LocationUsecase locationUsecase;
  LocationBloc({required this.weatherUsecase, required this.locationUsecase})
      : super(GetLocationInitial()) {
    on<SearchPlaceFromAddressEvent>(searchPlaceFromAdrress);
    on<GetSavedLocationData>(getSavedLocationData);
    on<AddLocation>(addLocationData);
    on<DeleteSavedLocationData>(deleteLocationData);
  }

  Future<void> searchPlaceFromAdrress(
      SearchPlaceFromAddressEvent event, Emitter<LocationState> emit) async {
    List<LocationModel> locationList = [];

    // Ensure that if address is empty, we do nothing
    if (event.address.isNotEmpty) {
      try {
        // Get locations from address

        var result = await GeocodingPlatform.instance
            ?.locationFromAddress(event.address);

        // If the result is not null, process the locations
        if (result != null) {
          for (var location in result) {
            final latitude = location.latitude;
            final longitude = location.longitude;

            // Fetch placemarks for the coordinates
            var places = await GeocodingPlatform.instance
                ?.placemarkFromCoordinates(latitude, longitude);

            if (places != null) {
              logger.info('uniquePlaces $places');
              // Filter unique locations by locality
              var uniquePlaces = places
                  .where((item) =>
                      item.postalCode != null && item.locality != null)
                  .toList()
                  .unique((place) => place.locality);

              // Process each place and add to the location list
              for (var item in uniquePlaces) {
                final sublocality = item.subLocality ?? "";
                locationList.add(
                  LocationModel(
                    sublocality.isNotEmpty &&
                            event.address.toLowerCase() ==
                                sublocality.toLowerCase()
                        ? sublocality
                        : item.locality?.toLowerCase().replaceAll(" ", "") ??
                            "${Random().nextInt(10000)}",
                    latitude,
                    longitude,
                    sublocality.isNotEmpty &&
                            event.address.toLowerCase() ==
                                sublocality.toLowerCase()
                        ? sublocality
                        : item.locality ?? "",
                    item.postalCode ?? "${Random().nextInt(10000)}",
                    item.administrativeArea ?? "",
                    item.country ?? "",
                    false,
                  ),
                );
              }
            }
          }

          // Emit the state once all asynchronous operations are complete
          emit(LocationSuccess(locationList));
        }
      } catch (e) {
        // Handle any errors that might occur during the process
        emit(LocationFail(e.toString()));
      }
    }
  }

  Future<void> getSavedLocationData(
      GetSavedLocationData event, Emitter<LocationState> emit) async {
    await snycSavedLocationData();
    final weatherData = await weatherUsecase.getAllWeatherDate();
    if (weatherData.isNotEmpty) {
      emit(LocationSavadDataSuccess(weatherData));
    } else {
      emit(LocationWeatherDataFail('No saved location found.'));
    }
  }

  Future<void> snycSavedLocationData() async {
    final locationModel = await locationUsecase.getAllLocationDate();
    if (locationModel.isNotEmpty) {
      locationModel.forEach(
        (item) async {
          try {
            // Fetch weather data using latitude and longitude
            final weather = await WeatherApi().request(
              latitude: item.latitude,
              longitude: item.longitude,
              current: {
                WeatherCurrent.precipitation,
                WeatherCurrent.cloud_cover,
                WeatherCurrent.wind_speed_10m,
                WeatherCurrent.is_day,
                WeatherCurrent.temperature_2m,
                WeatherCurrent.weather_code,
                WeatherCurrent.wind_direction_10m,
                WeatherCurrent.relative_humidity_2m,
                WeatherCurrent.surface_pressure,
              },
              hourly: {
                WeatherHourly.temperature_2m,
                WeatherHourly.relative_humidity_2m,
                WeatherHourly.visibility,
              },
              daily: {
                WeatherDaily.sunset,
                WeatherDaily.sunrise,
                WeatherDaily.uv_index_max,
              },
            );

            await synceWeatherData(item, weather);
          } catch (error) {
            logger.info('getCurrentWeather $error');
            // Handle errors appropriately
          }
        },
      );
    }
  }

  Future<void> synceWeatherData(
      LocationModel locationModel, ApiResponse<WeatherApi> weather) async {
    String subLocality = locationModel.subLocality;
    String currentTemperature = "-:-";
    String minTemperature = "-:-";
    String maxTemperature = "-:-";
    String sunriseTime = "-:-";
    String sunsetTime = "-:-";
    String weatherConditionText = "-:-";
    String weatherConditionImagePath = AppImages.icSunny;
    List<HourlyWeather> hourlyDataList =
        List<HourlyWeather>.empty(growable: true);
    List<DailyWeather> dailyDataList = List<DailyWeather>.empty(growable: true);
    final hourlyData = weather.hourlyData[WeatherHourly.temperature_2m];

    // Find the closest time for the temperature
    if (hourlyData != null) {
      DateTime now = DateTime.now();
      DateTime currentDate = DateTime(now.year, now.month, now.day);

      // Filter the hourly data to include only today's entries
      Map<DateTime, num> filteredData = Map.fromEntries(
        hourlyData.values.entries.where((entry) =>
            entry.key.year == currentDate.year &&
            entry.key.month == currentDate.month &&
            entry.key.day == currentDate.day),
      );

      // Calculate min and max temperatures
      if (filteredData.isNotEmpty) {
        minTemperature = filteredData.values
            .reduce((a, b) => a < b ? a : b)
            .round()
            .toString();
        maxTemperature = filteredData.values
            .reduce((a, b) => a > b ? a : b)
            .round()
            .toString();
      }
    }

    // Format sunrise and sunset times
    final sunrise = weather.dailyData[WeatherDaily.sunrise];
    final sunset = weather.dailyData[WeatherDaily.sunset];

    if (sunrise != null) {
      num timestamp = sunrise.values.values.first;
      DateTime dateTime =
          DateTime.fromMillisecondsSinceEpoch((timestamp * 1000).toInt());
      sunriseTime = DateFormat('hh:mm a').format(dateTime);
    }

    if (sunset != null) {
      num timestamp = sunset.values.values.first;
      DateTime dateTime =
          DateTime.fromMillisecondsSinceEpoch((timestamp * 1000).toInt());
      sunsetTime = DateFormat('hh:mm a').format(dateTime);
    }

    currentTemperature = weather
            .currentData[WeatherCurrent.temperature_2m]?.value
            .toInt()
            .toString() ??
        "-:-";

    int isDay = weather.currentData[WeatherCurrent.is_day]?.value.toInt() ?? 0;
    int weatherCode =
        weather.currentData[WeatherCurrent.weather_code]?.value.toInt() ?? 0;

    List<Map<String, dynamic>> combinedList = [];
    final hourlyWeatherCode = weather.hourlyData[WeatherHourly.weather_code];

    if (hourlyData != null && hourlyWeatherCode != null) {
      for (var date in hourlyData.values.keys) {
        if (hourlyWeatherCode.values.containsKey(date)) {
          // If the DateTime key exists in both maps, combine the values into a list or map
          combinedList.add({
            'date': date,
            'tamp': hourlyWeatherCode.values[date], // Value from map1
            'weatherCode':
                hourlyWeatherCode.values[date]?.toInt(), // Value from map2
          });
        }
      }

      combinedList.forEach((item) {
        hourlyDataList.add(
            HourlyWeather(item['date'], item['tamp'], item['weatherCode']));
      });
      logger.info('hourlyDataList : $hourlyDataList');
    }

    final dailyWeatherCode = weather.dailyData[WeatherDaily.weather_code];

    final dailyTemperatureMin =
        weather.dailyData[WeatherDaily.temperature_2m_max];

    final dailyTemperatureMax =
        weather.dailyData[WeatherDaily.temperature_2m_min];

    if (dailyWeatherCode != null &&
        dailyTemperatureMin != null &&
        dailyTemperatureMax != null) {
      for (var date in dailyWeatherCode.values.keys) {
        if (dailyTemperatureMin.values.containsKey(date) &&
            dailyTemperatureMax.values.containsKey(date)) {
          // If the DateTime key exists in both maps, combine the values into a list or map
          combinedList.add({
            'date': date,
            'minTamp': dailyTemperatureMin.values[date],
            'maxTamp': dailyTemperatureMax.values[date],
            'weatherCode': dailyWeatherCode.values[date]?.toInt(),
          });
        }
      }

      combinedList.forEach((item) {
        dailyDataList.add(DailyWeather(item['date'], item['minTamp'],
            item['maxTamp'], item['weatherCode']));
      });
      logger.info('dailyDataList : $dailyDataList');
    }

    final double precipitation =
        weather.currentData[WeatherCurrent.precipitation]?.value ?? 0.0;
    final double windSpeed =
        weather.currentData[WeatherCurrent.wind_speed_10m]?.value ?? 0.0;
    final String windDirection = windAngleToDirection(
        weather.currentData[WeatherCurrent.wind_direction_10m]?.value ?? 0.0);
    final double humidity =
        weather.currentData[WeatherCurrent.relative_humidity_2m]?.value ?? 0.0;
    final double visibility =
        weather.currentData[WeatherCurrent.relative_humidity_2m]?.value ?? 0.0;
    final double uvIndex =
        weather.currentData[WeatherCurrent.relative_humidity_2m]?.value ?? 0.0;
    final double surfacePressure =
        weather.currentData[WeatherCurrent.surface_pressure]?.value ?? 0.0;

    // Determine weather condition text and image
    weatherConditionText = isDay == 1
        ? WeatherCondition.fromCode(weatherCode).dayDescription
        : WeatherCondition.fromCode(weatherCode).nightDescription;

    weatherConditionImagePath = isDay == 1
        ? WeatherCondition.fromCode(weatherCode).dayImage
        : WeatherCondition.fromCode(weatherCode).nightImage;

    // Create WeatherDataModel to save the data
    final WeatherDataModel weatherDataModel = WeatherDataModel(
      subLocality.toLowerCase().replaceAll(" ", ""),
      subLocality,
      currentTemperature,
      minTemperature,
      maxTemperature,
      sunriseTime,
      sunsetTime,
      weatherConditionText,
      weatherConditionImagePath,
      precipitation,
      windSpeed,
      windDirection,
      humidity,
      visibility,
      uvIndex,
      surfacePressure,
      locationModel.isSelected,
      isDay,
      hourlyData: hourlyDataList,
      dailyData: dailyDataList,
    );

    // Save the weather data using the usecase
    await weatherUsecase.addWeatherDate(weatherDataModel);
  }

  Future<void> addLocationData(
      AddLocation event, Emitter<LocationState> emit) async {
    try {
      await locationUsecase.addLocationDate(event.locationModel);
      // Fetch weather data using latitude and longitude
      final weather = await WeatherApi().request(
        latitude: event.locationModel.latitude,
        longitude: event.locationModel.longitude,
        current: {
          WeatherCurrent.precipitation,
          WeatherCurrent.cloud_cover,
          WeatherCurrent.wind_speed_10m,
          WeatherCurrent.is_day,
          WeatherCurrent.temperature_2m,
          WeatherCurrent.weather_code,
          WeatherCurrent.wind_direction_10m,
          WeatherCurrent.relative_humidity_2m,
          WeatherCurrent.surface_pressure,
        },
        hourly: {
          WeatherHourly.temperature_2m,
          WeatherHourly.relative_humidity_2m,
          WeatherHourly.visibility,
        },
        daily: {
          WeatherDaily.sunset,
          WeatherDaily.sunrise,
          WeatherDaily.uv_index_max,
        },
      );

      await updateWeatherData(event.locationModel, weather);
    } catch (error) {
      logger.info('getCurrentWeather $error');
      // Handle errors appropriately
      emit(LocationWeatherDataFail(
          error.toString())); // Emit failure state with the error
    }
  }

  Future<void> deleteLocationData(
      DeleteSavedLocationData event, Emitter<LocationState> emit) async {
    try {
      final locationData = await locationUsecase.getLocationDate(event.id);
      if (locationData != null) {
        await locationUsecase.deleteLocationDate(locationData);
      }

      final weatherData = await weatherUsecase.getWeatherDate(event.id);
      if (weatherData != null) {
        await weatherUsecase.deleteWeatherDate(weatherData);
      }

      add(GetSavedLocationData());
      // Fetch weather data using latitude and longitude
    } catch (error) {
      logger.info('getCurrentWeather $error');
      // Handle errors appropriately
      emit(LocationWeatherDataFail(
          error.toString())); // Emit failure state with the error
    }
  }

  Future<void> updateWeatherData(
      LocationModel locationModel, ApiResponse<WeatherApi> weather) async {
    String subLocality = locationModel.subLocality;
    String currentTemperature = "-:-";
    String minTemperature = "-:-";
    String maxTemperature = "-:-";
    String sunriseTime = "-:-";
    String sunsetTime = "-:-";
    String weatherConditionText = "-:-";
    String weatherConditionImagePath = AppImages.icSunny;
    List<HourlyWeather> hourlyDataList =
        List<HourlyWeather>.empty(growable: true);
    List<DailyWeather> dailyDataList = List<DailyWeather>.empty(growable: true);
    final hourlyData = weather.hourlyData[WeatherHourly.temperature_2m];

    // Find the closest time for the temperature
    if (hourlyData != null) {
      DateTime now = DateTime.now();
      DateTime currentDate = DateTime(now.year, now.month, now.day);

      // Filter the hourly data to include only today's entries
      Map<DateTime, num> filteredData = Map.fromEntries(
        hourlyData.values.entries.where((entry) =>
            entry.key.year == currentDate.year &&
            entry.key.month == currentDate.month &&
            entry.key.day == currentDate.day),
      );

      // Calculate min and max temperatures
      if (filteredData.isNotEmpty) {
        minTemperature = filteredData.values
            .reduce((a, b) => a < b ? a : b)
            .round()
            .toString();
        maxTemperature = filteredData.values
            .reduce((a, b) => a > b ? a : b)
            .round()
            .toString();
      }
    }

    // Format sunrise and sunset times
    final sunrise = weather.dailyData[WeatherDaily.sunrise];
    final sunset = weather.dailyData[WeatherDaily.sunset];

    if (sunrise != null) {
      num timestamp = sunrise.values.values.first;
      DateTime dateTime =
          DateTime.fromMillisecondsSinceEpoch((timestamp * 1000).toInt());
      sunriseTime = DateFormat('hh:mm a').format(dateTime);
    }

    if (sunset != null) {
      num timestamp = sunset.values.values.first;
      DateTime dateTime =
          DateTime.fromMillisecondsSinceEpoch((timestamp * 1000).toInt());
      sunsetTime = DateFormat('hh:mm a').format(dateTime);
    }

    currentTemperature = weather
            .currentData[WeatherCurrent.temperature_2m]?.value
            .toInt()
            .toString() ??
        "-:-";

    int isDay = weather.currentData[WeatherCurrent.is_day]?.value.toInt() ?? 0;
    int weatherCode =
        weather.currentData[WeatherCurrent.weather_code]?.value.toInt() ?? 0;

    List<Map<String, dynamic>> combinedList = [];

    final hourlyWeatherCode = weather.hourlyData[WeatherHourly.weather_code];

    if (hourlyData != null && hourlyWeatherCode != null) {
      for (var date in hourlyData.values.keys) {
        if (hourlyWeatherCode.values.containsKey(date)) {
          // If the DateTime key exists in both maps, combine the values into a list or map
          combinedList.add({
            'date': date,
            'tamp': hourlyWeatherCode.values[date], // Value from map1
            'weatherCode':
                hourlyWeatherCode.values[date]?.toInt(), // Value from map2
          });
        }
      }

      combinedList.forEach((item) {
        hourlyDataList.add(
            HourlyWeather(item['date'], item['tamp'], item['weatherCode']));
      });
      logger.info('hourlyDataList : $hourlyDataList');
    }

    final dailyWeatherCode = weather.dailyData[WeatherDaily.weather_code];

    final dailyTemperatureMin =
        weather.dailyData[WeatherDaily.temperature_2m_max];

    final dailyTemperatureMax =
        weather.dailyData[WeatherDaily.temperature_2m_min];

    if (dailyWeatherCode != null &&
        dailyTemperatureMin != null &&
        dailyTemperatureMax != null) {
      for (var date in dailyWeatherCode.values.keys) {
        if (dailyTemperatureMin.values.containsKey(date) &&
            dailyTemperatureMax.values.containsKey(date)) {
          // If the DateTime key exists in both maps, combine the values into a list or map
          combinedList.add({
            'date': date,
            'minTamp': dailyTemperatureMin.values[date],
            'maxTamp': dailyTemperatureMax.values[date],
            'weatherCode': dailyWeatherCode.values[date]?.toInt(),
          });
        }
      }

      combinedList.forEach((item) {
        dailyDataList.add(DailyWeather(item['date'], item['minTamp'],
            item['maxTamp'], item['weatherCode']));
      });
      logger.info('dailyDataList : $dailyDataList');
    }

    final double precipitation =
        weather.currentData[WeatherCurrent.precipitation]?.value ?? 0.0;
    final double windSpeed =
        weather.currentData[WeatherCurrent.wind_speed_10m]?.value ?? 0.0;
    final String windDirection = windAngleToDirection(
        weather.currentData[WeatherCurrent.wind_direction_10m]?.value ?? 0.0);
    final double humidity =
        weather.currentData[WeatherCurrent.relative_humidity_2m]?.value ?? 0.0;
    final double visibility =
        weather.currentData[WeatherCurrent.relative_humidity_2m]?.value ?? 0.0;
    final double uvIndex =
        weather.currentData[WeatherCurrent.relative_humidity_2m]?.value ?? 0.0;
    final double surfacePressure =
        weather.currentData[WeatherCurrent.surface_pressure]?.value ?? 0.0;

    // Determine weather condition text and image
    weatherConditionText = isDay == 1
        ? WeatherCondition.fromCode(weatherCode).dayDescription
        : WeatherCondition.fromCode(weatherCode).nightDescription;

    weatherConditionImagePath = isDay == 1
        ? WeatherCondition.fromCode(weatherCode).dayImage
        : WeatherCondition.fromCode(weatherCode).nightImage;

    // Create WeatherDataModel to save the data
    final WeatherDataModel weatherDataModel = WeatherDataModel(
      subLocality.toLowerCase().replaceAll(" ", ""),
      subLocality,
      currentTemperature,
      minTemperature,
      maxTemperature,
      sunriseTime,
      sunsetTime,
      weatherConditionText,
      weatherConditionImagePath,
      precipitation,
      windSpeed,
      windDirection,
      humidity,
      visibility,
      uvIndex,
      surfacePressure,
      locationModel.isSelected,
      isDay,
      hourlyData: hourlyDataList,
      dailyData: dailyDataList,
    );

    // Save the weather data using the usecase
    await weatherUsecase.addWeatherDate(weatherDataModel);
    // await initWeatherData(event, emit);
    add(GetSavedLocationData());
    // final weatherData = await weatherUsecase.getAllWeatherDate();
  }
}

String windAngleToDirection(double angle) {
  if (angle >= 337.5 || angle < 22.5) {
    return "N"; // North
  } else if (angle >= 22.5 && angle < 67.5) {
    return "NE"; // North-East
  } else if (angle >= 67.5 && angle < 112.5) {
    return "E"; // East
  } else if (angle >= 112.5 && angle < 157.5) {
    return "SE"; // South-East
  } else if (angle >= 157.5 && angle < 202.5) {
    return "S"; // South
  } else if (angle >= 202.5 && angle < 247.5) {
    return "SW"; // South-West
  } else if (angle >= 247.5 && angle < 292.5) {
    return "W"; // West
  } else if (angle >= 292.5 && angle < 337.5) {
    return "NW"; // North-West
  } else {
    return "Invalid"; // If the angle is out of bounds (not between 0 and 360)
  }
}

extension Unique<E, Id> on List<E> {
  List<E> unique([Id Function(E element)? id, bool inplace = true]) {
    final ids = Set();
    var list = inplace ? this : List<E>.from(this);
    list.retainWhere((x) => ids.add(id != null ? id(x) : x as Id));
    return list;
  }
}
