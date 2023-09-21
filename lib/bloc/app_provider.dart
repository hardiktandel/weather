import 'package:flutter_bloc/flutter_bloc.dart';

import 'forecast/forecast_cubit.dart';
import 'map_repository.dart';

final appProviders = [
  BlocProvider<ForecastCubit>(
    create: (_) => ForecastCubit(),
  ),
  RepositoryProvider<MapRepository>(
    create: (_) => MapRepository(),
  ),
];
