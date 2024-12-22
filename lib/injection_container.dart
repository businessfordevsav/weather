import 'package:get_it/get_it.dart';
import 'package:weather/features/presentation/blocs/location_bloc/get_location_cubit.dart';

final locator = GetIt.instance;
Future<void> initLocator() async {
  /// Cubit
  /// Location Cubit
  locator.registerFactory(
    () => GetLocationCubit()..initLocation(),
  );
}
