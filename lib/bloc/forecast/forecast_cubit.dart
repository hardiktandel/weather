import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/weather_api_client.dart';
import '../../model/city.dart';
import '../../model/forecast.dart';
import '../../utils/dio_util.dart' as dio;

part 'forecast_state.dart';

class ForecastCubit extends Cubit<ForecastState> {
  ForecastCubit() : super(ForecastLoading());
  final Dio _dio = dio.instance;

  void emitNotLoaded(){
    emit(ForecastNotLoaded());
  }

  Future<void> getForecast(double latitude, double longitude) async {
    emit(ForecastLoading());
    WeatherApiClient weatherApiClient = WeatherApiClient(_dio);
    await weatherApiClient
        .getForecast(latitude, longitude)
        .catchError((error) => null)
        .whenComplete(() {})
        .then((value) {
      if (value != null) {
        Map<String, dynamic> res = jsonDecode(value);
        int count = res['cnt'] ?? 0;
        List<Forecast> forecasts = res['list'] == null
            ? []
            : List.from(res['list'].map((x) => Forecast.fromJson(x)));
        Map<DateTime, List<Forecast>> groupedForecasts =
            groupBy(forecasts, (forecast) => forecast.date!);
        City? city = res['city'] == null ? null : City.fromJson(res['city']);
        emit(ForecastLoaded(
          count: count,
          groupedForecasts: groupedForecasts,
          forecasts: forecasts,
          city: city,
        ));
      } else {
        emit(ForecastNotLoaded());
      }
    });
  }
}
