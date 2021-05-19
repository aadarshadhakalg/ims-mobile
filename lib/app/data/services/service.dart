import 'package:inventory_management_system/core/values/api_constants.dart';
import 'package:inventory_management_system/core/themes/app_theme.dart';
import 'package:inventory_management_system/core/utils/dio/dio_base.dart';
import 'package:inventory_management_system/core/utils/dio/interceptor.dart';
import 'package:inventory_management_system/core/values/storage_keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get_storage/get_storage.dart';

class AppConfigService extends GetxService {

  Rx<bool> isLoggedIn = false.obs;
  // oh me and will remove it.

  GetStorage box;
  DioSingleton _dio = DioSingleton();

  Future<AppConfigService> init() async{
    box = GetStorage();
    _dio.init(url: ApiConstants.SERVER_URL);

    // during refactoring i intend to remove this.
    // both access keys and refresh keys are already expired.
    await box.writeIfNull(StorageConstants.THEME,true);
    await box.writeIfNull(StorageConstants.ACCESS_KEYS, 'eyJ.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTYyMTA4MDEwMiwianRpIjoiMjVmNzBkMzRkNjJhNGVlNWE5NWM2MjRlZTM4MTA4NDMiLCJ1c2VyX2lkIjoxfQ.asd');
    await box.writeIfNull(StorageConstants.REFRESH_KEYS, 'ey.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTYyMTA4MDEwMiwianRpIjoiMjVmNzBkMzRkNjJhNGVlNWE5NWM2MjRlZTM4MTA4NDMiLCJ1c2VyX2lkIjoxfQ.asdf');
    Get.changeTheme(box.read(StorageConstants.THEME)? darkThemeData : ThemeData.light());

    if (await hasRefreshTokenExpired()){
      box.write(StorageConstants.IS_LOGGED_IN, false);
      isLoggedIn.value = false;
    } else{
      DioInterceptor.updateAcessToken();
      box.write(StorageConstants.IS_LOGGED_IN, true);
      isLoggedIn.value = true; 
      //add the interceptor if have a access token
      _dio.instance.interceptors.add(DioInterceptor());
    }
    return this;
  }

  Future<bool> hasRefreshTokenExpired() async{
    String refreshKey = await box.read(StorageConstants.REFRESH_KEYS);
    return DioInterceptor.checkIfTokenIsExpired(refreshKey);
  }

} 