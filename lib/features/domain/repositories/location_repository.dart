import 'package:weather/features/data/models/location_model.dart';

abstract interface class LocationRepository {
  Future<void> addLocationDate(LocationModel locationDate);
  Future<void> updateLocationDate(LocationModel locationDate);

  Future<List<LocationModel>> getAllLocationDate();

  Future<LocationModel?> getLocationDate(String id);

  Future<void> deleteLocationDate(LocationModel locationDate);

  Future<void> addMultipleLocationDate(List<LocationModel> locationDate);
}