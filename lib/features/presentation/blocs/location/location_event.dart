part of 'location_bloc.dart';

@immutable
abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object?> get props => [];
}

class SearchPlaceFromAddressEvent extends LocationEvent {
  final String address;
  const SearchPlaceFromAddressEvent(this.address);

  @override
  List<Object> get props => [address];
}

class GetSavedLocationData extends LocationEvent {
  const GetSavedLocationData();
  @override
  List<Object?> get props => [];
}

class DeleteSavedLocationData extends LocationEvent {
  final String id;
  const DeleteSavedLocationData(this.id);
  @override
  List<Object?> get props => [id];
}

class AddLocation extends LocationEvent {
  final LocationModel locationModel;
  const AddLocation(this.locationModel);
  @override
  List<Object?> get props => [locationModel];
}
