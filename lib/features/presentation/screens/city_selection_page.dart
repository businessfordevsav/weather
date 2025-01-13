import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:weather/core/utils/logger.dart';
import 'package:weather/features/data/models/location_model.dart';
import 'package:weather/features/data/models/weather_data_model.dart';
import 'package:weather/features/presentation/blocs/location/location_bloc.dart';

class CitySelectionPage extends StatefulWidget {
  const CitySelectionPage({super.key});

  @override
  State<CitySelectionPage> createState() => _CitySelectionPageState();
}

class _CitySelectionPageState extends State<CitySelectionPage> {
  @override
  void initState() {
    BlocProvider.of<LocationBloc>(context).add(GetSavedLocationData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<WeatherDataModel> savedLocationWeatherDataList = [];
    return BlocListener<LocationBloc, LocationState>(
      listener: (context, state) {
        if (state is LocationSavadDataSuccess) {
          savedLocationWeatherDataList =
              state.savedLocationWeatherDataList.reversed.toList();
          int index =
              savedLocationWeatherDataList.indexWhere((item) => item.isCurrent);

          if (index != -1) {
            // Remove the person from the list
            WeatherDataModel person =
                savedLocationWeatherDataList.removeAt(index);
            // Insert the person at the first position
            savedLocationWeatherDataList.insert(0, person);
          } else {
            print('Person not found');
          }
        } else if (state is LocationFail) {
          logger.info('state : ${state.error}');
        }
      },
      child:
          BlocBuilder<LocationBloc, LocationState>(builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            title: Text(
              "Select Location",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            leading: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: IconButton(
                onPressed: () => context.pop(),
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  size: 21,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
            actions: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: () {
                      searchBottomSheet(savedLocationWeatherDataList,
                          (txt) async {
                        BlocProvider.of<LocationBloc>(context)
                            .add(SearchPlaceFromAddressEvent(txt));
                      });
                    },
                  ),
                ),
              )
            ],
          ),
          body: SafeArea(
            child: Container(
              color: Theme.of(context).colorScheme.surface,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: savedLocationWeatherDataList.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          final weather = savedLocationWeatherDataList[index];
                          return Dismissible(
                            key: Key(savedLocationWeatherDataList[index].id),
                            direction: weather.isCurrent
                                ? DismissDirection.none
                                : DismissDirection.endToStart,
                            background: slideLeftBackground(),
                            confirmDismiss: (direction) async {
                              if (weather.isCurrent) {
                                return false;
                              } else {
                                return await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          'Weather',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        ),
                                        content: Text(
                                          'Are you sure you want to delete ${weather.subLocality}?',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall,
                                        ),
                                        actions: <Widget>[
                                          ElevatedButton(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                "Cancel",
                                                style: Theme.of(context)
                                                    .inputDecorationTheme
                                                    .labelStyle,
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop(false);
                                            },
                                          ),
                                          ElevatedButton(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                "Delete",
                                                style: Theme.of(context)
                                                    .inputDecorationTheme
                                                    .labelStyle
                                                    ?.copyWith(
                                                        color: Colors.red),
                                              ),
                                            ),
                                            onPressed: () {
                                              BlocProvider.of<LocationBloc>(
                                                      context)
                                                  .add(DeleteSavedLocationData(
                                                      weather.id));
                                              Navigator.of(context).pop(true);
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              }
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '${weather.subLocality}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Visibility(
                                              visible: weather.isCurrent,
                                              child: Center(
                                                child: Text(
                                                  '(current)',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '${weather.currentTemperature}°C',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge,
                                        ),
                                        Text(
                                          '${weather.weatherConditionText}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Center(
                                    child: Image.asset(
                                      weather.weatherConditionImagePath,
                                      width: 40,
                                      height: 40,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  void searchBottomSheet(List<WeatherDataModel> savedLocationWeatherDataList,
      ValueChanged<String> onChanged) {
    List<LocationModel> locationList = [];

    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return BlocBuilder<LocationBloc, LocationState>(
            builder: (context, state) {
          if (state is LocationSuccess) {
            logger.info("state : ${state.locationModel}");
            locationList.clear();
            locationList = state.locationModel
                .where(
                    (item) => item.id.isNotEmpty && item.subLocality.isNotEmpty)
                .toList();
          }
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  color: Theme.of(context).colorScheme.surface,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withAlpha(110),
                            ),
                            width: 190,
                            height: 4,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SearchBar(
                          backgroundColor: WidgetStateProperty.all(
                              Theme.of(context).colorScheme.surface),
                          leading: Icon(
                            Icons.search,
                            size: 21,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              side: BorderSide(
                                color: Theme.of(context).colorScheme.secondary,
                                width: 0.5,
                              ),
                            ),
                          ),
                          elevation: WidgetStateProperty.all(0.2),
                          hintStyle: WidgetStateProperty.all(
                            Theme.of(context).inputDecorationTheme.hintStyle,
                          ),
                          hintText: 'Enter location',
                          textStyle: WidgetStateProperty.all(
                            Theme.of(context).inputDecorationTheme.labelStyle,
                          ),
                          textInputAction: TextInputAction.search,
                          onChanged: onChanged,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        if (state is LocationLoading) ...[
                          // Loading state
                          Center(child: CircularProgressIndicator()),
                        ] else if (state is LocationSuccess) ...[
                          // Success state - Show list of locations
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: locationList.length,
                              itemBuilder: (BuildContext context, int index) {
                                final location = locationList[index];
                                return Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              '${location.subLocality}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              if (savedLocationWeatherDataList
                                                  .any((item) =>
                                                      item.id ==
                                                      location.id
                                                          .toLowerCase())) {
                                                return;
                                              }
                                              BlocProvider.of<LocationBloc>(
                                                      context)
                                                  .add(AddLocation(location));
                                              Navigator.pop(context);
                                            },
                                            icon: Icon(
                                              savedLocationWeatherDataList.any(
                                                      (item) =>
                                                          item.id ==
                                                          location.id
                                                              .toLowerCase())
                                                  ? Icons.check
                                                  : Icons.add,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        '${location.state}, ${location.country}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ] else if (state is LocationFail) ...[
                          // Failure state - Show error message
                          Center(
                            child: Text(
                              'Failed to load locations',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ],
                      ],
                    ),
                  )),
            ),
          );
        });
      },
    );
  }

  Widget slideLeftBackground() {
    return Container(
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }
}
