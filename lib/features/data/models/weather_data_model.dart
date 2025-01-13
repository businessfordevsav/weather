import 'package:realm/realm.dart';

part 'weather_data_model.realm.dart';

@RealmModel()
class _WeatherDataModel {
  @PrimaryKey()
  late String id;
  late String subLocality;
  late String currentTemperature;
  late String minTemperature;
  late String maxTemperature;
  late String sunriseTime;
  late String sunsetTime;
  late String weatherConditionText;
  late String weatherConditionImagePath;
  late double precipitation;
  late double windSpeed;
  late String windDirection;
  late double humidity;
  late double visibility;
  late double uvIndex;
  late double surfacePressure;
  late bool isCurrent;
  late int isDay;
  late List<$HourlyWeather> hourlyData;
  late List<$DailyWeather> dailyData;

  @override
  String toString() {
    return '[id: $id, subLocality: $subLocality, currentTemperature: $currentTemperature, minTemperature: $minTemperature, maxTemperature: $maxTemperature, sunriseTime: $sunriseTime, sunsetTime: $sunsetTime, weatherConditionText: $weatherConditionText, weatherConditionImagePath: $weatherConditionImagePath, precipitation: $precipitation, windSpeed: $windSpeed, windDirection: $windDirection, humidity: $humidity, visibility: $visibility, uvIndex: $uvIndex, surfacePressure: $surfacePressure, isCurrent :$isCurrent, isDay: $isDay, hourlyData: $hourlyData, dailyData : $dailyData]';
  }
}

@RealmModel()
class $HourlyWeather {
  late String dateTime;
  late double tamp;
  late int weatherCode;
  @override
  String toString() {
    return '[dateTime: $dateTime, tamp: $tamp, weatherCode: $weatherCode]';
  }
}

@RealmModel()
class $DailyWeather {
  late String dateTime;
  late double minTamp;
  late double maxTamp;
  late int weatherCode;
  @override
  String toString() {
    return '[dateTime: $dateTime, minTamp: $minTamp, maxTamp: $maxTamp, weatherCode: $weatherCode}';
  }
}
