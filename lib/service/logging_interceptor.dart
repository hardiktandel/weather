import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../constants/app_url.dart';
import '../utils/snack_bar.dart';
import 'connectivity.dart' as connectivity;

class LoggingInterceptor extends Interceptor {
  static const JsonDecoder _decoder = JsonDecoder();
  static const JsonEncoder _encoder = JsonEncoder.withIndent('  ');

  const LoggingInterceptor();

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (!await connectivity.isConnected) {
      showSnackBar('No Internet');
      return;
    }
    options.queryParameters['appid'] = AppUrl.apiKey;
    if (kDebugMode) _showRequestLog(options);
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.data is! List<int>) {
      if (kDebugMode) _showResponseLog(response);
    }
    return super.onResponse(response, handler);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    if (kDebugMode) _showErrorLog(err);
    try {
      if (err.response?.data != null) {
        Map<String, dynamic> res = _decoder.convert(err.response?.data);
        if (res['message'] case String message) {
          showSnackBar(message);
        }
      }
    } catch (_) {}
    return super.onError(err, handler);
  }

  void _showRequestLog(RequestOptions options) {
    String requestLog =
        '\n--> ${options.method.toUpperCase()} ${'${options.baseUrl}${options.path}'}';
    requestLog = '$requestLog\nHeaders: ${_encoder.convert(options.headers)}';
    if (options.queryParameters.isNotEmpty) {
      requestLog =
          '$requestLog\nQueryParameters: ${_encoder.convert(options.queryParameters)}';
    }
    if (options.data != null) {
      requestLog = '$requestLog\nBody: ${_encoder.convert(options.data)}';
    }
    requestLog = '$requestLog\n--> END ${options.method.toUpperCase()}';
    log(requestLog, level: 900);
  }

  void _showResponseLog(Response response) {
    String responseLog =
        '\n<-- ${response.statusCode} ${response.requestOptions.baseUrl + response.requestOptions.path}';
    responseLog =
        '$responseLog\nHeaders: ${_encoder.convert(response.headers.map)}';
    String? prettyString;
    try {
      var object = _decoder.convert(response.data);
      prettyString = _encoder.convert(object);
    } catch (_) {
      prettyString = '${response.data}';
    }
    responseLog = '$responseLog\nResponse: $prettyString';
    responseLog = '$responseLog\n<-- END HTTP';
    log(responseLog);
  }

  void _showErrorLog(DioException err) {
    String errorLog =
        '\n<-- ${err.message} ${err.requestOptions.baseUrl}${err.requestOptions.path}';
    if (err.response != null) {
      String? prettyString;
      try {
        var object = _decoder.convert(err.response!.data);
        prettyString = _encoder.convert(object);
      } catch (_) {
        prettyString = '${err.response!.data}';
      }
      errorLog = '$errorLog\n$prettyString';
    } else {
      errorLog = '$errorLog\n$err';
    }
    errorLog = '$errorLog\n<-- End error';
    log(errorLog);
  }
}
