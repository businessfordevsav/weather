// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class LocationModel extends _LocationModel
    with RealmEntity, RealmObjectBase, RealmObject {
  LocationModel(
    String id,
    double latitude,
    double longitude,
    String subLocality,
    String postalCode,
    String state,
    String country,
    bool isSelected,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'latitude', latitude);
    RealmObjectBase.set(this, 'longitude', longitude);
    RealmObjectBase.set(this, 'subLocality', subLocality);
    RealmObjectBase.set(this, 'postalCode', postalCode);
    RealmObjectBase.set(this, 'state', state);
    RealmObjectBase.set(this, 'country', country);
    RealmObjectBase.set(this, 'isSelected', isSelected);
  }

  LocationModel._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  double get latitude =>
      RealmObjectBase.get<double>(this, 'latitude') as double;
  @override
  set latitude(double value) => RealmObjectBase.set(this, 'latitude', value);

  @override
  double get longitude =>
      RealmObjectBase.get<double>(this, 'longitude') as double;
  @override
  set longitude(double value) => RealmObjectBase.set(this, 'longitude', value);

  @override
  String get subLocality =>
      RealmObjectBase.get<String>(this, 'subLocality') as String;
  @override
  set subLocality(String value) =>
      RealmObjectBase.set(this, 'subLocality', value);

  @override
  String get postalCode =>
      RealmObjectBase.get<String>(this, 'postalCode') as String;
  @override
  set postalCode(String value) =>
      RealmObjectBase.set(this, 'postalCode', value);

  @override
  String get state => RealmObjectBase.get<String>(this, 'state') as String;
  @override
  set state(String value) => RealmObjectBase.set(this, 'state', value);

  @override
  String get country => RealmObjectBase.get<String>(this, 'country') as String;
  @override
  set country(String value) => RealmObjectBase.set(this, 'country', value);

  @override
  bool get isSelected => RealmObjectBase.get<bool>(this, 'isSelected') as bool;
  @override
  set isSelected(bool value) => RealmObjectBase.set(this, 'isSelected', value);

  @override
  Stream<RealmObjectChanges<LocationModel>> get changes =>
      RealmObjectBase.getChanges<LocationModel>(this);

  @override
  Stream<RealmObjectChanges<LocationModel>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<LocationModel>(this, keyPaths);

  @override
  LocationModel freeze() => RealmObjectBase.freezeObject<LocationModel>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'latitude': latitude.toEJson(),
      'longitude': longitude.toEJson(),
      'subLocality': subLocality.toEJson(),
      'postalCode': postalCode.toEJson(),
      'state': state.toEJson(),
      'country': country.toEJson(),
      'isSelected': isSelected.toEJson(),
    };
  }

  static EJsonValue _toEJson(LocationModel value) => value.toEJson();
  static LocationModel _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'latitude': EJsonValue latitude,
        'longitude': EJsonValue longitude,
        'subLocality': EJsonValue subLocality,
        'postalCode': EJsonValue postalCode,
        'state': EJsonValue state,
        'country': EJsonValue country,
        'isSelected': EJsonValue isSelected,
      } =>
        LocationModel(
          fromEJson(id),
          fromEJson(latitude),
          fromEJson(longitude),
          fromEJson(subLocality),
          fromEJson(postalCode),
          fromEJson(state),
          fromEJson(country),
          fromEJson(isSelected),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(LocationModel._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, LocationModel, 'LocationModel', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('latitude', RealmPropertyType.double),
      SchemaProperty('longitude', RealmPropertyType.double),
      SchemaProperty('subLocality', RealmPropertyType.string),
      SchemaProperty('postalCode', RealmPropertyType.string),
      SchemaProperty('state', RealmPropertyType.string),
      SchemaProperty('country', RealmPropertyType.string),
      SchemaProperty('isSelected', RealmPropertyType.bool),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
