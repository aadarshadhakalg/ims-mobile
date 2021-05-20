import 'package:get/get.dart';

import '../../../core/utils/dio/dio_base.dart';

class DashboardPageController extends GetxController{

  var testApiString = 'this is dashboard'.obs;

  void performTest() async {
    var _dio = DioSingleton();
    try{
      var response = await _dio.instance.get('/test/');
      print(response.data);
      testApiString.value = response.data.toString();
    }catch(err){
      print(err);
    }

  }

}