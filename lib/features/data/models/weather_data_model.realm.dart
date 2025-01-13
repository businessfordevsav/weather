// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_data_model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class WeatherDataModel extends _WeatherDataModel
    with RealmEntity, RealmObjectBase, RealmObject {
  WeatherDataModel(
    String id,
    String subLocality,
    String currentTemperature,
    String minTemperature,
    String maxTemperature,
    String sunriseTime,
    String sunsetTime,
    String weatherConditionText,
    String weatherConditionImagePath,
    double precipitation,
    double windSpeed,
    String windDirection,
    double humidity,
    double visibility,
    double uvIndex,
    double surfacePressure,
    bool isCurrent,
    int isDay, {
    Iterable<HourlyWeather> hourlyData = const [],
    Iterable<DailyWeather> dailyData = const [],
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'subLocality', subLocality);
    RealmObjectBase.set(this, 'currentTemperature', currentTemperature);
    RealmObjectBase.set(this, 'minTemperature', minTemperature);
    RealmObjectBase.set(this, 'maxTemperature', maxTemperature);
    RealmObjectBase.set(this, 'sunriseTime', sunriseTime);
    RealmObjectBase.set(this, 'sunsetTime', sunsetTime);
    RealmObjectBase.set(this, 'weatherConditionText', weatherConditionText);
    RealmObjectBase.set(
        this, 'weatherConditionImagePath', weatherConditionImagePath);
    RealmObjectBase.set(this, 'precipitation', precipitation);
    RealmObjectBase.set(this, 'windSpeed', windSpeed);
    RealmObjectBase.set(this, 'windDirection', windDirection);
    RealmObjectBase.set(this, 'humidity', humidity);
    RealmObjectBase.set(this, 'visibility', visibility);
    RealmObjectBase.set(this, 'uvIndex', uvIndex);
    RealmObjectBase.set(this, 'surfacePressure', surfacePressure);
    RealmObjectBase.set(this, 'isCurrent', isCurrent);
    RealmObjectBase.set(this, 'isDay', isDay);
    RealmObjectBase.set<RealmList<HourlyWeather>>(
        this, 'hourlyData', RealmList<HourlyWeather>(hourlyData));
    RealmObjectBase.set<RealmList<DailyWeather>>(
        this, 'dailyData', RealmList<DailyWeather>(dailyData));
  }

  WeatherDataModel._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get subLocality =>
      RealmObjectBase.get<String>(this, 'subLocality') as String;
  @override
  set subLocality(String value) =>
      RealmObjectBase.set(this, 'subLocality', value);

  @override
  String get currentTemperature =>
      RealmObjectBase.get<String>(this, 'currentTemperature') as String;
  @override
  set currentTemperature(String value) =>
      RealmObjectBase.set(this, 'currentTemperature', value);

  @override
  String get minTemperature =>
      RealmObjectBase.get<String>(this, 'minTemperature') as String;
  @override
  set minTemperature(String value) =>
      RealmObjectBase.set(this, 'minTemperature', value);

  @override
  String get maxTemperature =>
      RealmObjectBase.get<String>(this, 'maxTemperature') as String;
  @override
  set maxTemperature(String value) =>
      RealmObjectBase.set(this, 'maxTemperature', value);

  @override
  String get sunriseTime =>
      RealmObjectBase.get<String>(this, 'sunriseTime') as String;
  @override
  set sunriseTime(String value) =>
      RealmObjectBase.set(this, 'sunriseTime', value);

  @override
  String get sunsetTime =>
      RealmObjectBase.get<String>(this, 'sunsetTime') as String;
  @override
  set sunsetTime(String value) =>
      RealmObjectBase.set(this, 'sunsetTime', value);

  @override
  String get weatherConditionText =>
      RealmObjectBase.get<String>(this, 'weatherConditionText') as String;
  @override
  set weatherConditionText(String value) =>
      RealmObjectBase.set(this, 'weatherConditionText', value);

  @override
  String get weatherConditionImagePath =>
      RealmObjectBase.get<String>(this, 'weatherConditionImagePath') as String;
  @override
  set weatherConditionImagePath(String value) =>
      RealmObjectBase.set(this, 'weatherConditionImagePath', value);

  @override
  double get precipitation =>
      RealmObjectBase.get<double>(this, 'precipitation') as double;
  @override
  set precipitation(double value) =>
      RealmObjectBase.set(this, 'precipitation', value);

  @override
  double get windSpeed =>
      RealmObjectBase.get<double>(this, 'windSpeed') as double;
  @override
  set windSpeed(double value) => RealmObjectBase.set(this, 'windSpeed', value);

  @override
  String get windDirection =>
      RealmObjectBase.get<String>(this, 'windDirection') as String;
  @override
  set windDirection(String value) =>
      RealmObjectBase.set(this, 'windDirection', value);

  @override
  double get humidity =>
      RealmObjectBase.get<double>(this, 'humidity') as double;
  @override
  set humidity(double value) => RealmObjectBase.set(this, 'humidity', value);

  @override
  double get visibility =>
      RealmObjectBase.get<double>(this, 'visibility') as double;
  @override
  set visibility(double value) =>
      RealmObjectBase.set(this, 'visibility', value);

  @override
  double get uvIndex => RealmObjectBase.get<double>(this, 'uvIndex') as double;
  @override
  set uvIndex(double value) => RealmObjectBase.set(this, 'uvIndex', value);

  @override
  double get surfacePressure =>
      RealmObjectBase.get<double>(this, 'surfacePressure') as double;
  @override
  set surfacePressure(double value) =>
      RealmObjectBase.set(this, 'surfacePressure', value);

  @override
  bool get isCurrent => RealmObjectBase.get<bool>(this, 'isCurrent') as bool;
  @override
  set isCurrent(bool value) => RealmObjectBase.set(this, 'isCurrent', value);

  @override
  int get isDay => RealmObjectBase.get<int>(this, 'isDay') as int;
  @override
  set isDay(int value) => RealmObjectBase.set(this, 'isDay', value);

  @override
  RealmList<HourlyWeather> get hourlyData =>
      RealmObjectBase.get<HourlyWeather>(this, 'hourlyData')
          as RealmList<HourlyWeather>;
  @override
  set hourlyData(covariant RealmList<HourlyWeather> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<DailyWeather> get dailyData =>
      RealmObjectBase.get<DailyWeather>(this, 'dailyData')
          as RealmList<DailyWeather>;
  @override
  set dailyData(covariant RealmList<DailyWeather> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<WeatherDataModel>> get changes =>
      RealmObjectBase.getChanges<WeatherDataModel>(this);

  @override
  Stream<RealmObjectChanges<WeatherDataModel>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<WeatherDataModel>(this, keyPaths);

  @override
  WeatherDataModel freeze() =>
      RealmObjectBase.freezeObject<WeatherDataModel>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'subLocality': subLocality.toEJson(),
      'currentTemperature': currentTemperature.toEJson(),
      'minTemperature': minTemperature.toEJson(),
      'maxTemperature': maxTemperature.toEJson(),
      'sunriseTime': sunriseTime.toEJson(),
      'sunsetTime': sunsetTime.toEJson(),
      'weatherConditionText': weatherConditionText.toEJson(),
      'weatherConditionImagePath': weatherConditionImagePath.toEJson(),
      'precipitation': precipitation.toEJson(),
      'windSpeed': windSpeed.toEJson(),
      'windDirection': windDirection.toEJson(),
      'humidity': humidity.toEJson(),
      'visibility': visibility.toEJson(),
      'uvIndex': uvIndex.toEJson(),
      'surfacePressure': surfacePressure.toEJson(),
      'isCurrent': isCurrent.toEJson(),
      'isDay': isDay.toEJson(),
      'hourlyData': hourlyData.toEJson(),
      'dailyData': dailyData.toEJson(),
    };
  }

  static EJsonValue _toEJson(WeatherDataModel value) => value.toEJson();
  static WeatherDataModel _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'subLocality': EJsonValue subLocality,
        'currentTemperature': EJsonValue currentTemperature,
        'minTemperature': EJsonValue minTemperature,
        'maxTemperature': EJsonValue maxTemperature,
        'sunriseTime': EJsonValue sunriseTime,
        'sunsetTime': EJsonValue sunsetTime,
        'weatherConditionText': EJsonValue weatherConditionText,
        'weatherConditionImagePath': EJsonValue weatherConditionImagePath,
        'precipitation': EJsonValue precipitation,
        'windSpeed': EJsonValue windSpeed,
        'windDirection': EJsonValue windDirection,
        'humidity': EJsonValue humidity,
        'visibility': EJsonValue visibility,
        'uvIndex': EJsonValue uvIndex,
        'surfacePressure': EJsonValue surfacePressure,
        'isCurrent': EJsonValue isCurrent,
        'isDay': EJsonValue isDay,
      } =>
        WeatherDataModel(
          fromEJson(id),
          fromEJson(subLocality),
          fromEJson(currentTemperature),
          fromEJson(minTemperature),
          fromEJson(maxTemperature),
          fromEJson(sunriseTime),
          fromEJson(sunsetTime),
          fromEJson(weatherConditionText),
          fromEJson(weatherConditionImagePath),
          fromEJson(precipitation),
          fromEJson(windSpeed),
          fromEJson(windDirection),
          fromEJson(humidity),
          fromEJson(visibility),
          fromEJson(uvIndex),
          fromEJson(surfacePressure),
          fromEJson(isCurrent),
          fromEJson(isDay),
          hourlyData: fromEJson(ejson['hourlyData']),
          dailyData: fromEJson(ejson['dailyData']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(WeatherDataModel._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, WeatherDataModel, 'WeatherDataModel', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('subLocality', RealmPropertyType.string),
      SchemaProperty('currentTemperature', RealmPropertyType.string),
      SchemaProperty('minTemperature', RealmPropertyType.string),
      SchemaProperty('maxTemperature', RealmPropertyType.string),
      SchemaProperty('sunriseTime', RealmPropertyType.string),
      SchemaProperty('sunsetTime', RealmPropertyType.string),
      SchemaProperty('weatherConditionText', RealmPropertyType.string),
      SchemaProperty('weatherConditionImagePath', RealmPropertyType.string),
      SchemaProperty('precipitation', RealmPropertyType.double),
      SchemaProperty('windSpeed', RealmPropertyType.double),
      SchemaProperty('windDirection', RealmPropertyType.string),
      SchemaProperty('humidity', RealmPropertyType.double),
      SchemaProperty('visibility', RealmPropertyType.double),
      SchemaProperty('uvIndex', RealmPropertyType.double),
      SchemaProperty('surfacePressure', RealmPropertyType.double),
      SchemaProperty('isCurrent', RealmPropertyType.bool),
      SchemaProperty('isDay', RealmPropertyType.int),
      SchemaProperty('hourlyData', RealmPropertyType.object,
          linkTarget: 'HourlyWeather',
          collectionType: RealmCollectionType.list),
      SchemaProperty('dailyData', RealmPropertyType.object,
          linkTarget: 'DailyWeather', collectionType: RealmCollectionType.list),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class HourlyWeather extends $HourlyWeather
    with RealmEntity, RealmObjectBase, RealmObject {
  HourlyWeather(
    String dateTime,
    double tamp,
    int weatherCode,
  ) {
    RealmObjectBase.set(this, 'dateTime', dateTime);
    RealmObjectBase.set(this, 'tamp', tamp);
    RealmObjectBase.set(this, 'weatherCode', weatherCode);
  }

  HourlyWeather._();

  @override
  String get dateTime =>
      RealmObjectBase.get<String>(this, 'dateTime') as String;
  @override
  set dateTime(String value) => RealmObjectBase.set(this, 'dateTime', value);

  @override
  double get tamp => RealmObjectBase.get<double>(this, 'tamp') as double;
  @override
  set tamp(double value) => RealmObjectBase.set(this, 'tamp', value);

  @override
  int get weatherCode => RealmObjectBase.get<int>(this, 'weatherCode') as int;
  @override
  set weatherCode(int value) => RealmObjectBase.set(this, 'weatherCode', value);

  @override
  Stream<RealmObjectChanges<HourlyWeather>> get changes =>
      RealmObjectBase.getChanges<HourlyWeather>(this);

  @override
  Stream<RealmObjectChanges<HourlyWeather>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<HourlyWeather>(this, keyPaths);

  @override
  HourlyWeather freeze() => RealmObjectBase.freezeObject<HourlyWeather>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'dateTime': dateTime.toEJson(),
      'tamp': tamp.toEJson(),
      'weatherCode': weatherCode.toEJson(),
    };
  }

  static EJsonValue _toEJson(HourlyWeather value) => value.toEJson();
  static HourlyWeather _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'dateTime': EJsonValue dateTime,
        'tamp': EJsonValue tamp,
        'weatherCode': EJsonValue weatherCode,
      } =>
        HourlyWeather(
          fromEJson(dateTime),
          fromEJson(tamp),
          fromEJson(weatherCode),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(HourlyWeather._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, HourlyWeather, 'HourlyWeather', [
      SchemaProperty('dateTime', RealmPropertyType.string),
      SchemaProperty('tamp', RealmPropertyType.double),
      SchemaProperty('weatherCode', RealmPropertyType.int),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class DailyWeather extends $DailyWeather
    with RealmEntity, RealmObjectBase, RealmObject {
  DailyWeather(
    String dateTime,
    double minTamp,
    double maxTamp,
    int weatherCode,
  ) {
    RealmObjectBase.set(this, 'dateTime', dateTime);
    RealmObjectBase.set(this, 'minTamp', minTamp);
    RealmObjectBase.set(this, 'maxTamp', maxTamp);
    RealmObjectBase.set(this, 'weatherCode', weatherCode);
  }

  DailyWeather._();

  @override
  String get dateTime =>
      RealmObjectBase.get<String>(this, 'dateTime') as String;
  @override
  set dateTime(String value) => RealmObjectBase.set(this, 'dateTime', value);

  @override
  double get minTamp => RealmObjectBase.get<double>(this, 'minTamp') as double;
  @override
  set minTamp(double value) => RealmObjectBase.set(this, 'minTamp', value);

  @override
  double get maxTamp => RealmObjectBase.get<double>(this, 'maxTamp') as double;
  @override
  set maxTamp(double value) => RealmObjectBase.set(this, 'maxTamp', value);

  @override
  int get weatherCode => RealmObjectBase.get<int>(this, 'weatherCode') as int;
  @override
  set weatherCode(int value) => RealmObjectBase.set(this, 'weatherCode', value);

  @override
  Stream<RealmObjectChanges<DailyWeather>> get changes =>
      RealmObjectBase.getChanges<DailyWeather>(this);

  @override
  Stream<RealmObjectChanges<DailyWeather>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<DailyWeather>(this, keyPaths);

  @override
  DailyWeather freeze() => RealmObjectBase.freezeObject<DailyWeather>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'dateTime': dateTime.toEJson(),
      'minTamp': minTamp.toEJson(),
      'maxTamp': maxTamp.toEJson(),
      'weatherCode': weatherCode.toEJson(),
    };
  }

  static EJsonValue _toEJson(DailyWeather value) => value.toEJson();
  static DailyWeather _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'dateTime': EJsonValue dateTime,
        'minTamp': EJsonValue minTamp,
        'maxTamp': EJsonValue maxTamp,
        'weatherCode': EJsonValue weatherCode,
      } =>
        DailyWeather(
          fromEJson(dateTime),
          fromEJson(minTamp),
          fromEJson(maxTamp),
          fromEJson(weatherCode),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(DailyWeather._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, DailyWeather, 'DailyWeather', [
      SchemaProperty('dateTime', RealmPropertyType.string),
      SchemaProperty('minTamp', RealmPropertyType.double),
      SchemaProperty('maxTamp', RealmPropertyType.double),
      SchemaProperty('weatherCode', RealmPropertyType.int),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
