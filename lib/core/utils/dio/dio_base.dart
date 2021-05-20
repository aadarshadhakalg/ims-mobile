import 'package:dio/dio.dart';

class DioSingleton {
  DioSingleton._internal(); //private constructor
  Dio _dio = Dio(
  );
  static final DioSingleton _instance = DioSingleton._internal();

  factory DioSingleton() {
    return _instance;
  }

  void init({String url}) {
    _dio.options.baseUrl = url;
    _dio.options.connectTimeout = 5000;
    _dio.options.receiveTimeout = 3000;
  }

  Dio get instance => this._dio;
}
