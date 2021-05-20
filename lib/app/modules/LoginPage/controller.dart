import 'package:dio/dio.dart' as dio;
import 'package:inventory_management_system/app/data/models/loginModel.dart';
import 'package:inventory_management_system/app/data/services/service.dart';
import 'package:inventory_management_system/core/utils/dio/dio_base.dart';
import 'package:inventory_management_system/core/utils/dio/interceptor.dart';
import 'package:inventory_management_system/core/values/api_constants.dart';
import 'package:inventory_management_system/core/values/storage_keys.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:inventory_management_system/routes/pages.dart';

class LoginPageController  extends GetxController {
  DioSingleton _dio = DioSingleton();

  var username = ''.obs;
  var password = ''.obs;

  void onUsernameChanged(String val){
    username.value = val;
  }

  void onPasswordChanged(String val){
    password.value = val;
  }

  void onSubmitPress() async{
      var loginModel = LoginModel(username: this.username.value, password: this.password.value);
      var storageBox = GetStorage();
      var response;
      try{
        response = await _dio.instance.post(ApiConstants.LOGIN, data : dio.FormData.fromMap(loginModel.toJSON()));
        storageBox.write(StorageConstants.ACCESS_KEYS, response.data['access']);
        storageBox.write(StorageConstants.REFRESH_KEYS, response.data['refresh']);
        
        _dio.instance.interceptors.add(DioInterceptor());

        Get.find<AppConfigService>().isLoggedIn.value = true;
        storageBox.write(StorageConstants.IS_LOGGED_IN, true);

        Get.offAndToNamed(Routes.DASHBOARD);
        

      }catch(err){
        print(err);
        print('username or password error');
      }


      //handle Authentication;

  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

}
