import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:open_meteo/open_meteo.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather/core/assets/app_images.dart';
import 'package:weather/core/utils/logger.dart';
import 'package:weather/core/utils/weather_condition.dart';
import 'package:weather/features/data/models/location_model.dart';
import 'package:weather/features/data/models/weather_data_model.dart';
import 'package:weather/features/domain/usecases/location_usecase.dart';
import 'package:weather/features/domain/usecases/weather_usecase.dart';

part 'weather_state.dart';
part 'weather_event.dart';

class WeatherBloc extends Bloc<WeatherEvent, GetWeatherState> {
  final WeatherUsecase weatherUsecase;
  final LocationUsecase locationUsecase;
  WeatherBloc({required this.weatherUsecase, required this.locationUsecase})
      : super(GetLocationInitial()) {
    on<GetWeatherDataEvent>(initLocation);
    on<GetLocalWeatherDataEvent>(initWeatherData);
  }

  late Position position;
  late Placemark place;

  // Async method for initializing location and getting weather data
  Future<void> initLocation(
      GetWeatherDataEvent event, Emitter<GetWeatherState> emit) async {
    if (await Permission.location.isDenied) {
      // Request permission
      PermissionStatus status = await Permission.location.request();

      if (status.isGranted) {
        await getCurrentWeather(event, emit); // Ensure this is awaited
      } else if (status.isDenied) {
        add(GetLocalWeatherDataEvent());
      } else if (status.isPermanentlyDenied) {
        openAppSettings();
      }
    } else {
      await getCurrentWeather(event, emit); // Ensure this is awaited
    }
  }

  // Async method for getting the current position
  Future<Position> getLocation() async {
    try {
      position = await Geolocator.getCurrentPosition(
        locationSettings:
            const LocationSettings(accuracy: LocationAccuracy.high),
      );
      return position;
    } catch (error) {
      // Handle error (e.g., log it or show a user-friendly message)
      throw error; // Rethrow the error if needed
    }
  }

  // Async method for getting country info based on location
  Future<Placemark> getCountry(Emitter<GetWeatherState> emit) async {
    emit(WeatherLoading());
    try {
      position = await getLocation(); // Ensure location is retrieved first
      final List<Placemark>? places = await GeocodingPlatform.instance
          ?.placemarkFromCoordinates(position.latitude, position.longitude);
      if (places != null) {
        place = places[0];

        String subLocality = "-:-";
        if (place.subLocality.toString().isNotEmpty) {
          subLocality = place.subLocality.toString();
        } else if (place.locality.toString().isNotEmpty) {
          subLocality = place.locality.toString();
        } else if (place.administrativeArea.toString().isNotEmpty) {
          subLocality = place.administrativeArea.toString();
        } else if (place.country.toString().isNotEmpty) {
          subLocality = place.country.toString();
        } else {
          subLocality = "Unknown Location";
        }
        if (subLocality.isNotEmpty) {
          final locationDataList = await locationUsecase.getAllLocationDate();

          locationDataList.forEach((item) async {
            await locationUsecase.updateLocationDate(LocationModel(
              item.id,
              item.latitude,
              item.longitude,
              item.subLocality,
              item.postalCode,
              item.state,
              item.country,
              false,
            ));
          });
          logger.info('place: $place');
          final locationModel = LocationModel(
            subLocality.replaceAll(" ", "").toLowerCase(),
            position.latitude,
            position.longitude,
            subLocality,
            place.postalCode?.replaceAll(" ", "") ?? "${Random().nextInt(100)}",
            place.administrativeArea ?? "",
            place.country ?? "",
            true,
          );
          locationUsecase.addLocationDate(locationModel);
          emit(CurrentLocationSuccess(locationModel));
        }
      }
      return place;
    } catch (error) {
      logger.error("getCountry $error");
      emit(WeatherFail(error.toString()));
      rethrow;
    }
  }

