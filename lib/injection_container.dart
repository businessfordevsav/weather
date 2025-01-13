import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/core/local/local_storage.dart';
import 'package:weather/core/local/realm_storage.dart';
import 'package:weather/features/domain/repositories/location_repository.dart';
import 'package:weather/features/domain/repositories/weather_repository.dart';
import 'package:weather/features/domain/usecases/location_usecase.dart';
import 'package:weather/features/domain/usecases/weather_usecase.dart';
import 'package:weather/features/presentation/blocs/location/location_bloc.dart';
import 'package:weather/features/presentation/blocs/weather/weather_bloc.dart';

final locator = GetIt.instance;
@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
Future<void> initLocator() async {
  locator.registerSingleton<ILocalStorage>(RealmStorage());

  // Register other services
  locator.registerFactory<WeatherUsecase>(() => WeatherUsecase(locator()));
  locator.registerFactory<WeatherRepository>(() => WeatherUsecase(locator()));

  locator.registerFactory<LocationUsecase>(() => LocationUsecase(locator()));
  locator.registerFactory<LocationRepository>(() => LocationUsecase(locator()));

  // Register other services (like WeatherRepository, etc.)
  locator.registerFactory(
      () => WeatherBloc(weatherUsecase: locator(), locationUsecase: locator()));
  locator.registerFactory(
      () => LocationBloc(weatherUsecase: locator(), locationUsecase: locator()));

  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => sharedPreferences);
}
