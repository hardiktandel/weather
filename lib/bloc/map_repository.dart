import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

import '../api/map_api_client.dart';
import '../utils/dio_util.dart' as dio;

class MapRepository {
  final Dio _dio = dio.instance;

  Future<Uint8List?> getMapTile(String layer, int x, int y, int zoom) {
    MapApiClient mapApiClient = MapApiClient(_dio);
    return mapApiClient
        .getMapTile(layer, zoom, x, y)
        .catchError((error) => null)
        .whenComplete(() {})
        .then((value) {
      if (value is List<int>) {
        return Uint8List.fromList(value);
      }
      return null;
    });
  }
}
