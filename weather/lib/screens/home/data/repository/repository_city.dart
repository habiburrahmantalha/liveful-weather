import 'package:dio/dio.dart';
import 'package:weather/screens/home/data/model/response_city_list.dart';
import 'package:weather/service/dio_city.dart';
import 'package:weather/service/endpoint.dart';

class RepositoryCity {
  /// Fetches a list of cities matching the search query.
  ///
  /// Takes the [city] as a search query and an optional [cancelToken] for
  /// cancelling the request if needed.
  ///
  /// Returns a [ResponseCityList] object containing the list of matching cities.
  Future<ResponseCityList?> getCityList(String city, {CancelToken? cancelToken}) async {
    // Make an HTTP GET request to the specified endpoint to fetch city data
    Response response = await getHttp(Endpoint.getCity(city), cancelToken: cancelToken);

    // Parse the JSON response into a ResponseCityList object and return it
    return ResponseCityList.fromJson(response.data);
  }
}
