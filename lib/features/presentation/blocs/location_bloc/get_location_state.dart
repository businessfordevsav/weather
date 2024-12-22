part of 'get_location_cubit.dart';

@immutable
abstract class GetLocationState {}

class GetLocationInitial extends GetLocationState {}

class LocationLoading extends GetLocationState {}

class LocationSuccess extends GetLocationState {
  final Position location;
  final Placemark place;
  LocationSuccess(this.location, this.place);
}

class LocationFail extends GetLocationState {
  final String error;
  LocationFail(this.error);
}
