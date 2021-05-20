import 'package:get/get.dart';

import '../../../core/utils/dio/dio_base.dart';

class DashboardPageController extends GetxController{

  var testApiString = 'this is dashboard'.obs;

  Future<void> performTest() async {
    var _dio = DioSingleton();
    
    try{
      var response = await _dio.instance.get('/test/');
      testApiString.value = response.data["message"].toString();
    }catch(err){
      print(err);
    }

  }

}