import 'package:injectable/injectable.dart';
import 'package:weather/core/local/local_storage.dart';
import 'package:weather/features/data/models/location_model.dart';
import 'package:weather/features/domain/repositories/location_repository.dart';

@Injectable(as: LocationRepository)
class LocationUsecase implements LocationRepository {
  final ILocalStorage _localStorage;
  const LocationUsecase(this._localStorage);
  @override
  Future<void> addLocationDate(LocationModel locationDate) async {
    final existingUser =
        await _localStorage.find<LocationModel>(locationDate.id);
    if (existingUser != null) {
      await _localStorage.update(locationDate);
    } else {
      await _localStorage.add(locationDate);
    }
  }

  @override
  Future<void> addMultipleLocationDate(List<LocationModel> locationDate) async {
    await _localStorage.addList(locationDate);
  }

  @override
  Future<void> deleteLocationDate(LocationModel locationDate) async {
    await _localStorage.delete(locationDate);
  }

  @override
  Future<List<LocationModel>> getAllLocationDate() async {
    return _localStorage.getAll<LocationModel>().toList();
  }

  @override
  Future<LocationModel?> getLocationDate(String id) async {
    return _localStorage.find<LocationModel>(id);
  }

  @override
  Future<void> updateLocationDate(LocationModel locationDate) async {
    await _localStorage.update(locationDate);
  }
}
