import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:weather/core/utils/logger.dart';

part 'get_location_state.dart';

class GetLocationCubit extends Cubit<GetLocationState> {
  GetLocationCubit() : super(GetLocationInitial());

  static GetLocationCubit get(context) => BlocProvider.of(context);

  late Position position;
  late Placemark place;

  initLocation() async {
    bool isServiceEnabled;
    LocationPermission permission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();

    if (!isServiceEnabled) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('denied forever');
    } else if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('denied');
      }
    }
  }

  Future<Position> getLocation() async {
    await Geolocator.getCurrentPosition(
            locationSettings:
                const LocationSettings(accuracy: LocationAccuracy.high))
        .then((position) {
      this.position = position;
    }).catchError((error) {
      logger.error(error);
    });
    return position;
  }

  Future<Placemark> getCountry() async {
    emit(LocationLoading());
    await getLocation().then((value) async {
      await GeocodingPlatform.instance
          ?.placemarkFromCoordinates(position.latitude, position.longitude)
          .then((place) {
        this.place = place[0];
      });
    }).catchError((error) {
      emit(LocationFail(error));
    });
    emit(LocationSuccess(position, place));

    return place;
  }
}
