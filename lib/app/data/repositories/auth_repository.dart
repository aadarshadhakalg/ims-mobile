import 'package:get_storage/get_storage.dart';
import 'package:inventory_management_system/app/data/models/loginModel.dart';
import 'package:inventory_management_system/core/utils/dio/dio_base.dart';
import 'package:inventory_management_system/core/utils/dio/interceptor.dart';
import 'package:inventory_management_system/core/values/api_constants.dart';
import 'package:inventory_management_system/core/values/storage_keys.dart';
import 'package:dio/dio.dart' as dio;

class AuthRepository {
  AuthRepository._internal();
  static final _instance = AuthRepository._internal();
  factory AuthRepository.instance() => _instance;
  final DioSingleton _dio = DioSingleton();
  final GetStorage storageBox = GetStorage();

  Future<bool> login(LoginModel loginModel) async {
    try {
      dio.Response response = await _dio.instance.post(ApiConstants.LOGIN,
          data: dio.FormData.fromMap(loginModel.toJSON()));

      if (response.statusCode == 200 || response.statusCode == 201) {
        storageBox.write(StorageConstants.ACCESS_KEYS, response.data['access']);
        storageBox.write(
            StorageConstants.REFRESH_KEYS, response.data['refresh']);
        _dio.instance.interceptors.add(
          DioInterceptor(),
        );
        storageBox.write(StorageConstants.IS_LOGGED_IN, true);
        return true;
      } else {
        throw Exception('${response.statusCode}');
      }
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<void> logout() async {
    try {
      dio.Response response = await _dio.instance.post(ApiConstants.LOGOUT);
      if (response.statusCode == 200) {
        storageBox.erase();
      } else {
        throw Exception('Error!');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
