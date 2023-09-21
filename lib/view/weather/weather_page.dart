import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/forecast/forecast_cubit.dart';
import '../../bloc/map/map_cubit.dart';
import '../../constants/strings.dart';
import '../../service/location.dart';
import '../../utils/gaps.dart';
import '../../utils/navigator_extension.dart';
import '../../utils/snack_bar.dart';
import '../map/map_page.dart';
import 'component/day_tile.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late final DateTime _today;

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    _today = DateTime(now.year, now.month, now.day);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getWeather();
    });
  }

  Future<void> _getWeather() async {
    unawaited(getCurrentPosition().then((position) {
      context
          .read<ForecastCubit>()
          .getForecast(position.latitude, position.longitude);
    }).catchError((error) {
      showSnackBar('$error');
      context.read<ForecastCubit>().emitNotLoaded();
    }));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(Strings.appName),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.push(
              BlocProvider<MapCubit>(
                create: (context) => MapCubit(),
                child: const MapPage(),
              ),
            );
          },
          child: const Icon(
            Icons.map_outlined,
          ),
        ),
        body: BlocBuilder<ForecastCubit, ForecastState>(
          builder: (context, state) {
            if (state is ForecastLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state
                case ForecastLoaded(:final groupedForecasts, :final city)) {
              List<DateTime> keys = groupedForecasts.keys.toList();
              return RefreshIndicator(
                onRefresh: _getWeather,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(
                      bottom: kFloatingActionButtonMargin + 92.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (city != null)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${city.name}, ${city.country}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: keys.length,
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, index) => DayTile(
                          today: _today,
                          date: keys[index],
                          forecasts: groupedForecasts[keys[index]],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return gap;
          },
        ),
      );
}
