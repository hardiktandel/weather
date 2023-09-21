import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../constants/app_url.dart';

part 'map_api_client.g.dart';

@RestApi(baseUrl: AppUrl.mapUrl)
abstract class MapApiClient {
  factory MapApiClient(Dio dio, {String baseUrl}) = _MapApiClient;

  @GET('/{layer}/{zoom}/{x}/{y}.png')
  @DioResponseType(ResponseType.bytes)
  Future<List<int>?> getMapTile(@Path('layer') String layer,
      @Path('zoom') int zoom, @Path('x') int x, @Path('y') int y);
}
