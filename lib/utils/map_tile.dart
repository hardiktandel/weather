import 'dart:typed_data';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../bloc/map_repository.dart';

class MapTile implements TileProvider {
  static const int _tileSize = 256;
  final MapRepository mapRepository;
  final String layer;

  const MapTile({required this.mapRepository, required this.layer});

  @override
  Future<Tile> getTile(int x, int y, int? zoom) async {
    zoom = zoom ?? 1;
    if (zoom >= 1 && zoom <= 20) {
      try {
        Uint8List? image = await mapRepository.getMapTile(layer, x, y, zoom);
        if (image != null) {
          Tile actualTile = Tile(_tileSize, _tileSize, image);
          return actualTile;
        }
      } catch (_) {}
    }
    return TileProvider.noTile;
  }
}
