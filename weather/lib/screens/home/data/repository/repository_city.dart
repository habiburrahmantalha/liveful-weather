import 'package:dio/dio.dart';
import 'package:weather/screens/home/data/model/response_city_list.dart';
import 'package:weather/service/dio_city.dart';
import 'package:weather/service/endpoint.dart';

class RepositoryCity {
  Future<ResponseCityList?> getCityList(String city, {CancelToken? cancelToken}) async {
    Response response = await getHttp(Endpoint.getCIty(city), cancelToken: cancelToken);
    return ResponseCityList.fromJson(response.data);
  }
}