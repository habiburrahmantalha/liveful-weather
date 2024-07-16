import 'package:dio/dio.dart';
import 'package:weather/screens/home/data/model/response_forecast.dart';
import 'package:weather/screens/home/data/model/response_weather.dart';
import 'package:weather/service/dio_weather.dart';
import 'package:weather/service/endpoint.dart';

class RepositoryWeather {
  /// Fetches the current weather data for a specified city.
  ///
  /// Takes the [appId] for authentication and the [city] name for which the weather data is requested.
  /// Returns a [ResponseWeather] object containing the current weather data.
  Future<ResponseWeather?> getWeather(String appId, String city) async {
    // Make an HTTP GET request to the current weather endpoint
    Response response = await getHttp(Endpoint.getCurrentWeather(appId, city));

    // Parse the JSON response into a ResponseWeather object and return it
    return ResponseWeather.fromJson(response.data);
  }

  /// Fetches the weather forecast data for a specified city.
  ///
  /// Takes the [appId] for authentication and the [city] name for which the forecast data is requested.
  /// Returns a [ResponseForecast] object containing the weather forecast data.
  Future<ResponseForecast?> getForecast(String appId, String city) async {
    // Make an HTTP GET request to the forecast weather endpoint
    Response response = await getHttp(Endpoint.getForecastWeather(appId, city));

    // Parse the JSON response into a ResponseForecast object and return it
    return ResponseForecast.fromJson(response.data);
  }
}
