import 'package:get/get.dart';
import '../../data/models/ProductModel.dart';
import '../../../routes/pages.dart';
import 'repository.dart';

class BillPageController extends GetxController {
  var searchQuery = "".obs;
  RxList<RxMap<String, dynamic>> addedProducts =
      RxList<RxMap<String, dynamic>>(<RxMap<String, dynamic>>[]);
//results from searchQuery
  var results = <ProductModel>[].obs;

  void startSearch(String val) {
    print(val);
    searchQuery.value = val;
    BillRepository.fetchProductSearch(searchQuery.value).then((out) {
      results.value = out;
    });
  }

  Future<bool> startQRSearch(String val) async {
    print(val);
    searchQuery.value = val;
    var out = await BillRepository.fetchProductQRSearch(searchQuery.value);
    if (out.isNotEmpty) {
      addProduct(out.first);
      return true;
    }
    return false;
  }

  void addProduct(ProductModel pm) {
    // if product is on the list

    int position = addedProducts
        .indexWhere((element) => element['product'].urlSlug == pm.urlSlug);

    if (position == -1) {
      addedProducts.add({'product': pm, 'value': 1}.obs);
    } else {
      addedProducts[position]['value'] += 1;
    }
  }

  void removeProduct(ProductModel pm) {
    // if product is on the list

    int position =
        addedProducts.indexWhere((element) => element['product'] == pm);
    print(position);

    if (addedProducts[position]['value'] > 1) {
      addedProducts[position]['value'] -= 1;
    } else {
      addedProducts.removeAt(position);
    }
  }

  void generateReceipt() {
    //generate receipt
    Get.toNamed(Routes.RECEIPT, arguments: addedProducts);
  }
}
