import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/screens/home/data/model/response_city_list.dart';
import 'package:weather/screens/home/data/repository/repository_city.dart';
import 'city_state.dart';

class CityCubit extends Cubit<CityState> {
  final RepositoryCity repository;

  // A token to cancel the ongoing request if needed
  CancelToken cancelToken = CancelToken();

  CityCubit({required this.repository}) : super(CityInitial());

  /// Fetches city suggestions based on the query.
  ///
  /// Cancels any ongoing request and starts a new one with the given [query].
  void fetchCitySuggestions(String query) async {
    // Cancel any ongoing request
    if (cancelToken.isCancelled == false) {
      cancelToken.cancel();
    }
    cancelToken = CancelToken();

    // If the query is empty, emit the initial state and return
    if (query.isEmpty) {
      emit(CityInitial());
      return;
    }

    // Emit loading state
    emit(CityLoading());

    try {
      // Fetch city list from the repository
      ResponseCityList? response = await repository.getCityList(query, cancelToken: cancelToken);
      // Emit loaded state with the fetched cities
      emit(CityLoaded(cities: response?.data ?? []));
    } catch (e) {
      // Emit error state if an exception occurs
      emit(CityError(message: 'Failed to fetch cities'));
    }
  }
}
