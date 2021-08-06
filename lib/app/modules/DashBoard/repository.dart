import '../../data/models/PopularCategoriesModel.dart';
import '../../data/models/PopularProductModel.dart';
import '../../data/models/ReceiptModel.dart';
import '../../../core/utils/dio/dio_base.dart';

class DashboardRepository {
  // fetch productSearch
  static Future<dynamic> fetchReceipts() async {
    List<ReceiptModel> categories = [];
    try {
      var response = await DioSingleton().instance.get('/product/receipt/');
      for (var e in response.data['results']) {
        categories.add(new ReceiptModel.fromJson(e));
      }
    } catch (e) {
      print(e);
    }
    return categories;
  }

  static Future<dynamic> fetchPopularProducts() async {
    List<PopularProductModel> popularProducts = [];
    try {
      var response =
          await DioSingleton().instance.get('/product/popularProducts/');
      print(response);
      for (var e in response.data['result']) {
        popularProducts.add(new PopularProductModel.fromJson(e));
      }
    } catch (e) {
      print(e);
    }
    return popularProducts;
  }

  static Future<dynamic> fetchPopularCategories() async {
    List<PopularCategoriesModel> popularCategories = [];
    Map<String, dynamic> withTotal = {};
    try {
      var response =
          await DioSingleton().instance.get('/product/popularCategories/');
      print(response);
      for (var e in response.data['result']) {
        popularCategories.add(new PopularCategoriesModel.fromJson(e));
      }
      withTotal['categories'] = popularCategories;
      withTotal['total'] = response.data['total'];
      withTotal['sold'] = response.data['sold'];
    } catch (e) {
      print(e);
    }
    return withTotal;
  }
}
