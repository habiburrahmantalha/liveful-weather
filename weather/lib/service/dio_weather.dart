import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioWeather {
  static final DioWeather _singleton = DioWeather._internal();

  DioWeather._internal();

  static DioWeather get instance => _singleton;
  late Dio dio;
  final String baseUrl = "https://api.openweathermap.org/data/2.5/";

  void create() {
    BaseOptions options = BaseOptions(
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    );
    dio = Dio(options);
    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ));
    }
  }
}


Future getHttp(String path, {CancelToken? cancelToken}) async => DioWeather.instance.dio.get(path, cancelToken: cancelToken);



