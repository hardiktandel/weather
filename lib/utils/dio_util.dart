import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import '../service/logging_interceptor.dart';

Dio get instance {
  Dio dio = Dio()..interceptors.add(const LoggingInterceptor());
  if (dio.httpClientAdapter case IOHttpClientAdapter adapter) {
    adapter.createHttpClient = () => HttpClient()
      ..idleTimeout = const Duration(seconds: 3)
      ..badCertificateCallback = (cert, host, port) => true;
  }
  return dio;
}
