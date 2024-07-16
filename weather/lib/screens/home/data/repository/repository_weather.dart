import 'package:dio/dio.dart';
import 'package:weather/screens/home/data/model/response_forecast.dart';
import 'package:weather/screens/home/data/model/response_weather.dart';
import 'package:weather/service/dio_weather.dart';
import 'package:weather/service/endpoint.dart';

class RepositoryWeather {
  Future<ResponseWeather?> getWeather(String appId, String city) async {
    Response response = await getHttp(Endpoint.getCurrentWeather(appId, city));
    return ResponseWeather.fromJson(response.data);
  }

  Future<ResponseForecast?> getForecast(String appId,  String city) async {
    Response response = await getHttp(Endpoint.getForecastWeather(appId, city));
    return ResponseForecast.fromJson(response.data);
  }
}