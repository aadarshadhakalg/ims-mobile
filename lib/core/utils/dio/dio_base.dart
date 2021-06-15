import 'package:dio/dio.dart';
import '../../values/api_constants.dart';

class DioSingleton {
  DioSingleton._internal() {
    _dio.options.baseUrl = ApiConstants.SERVER_URL;
    _dio.options.connectTimeout = 10000;
    _dio.options.receiveTimeout = 3000;
  }
  Dio _dio = Dio();
  static final DioSingleton _instance = DioSingleton._internal();

  factory DioSingleton() {
    return _instance;
  }
  Dio get instance => this._dio;
}
