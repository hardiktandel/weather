import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../bloc/map/map_cubit.dart';
import '../../bloc/map_repository.dart';
import '../../constants/strings.dart';
import '../../utils/map_tile.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<MapCubit, MapState>(
        builder: (context, state) {
          bool isTempSelected = state is Temperature;
          return Scaffold(
            appBar: AppBar(
              title: Text(
                  isTempSelected ? Strings.temperature : Strings.precipitation),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (isTempSelected) {
                  context
                      .read<MapCubit>()
                      .changeLayer(Strings.precipitationLayerType);
                } else {
                  context
                      .read<MapCubit>()
                      .changeLayer(Strings.temperatureLayerType);
                }
              },
              isExtended: true,
              child: Icon(
                isTempSelected
                    ? Icons.cloud_outlined
                    : Icons.local_fire_department_outlined,
              ),
            ),
            body: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(0.0, 0.0),
              ),
              zoomControlsEnabled: false,
              myLocationButtonEnabled: false,
              tileOverlays: {
                if (isTempSelected)
                  TileOverlay(
                    tileOverlayId: const TileOverlayId('temp_new_id'),
                    tileProvider: MapTile(
                      mapRepository: context.read<MapRepository>(),
                      layer: Strings.temperatureLayerType,
                    ),
                  )
                else
                  TileOverlay(
                    tileOverlayId: const TileOverlayId('precipitation_new_id'),
                    tileProvider: MapTile(
                      mapRepository: context.read<MapRepository>(),
                      layer: Strings.precipitationLayerType,
                    ),
                  )
              },
            ),
          );
        },
      );
}
