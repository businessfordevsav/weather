import 'package:weather/features/data/models/weather_data_model.dart';

abstract interface class WeatherRepository {
  Future<void> addWeatherDate(WeatherDataModel weatherDate);
  Future<void> updateWeatherDate(WeatherDataModel weatherDate);

  Future<List<WeatherDataModel>> getAllWeatherDate();

  Future<WeatherDataModel?> getWeatherDate(String id);

  Future<void> deleteWeatherDate(WeatherDataModel weatherDate);

  Future<void> addMultipleWeatherDate(List<WeatherDataModel> weatherDate);
}
