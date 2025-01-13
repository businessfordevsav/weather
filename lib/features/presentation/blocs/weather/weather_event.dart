

part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object?> get props => [];
}

class GetWeatherDataEvent extends WeatherEvent {
  const GetWeatherDataEvent();

  @override
  List<Object> get props => [];
}

class GetLocalWeatherDataEvent extends WeatherEvent {
  const GetLocalWeatherDataEvent();

  @override
  List<Object> get props => [];
}
