import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/screens/home/data/model/response_city_list.dart';
import 'package:weather/screens/home/data/repository/repository_city.dart';
import 'city_state.dart';

class CityCubit extends Cubit<CityState> {
  final RepositoryCity repository;

  CancelToken cancelToken = CancelToken();
  CityCubit({required this.repository}) : super(CityInitial());

  void fetchCitySuggestions(String query) async {
    if(cancelToken.isCancelled == false){
      cancelToken.cancel();
    }
    cancelToken = CancelToken();

    if (query.isEmpty) {
      emit(CityInitial());
      return;
    }

    emit(CityLoading());

    try {
      ResponseCityList? response = await repository.getCityList(query, cancelToken: cancelToken);
      emit(CityLoaded(cities: response?.data ?? []));
    } catch (e) {
      emit(CityError(message: 'Failed to fetch cities'));
    }
  }
}
