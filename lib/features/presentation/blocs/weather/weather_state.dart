part of 'weather_bloc.dart';

@immutable
abstract class GetWeatherState {}

class GetLocationInitial extends GetWeatherState {}

class WeatherLoading extends GetWeatherState {}

class CurrentLocationSuccess extends GetWeatherState {
  final LocationModel locationModel;

  CurrentLocationSuccess(this.locationModel);
}

class WeatherSuccess extends GetWeatherState {
  final WeatherDataModel weather;
  WeatherSuccess(this.weather);
}

class WeatherFail extends GetWeatherState {
  final String error;
  WeatherFail(this.error);
}
