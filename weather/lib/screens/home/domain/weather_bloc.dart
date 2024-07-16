import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
         if(true){
           emit(state.copyWith(statusWeather: LoadingStatus.loading));
           try{
             ResponseWeather? response = await repository.getWeather(appId, event.cityName);
             emit(state.copyWith(
                 statusWeather: LoadingStatus.success,
                 weather: response,
                 currentTime: DateTime.now().millisecond));
           }catch(error){
             printDebug("GetOrderDetails - $error");
             emit(state.copyWith(statusWeather: LoadingStatus.failed, errorText: "", currentTime: DateTime.now().millisecond));
           }
         }
        case FetchForecast():
          if(true){
            emit(state.copyWith(statusForecast: LoadingStatus.loading));
            try{
              ResponseForecast? response = await repository.getForecast(appId, event.cityName);

              emit(state.copyWith(
                  statusForecast: LoadingStatus.success,
                  forecast: response?.list ?? [],
                  currentTime: DateTime.now().millisecond));
            }catch(error){
              printDebug("GetOrderDetails - $error");
              emit(state.copyWith(statusForecast: LoadingStatus.failed, errorText: "", currentTime: DateTime.now().millisecond));
            }
          }
      }
    });
  }
}
