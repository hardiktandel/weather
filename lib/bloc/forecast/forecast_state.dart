part of 'forecast_cubit.dart';

abstract class ForecastState {}

class ForecastLoading extends ForecastState {}

class ForecastNotLoaded extends ForecastState {}

class ForecastLoaded extends ForecastState {
  final int count;
  final List<Forecast> forecasts;
  final Map<DateTime, List<Forecast>> groupedForecasts;
  final City? city;

  ForecastLoaded({
    required this.count,
    required this.groupedForecasts,
    required this.forecasts,
    this.city,
  });
}
