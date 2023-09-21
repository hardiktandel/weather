import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/strings.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(Precipitation());

  void changeLayer(String mapType) {
    if (mapType == Strings.temperatureLayerType) {
      emit(Temperature());
    } else {
      emit(Precipitation());
    }
  }
}
