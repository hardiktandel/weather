import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../constants/app_url.dart';

part 'weather_api_client.g.dart';

@RestApi(baseUrl: AppUrl.baseUrl)
abstract class WeatherApiClient {
  factory WeatherApiClient(Dio dio, {String baseUrl}) = _WeatherApiClient;

  @GET('/weather')
  Future<String?> getWeather(
      @Query('lat') double latitude, @Query('lon') double longitude);

  @GET('/forecast')
  Future<String?> getForecast(
      @Query('lat') double latitude, @Query('lon') double longitude);
}
