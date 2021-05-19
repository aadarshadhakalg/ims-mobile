import 'package:dio/dio.dart';
import 'package:inventory_management_system/app/data/services/service.dart';
import 'package:inventory_management_system/core/utils/dio/dio_base.dart';
import 'package:inventory_management_system/core/utils/jwt_base64.dart';
import 'package:inventory_management_system/core/values/api_constants.dart';
import 'package:inventory_management_system/core/values/storage_keys.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class DioInterceptor extends Interceptor{ 

  var _dio = DioSingleton();
  static bool checkIfTokenIsExpired(String jwt){
    var decodedToken = jwtToJSON(jwtConvertString(jwt));
    return checkIfAccessTokenIsExpiredFromJSON(decodedToken);
  }

  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    //is access token expired?
    if (checkIfTokenIsExpired(GetStorage().read(StorageConstants.ACCESS_KEYS))){
      await updateAcessToken(); 
    }
    // even if access token was expired , we now have a new access token
    // Bearer must be in capital letters
    options.headers['authorization'] = 'Bearer ' + GetStorage().read(StorageConstants.ACCESS_KEYS);
    super.onRequest(options, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    if(err.type == DioErrorType.response){
      if(err.response.statusCode == 401){
        _dio.instance.interceptors.requestLock.lock();
        RequestOptions options = err.response.requestOptions;
        await updateAcessToken();
        _dio.instance.interceptors.requestLock.unlock();

        // print(options.headers);
        options.headers['authorization'] = 'Bearer ' + GetStorage().read(StorageConstants.ACCESS_KEYS);
        // Can't pass RequestOptions to dio.request(); so create a new Options widget
        final opt = new Options(
          method: options.method,
          headers: options.headers
        );
         return await _dio.instance.request<dynamic>(options.path, data: options.data, options: opt, queryParameters: options.queryParameters);
      }
    }else{
      print(err);
    }
    super.onError(err, handler);
  }
  
  static Future updateAcessToken() async{
    var refreshData = {
      StorageConstants.REFRESH_KEYS: GetStorage().read(StorageConstants.REFRESH_KEYS) 
    };

    //create a new dio instance. because the old one might be locked
    Dio d = new Dio();
    d.options.baseUrl = ApiConstants.SERVER_URL;

    try{
      var response = await d.post(ApiConstants.NEW_REFRESH_KEYS,data: refreshData);
      GetStorage().write(StorageConstants.ACCESS_KEYS, response.data['access']);
    }catch(err){
      //refresh token has also expired.
      if(err.response?.statusCode == 401){
        GetStorage().write(StorageConstants.IS_LOGGED_IN, false);
        var controller = Get.find<AppConfigService>();
        controller.isLoggedIn.value = false;
        //logout and sorts....
        //implement logout later
      }
    }
    

    
    

  }
  

}