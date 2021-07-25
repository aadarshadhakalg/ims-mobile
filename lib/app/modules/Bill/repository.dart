import 'package:get/get.dart';
import 'package:inventory_management_system/app/data/models/ProductModel.dart';
import 'package:inventory_management_system/core/utils/dio/dio_base.dart';

class BillRepository{
  // fetch productSearch
  static Future<List<ProductModel>> fetchProductSearch(String value) async{
    if(value != ""){
    List<ProductModel> categories = [];
    try{
      var response = await DioSingleton().instance.get('/product/productSearch/$value/');
      for(var e in response.data['results']){
        categories.add(new ProductModel.fromJson(e));
      }
    }catch(e){
      print(e);
    }
    return categories;
  }
    return [];
  }

}