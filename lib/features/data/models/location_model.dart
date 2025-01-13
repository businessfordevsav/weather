import 'package:realm/realm.dart';

part 'location_model.realm.dart';

@RealmModel()
class _LocationModel {
  @PrimaryKey()
  late String id;
  late double latitude;
  late double longitude;
  late String subLocality;
  late String postalCode;
  late String state;
  late String country;
  late bool isSelected;

  @override
  String toString() {
    return '[id: $id, latitude: $latitude, longitude: $longitude, subLocality: $subLocality, postalCode: $postalCode, state: $state, country: $country, isSelected: $isSelected]';
  }
}
