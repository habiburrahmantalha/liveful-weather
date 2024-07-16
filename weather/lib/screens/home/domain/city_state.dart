import 'package:equatable/equatable.dart';
import 'package:weather/screens/home/data/model/response_city_list.dart';

abstract class CityState extends Equatable {
  @override
  List<Object> get props => [];
}

class CityInitial extends CityState {}

class CityLoading extends CityState {}

class CityLoaded extends CityState {
  final List<CityData> cities;

  CityLoaded({required this.cities});

  @override
  List<Object> get props => [cities];
}

class CityError extends CityState {
  final String message;

  CityError({required this.message});

  @override
  List<Object> get props => [message];
}
