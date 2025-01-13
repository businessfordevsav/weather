import 'package:injectable/injectable.dart';
import 'package:realm/realm.dart';
import 'package:weather/core/local/local_storage.dart';
import 'package:weather/features/data/models/location_model.dart';
import 'package:weather/features/data/models/weather_data_model.dart';

@Singleton(as: ILocalStorage)
class RealmStorage implements ILocalStorage {
  late final Realm _realm;

  RealmStorage() {
    _realm = Realm(
      Configuration.local(
        [
          WeatherDataModel.schema,
          HourlyWeather.schema,
          LocationModel.schema,
          DailyWeather.schema,
        ],
        schemaVersion: 1,
      ),
    );
  }

  @override
  Iterable<M> getAll<M extends RealmObject>() {
    return _realm.all<M>();
  }

  @override
  Future<M> add<M extends RealmObject>(M item) {
    return _realm.writeAsync(() => _realm.add(item));
  }

  @override
  Future<void> addList<M extends RealmObject>(Iterable<M> items) async {
    await _realm.writeAsync(() => _realm.addAll<M>(items));
  }

  @override
  Future<M> update<M extends RealmObject>(M item) {
    return _realm.writeAsync(() => _realm.add(item, update: true));
  }

  @override
  Future<void> delete<M extends RealmObject>(M item) async {
    await _realm.writeAsync(() => _realm.delete(item));
  }

  @override
  M? find<M extends RealmObject>(String primaryKey) {
    return _realm.find<M>(primaryKey);
  }

  @override
  void dispose() {
    _realm.close();
  }
}
