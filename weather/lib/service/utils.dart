import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

void printDebug(Object? object) {
  if(kDebugMode){
    print(object);
  }
}

// Helper method to handle different types of Dio exceptions
String handleDioError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return "Timeout occurred while sending or receiving";
    case DioExceptionType.cancel:
      break;
    case DioExceptionType.unknown:
      return "No Internet Connection";
    case DioExceptionType.badCertificate:
      return "Internal Server Error";
    case DioExceptionType.connectionError:
      return "Connection Error";
    default:
      return "Unknown Error";
  }
  return "Unknown Error";
}

extension StringExtension on String {
  String capitalize(){
    if(isEmpty) return  "";
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}