  // Async method for fetching current weather
  Future<void> getCurrentWeather(
      GetWeatherDataEvent event, Emitter<GetWeatherState> emit) async {
    emit(WeatherLoading());
    try {
      // Get country information first
      await getCountry(emit);

      // Fetch weather data using latitude and longitude
      final weather = await WeatherApi().request(
        latitude: position.latitude,
        longitude: position.longitude,
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
          WeatherHourly.weather_code
        },
        daily: {
          WeatherDaily.sunset,
          WeatherDaily.sunrise,
          WeatherDaily.uv_index_max,
          WeatherDaily.temperature_2m_max,
          WeatherDaily.temperature_2m_min,
          WeatherDaily.weather_code,
        },
      );
      logger.error(
          "weather :: latitude: ${weather.latitude} :: longitude: ${weather.longitude}");
      await updateWeatherData(event, emit, weather);
    } catch (error) {
      print('getCurrentWeather $error');
      // Handle errors appropriately
      emit(WeatherFail(error.toString())); // Emit failure state with the error
    }
  }

  // Method for updating weather data
  Future<void> updateWeatherData(GetWeatherDataEvent event,
      Emitter<GetWeatherState> emit, ApiResponse<WeatherApi> weather) async {
    String subLocality = "-:-";
    String currentTemperature = "-:-";
    String minTemperature = "-:-";
    String maxTemperature = "-:-";
    String sunriseTime = "-:-";
    String sunsetTime = "-:-";
    String weatherConditionText = "-:-";
    String weatherConditionImagePath = AppImages.icSunny;
    // String postalCode = place.postalCode?.replaceAll(" ", "") ?? "${Random().nextInt(2000)}";
    List<HourlyWeather> hourlyDataList =
        List<HourlyWeather>.empty(growable: true);
    List<DailyWeather> dailyDataList = List<DailyWeather>.empty(growable: true);

    // Get the sub-locality or location

    if (place.subLocality.toString().isNotEmpty) {
      subLocality = place.subLocality.toString();
    } else if (place.locality.toString().isNotEmpty) {
      subLocality = place.locality.toString();
    } else if (place.administrativeArea.toString().isNotEmpty) {
      subLocality = place.administrativeArea.toString();
    } else if (place.country.toString().isNotEmpty) {
      subLocality = place.country.toString();
    } else {
      subLocality = "Unknown Location";
    }

    final hourlyData = weather.hourlyData[WeatherHourly.temperature_2m];

    // Find the closest time for the temperature

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

    final hourlyWeatherCode = weather.hourlyData[WeatherHourly.weather_code];

    if (hourlyData != null && hourlyWeatherCode != null) {
      List<Map<String, dynamic>> combinedList = [];
      for (var date in hourlyData.values.keys) {
        if (hourlyWeatherCode.values.containsKey(date)) {
          // If the DateTime key exists in both maps, combine the values into a list or map
          combinedList.add({
            'date': date.toString(),
            'tamp': hourlyData.values[date]?.toDouble(), // Value from map1
            'weatherCode':
                hourlyWeatherCode.values[date]?.toInt(), // Value from map2
          });
        }
      }

      combinedList.forEach((item) {
        hourlyDataList.add(
            HourlyWeather(item['date'], item['tamp'], item['weatherCode']));
      });
      // logger.info('hourlyDataList : $hourlyDataList');
    }

    final dailyWeatherCode = weather.dailyData[WeatherDaily.weather_code];

    final dailyTemperatureMin =
        weather.dailyData[WeatherDaily.temperature_2m_min];

    final dailyTemperatureMax =
        weather.dailyData[WeatherDaily.temperature_2m_max];

    if (dailyWeatherCode != null &&
        dailyTemperatureMin != null &&
        dailyTemperatureMax != null) {
      List<Map<String, dynamic>> combinedList = [];

      DateTime now = DateTime.now().toLocal();
      DateTime currentDate = DateTime(now.year, now.month, now.day);

      // Filter the hourly data to include only today's entries
      Map<DateTime, num> filteredTemperatureMinData = Map.fromEntries(
        dailyTemperatureMin.values.entries.where((entry) =>
            entry.key.year == currentDate.year &&
            entry.key.month == currentDate.month &&
            entry.key.day == currentDate.day),
      );

      // Calculate min and max temperatures
      if (filteredTemperatureMinData.isNotEmpty) {
        minTemperature =
            filteredTemperatureMinData.values.first.toInt().toString();
      }
      Map<DateTime, num> filteredMaxTemperatureData = Map.fromEntries(
        dailyTemperatureMax.values.entries.where((entry) =>
            entry.key.year == currentDate.year &&
            entry.key.month == currentDate.month &&
            entry.key.day == currentDate.day),
      );

      if (filteredMaxTemperatureData.isNotEmpty) {
        maxTemperature =
            filteredMaxTemperatureData.values.first.toInt().toString();
      }

      for (var date in dailyWeatherCode.values.keys) {
        if (dailyTemperatureMin.values.containsKey(date) &&
            dailyTemperatureMax.values.containsKey(date)) {
          // If the DateTime key exists in both maps, combine the values into a list or map
          combinedList.add({
            'date': date.toString(),
            'minTamp': dailyTemperatureMin.values[date]?.toDouble(),
            'maxTamp': dailyTemperatureMax.values[date]?.toDouble(),
            'weatherCode': dailyWeatherCode.values[date]?.toInt(),
          });
        }
      }

      combinedList.forEach((item) {
        dailyDataList.add(DailyWeather(item['date'], item['minTamp'],
            item['maxTamp'], item['weatherCode']));
      });
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

    final allWeatherData = await weatherUsecase.getAllWeatherDate();

    for (var weather in allWeatherData) {
      await weatherUsecase.updateWeatherDate(WeatherDataModel(
        weather.id,
        weather.subLocality,
        weather.currentTemperature,
        weather.minTemperature,
        weather.maxTemperature,
        weather.sunriseTime,
        weather.sunsetTime,
        weather.weatherConditionText,
        weather.weatherConditionImagePath,
        weather.precipitation,
        weather.windSpeed,
        weather.windDirection,
        weather.humidity,
        weather.visibility,
        weather.uvIndex,
        weather.surfacePressure,
        false,
        weather.isDay,
        hourlyData: weather
            .hourlyData, // Correctly passing hourlyData as a named argument
        dailyData: weather
            .dailyData, // Correctly passing dailyData as a named argument
      ));
    }

    // Create WeatherDataModel to save the data
    final WeatherDataModel weatherDataModel = WeatherDataModel(
      subLocality.replaceAll(" ", "").toLowerCase(),
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
      true,
      isDay,
      hourlyData:
          hourlyDataList, // Correctly passing hourlyData as a named argument
      dailyData:
          dailyDataList, // Correctly passing dailyData as a named argument
    );

    // Save the weather data using the usecase
    await weatherUsecase.addWeatherDate(weatherDataModel);
    // await initWeatherData(event, emit);
    add(GetLocalWeatherDataEvent());
    // final weatherData = await weatherUsecase.getAllWeatherDate();
  }

  Future<void> initWeatherData(
      GetLocalWeatherDataEvent event, Emitter<GetWeatherState> emit) async {
    final locationDataList = await locationUsecase.getAllLocationDate();
    if (locationDataList.isNotEmpty) {
      final locationData =
          await locationDataList.where((item) => item.isSelected).first;
      final weatherData = await weatherUsecase.getWeatherDate(locationData.id);
      logger.error(
          'postalCode: ${locationData.postalCode} :: subLocality : ${locationData.subLocality}');
      if (weatherData != null) {
        emit(WeatherSuccess(weatherData));
      }
    }
  }

  // Helper method to find the closest time
  DateTime findClosestTime(Map<DateTime, num> data, DateTime now) {
    DateTime closestTime = DateTime(1900); // An arbitrary old date
    data.forEach((key, value) {
      if (key.isBefore(now) && key.isAfter(closestTime)) {
        closestTime = key;
      }
    });
    return closestTime;
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
}
