import 'package:equatable/equatable.dart';
import 'package:weather/screens/home/data/model/response_city_list.dart';

/// Abstract class representing the different states of the CityCubit.
abstract class CityState extends Equatable {
  @override
  List<Object> get props => [];
}

/// Initial state of the CityCubit when no action has been taken yet.
class CityInitial extends CityState {}

/// State of the CityCubit when a city suggestion fetch request is in progress.
class CityLoading extends CityState {}

/// State of the CityCubit when city suggestions have been successfully fetched.
class CityLoaded extends CityState {
  final List<CityData> cities;

  /// Constructor to initialize the list of cities.
  CityLoaded({required this.cities});

  @override
  List<Object> get props => [cities];
}

/// State of the CityCubit when an error occurs during the fetch request.
class CityError extends CityState {
  final String message;

  /// Constructor to initialize the error message.
  CityError({required this.message});

  @override
  List<Object> get props => [message];
}
