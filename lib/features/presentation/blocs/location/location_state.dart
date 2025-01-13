part of 'location_bloc.dart';

@immutable
abstract class LocationState {}

class GetLocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationSuccess extends LocationState {
  final List<LocationModel> locationModel;

  LocationSuccess(this.locationModel);
}

class LocationSavadDataSuccess extends LocationState {
  final List<WeatherDataModel> savedLocationWeatherDataList;

  LocationSavadDataSuccess(this.savedLocationWeatherDataList);
}


class LocationFail extends LocationState {
  final String error;
  LocationFail(this.error);
}

class LocationWeatherDataFail extends LocationState {
  final String error;
  LocationWeatherDataFail(this.error);
}
