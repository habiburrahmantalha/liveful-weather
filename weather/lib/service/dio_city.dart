import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioCity {
  static final DioCity _singleton = DioCity._internal();

  DioCity._internal();

  static DioCity get instance => _singleton;
  late Dio dio;
  final String baseUrl = "https://wft-geo-db.p.rapidapi.com/v1/";

  void create(String apiKey) {
    BaseOptions options = BaseOptions(
      headers: {
        "x-rapidapi-host" : "wft-geo-db.p.rapidapi.com",
        "x-rapidapi-key" : apiKey,
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


Future getHttp(String path, {CancelToken? cancelToken}) async => DioCity.instance.dio.get(path, cancelToken: cancelToken);



