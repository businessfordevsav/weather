import 'package:injectable/injectable.dart';
import 'package:weather/core/local/local_storage.dart';
import 'package:weather/features/data/models/weather_data_model.dart';
import 'package:weather/features/domain/repositories/weather_repository.dart';

@Injectable(as: WeatherRepository)
class WeatherUsecase implements WeatherRepository {
  final ILocalStorage _localStorage;
  const WeatherUsecase(this._localStorage);

  @override
  Future<void> addMultipleWeatherDate(
      List<WeatherDataModel> weatherDate) async {
    await _localStorage.addList(weatherDate);
  }

  @override
  Future<void> addWeatherDate(WeatherDataModel weatherDate) async {
    final existingUser =
        await _localStorage.find<WeatherDataModel>(weatherDate.id);
    if (existingUser != null) {
      await _localStorage.update(weatherDate);
    } else {
      await _localStorage.add(weatherDate);
    }
  }

  @override
  Future<void> updateWeatherDate(WeatherDataModel weatherDate) async {
    await _localStorage.update(weatherDate);
  }

  @override
  Future<void> deleteWeatherDate(WeatherDataModel weatherDate) async {
    await _localStorage.delete(weatherDate);
  }

  @override
  Future<List<WeatherDataModel>> getAllWeatherDate() async {
    return _localStorage.getAll<WeatherDataModel>().toList();
  }

  @override
  Future<WeatherDataModel?> getWeatherDate(String id) async {
    return _localStorage.find<WeatherDataModel>(id);
  }
}
