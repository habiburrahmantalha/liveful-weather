import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/screens/home/data/model/response_forecast.dart';
import 'package:weather/screens/home/data/model/response_weather.dart';
import 'package:weather/screens/home/data/repository/repository_weather.dart';
import 'package:weather/service/utils.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {

  final RepositoryWeather repository;
  final String appId;
  WeatherBloc({required this.appId, required this.repository}) : super(const WeatherState()) {
    on<WeatherEvent>((event, emit) async {
      switch(event){
        case FetchWeather():
        // Emits loading state and fetches current weather
         if(true){
           emit(state.copyWith(statusWeather: LoadingStatus.loading));
           try{
             ResponseWeather? response = await repository.getWeather(appId, event.cityName);
             emit(state.copyWith(
                 statusWeather: LoadingStatus.success,
                 weather: response,
                 currentTime: DateTime.now().millisecond));
           }
           // Handles error during forecast fetch
           on DioException catch(exception){
             printDebug("FetchWeather ${exception.response?.data}");
             emit(state.copyWith(
                 statusWeather: LoadingStatus.failed,
                 errorText: exception.response?.data["message"] ?? handleDioError(exception),
                 currentTime: DateTime.now().millisecond));
           }
           catch(error){
             printDebug("FetchWeather - $error");
             emit(state.copyWith(
                 statusWeather: LoadingStatus.failed,
                 errorText: "Something went wrong! Please try again", currentTime: DateTime.now().millisecond));
           }
         }
        case FetchForecast():
        // Emits loading state and fetches weather forecast
          if(true){
            emit(state.copyWith(statusForecast: LoadingStatus.loading));
            try{
              ResponseForecast? response = await repository.getForecast(appId, event.cityName);

              emit(state.copyWith(
                  statusForecast: LoadingStatus.success,
                  forecast: response?.list ?? [],
                  currentTime: DateTime.now().millisecond));
            }
            // Handles error during forecast fetch
            on DioException catch(exception){
              printDebug("FetchWeather ${exception.response?.data}");
              emit(state.copyWith(
                  statusForecast: LoadingStatus.failed,
                  errorText: exception.response?.data["message"] ?? handleDioError(exception),
                  currentTime: DateTime.now().millisecond));
            }
            catch(error){
              printDebug("FetchForecast - $error");
              emit(state.copyWith(
                  statusForecast: LoadingStatus.failed,
                  errorText: "Something went wrong! Please try again",
                  currentTime: DateTime.now().millisecond));
            }
          }
      }
    });
  }
}
