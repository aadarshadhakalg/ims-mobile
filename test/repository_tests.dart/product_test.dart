import 'package:inventory_management_system/app/data/models/product.model.dart';
import 'package:inventory_management_system/app/data/models/loginModel.dart';
import 'package:inventory_management_system/app/data/repositories/auth_repository.dart';
import 'package:inventory_management_system/app/data/repositories/product_repository.dart';
import 'package:test/test.dart';

main() {
  group(
    'Product Repository Test',
    () {
      ProductRepository repository;
      ProductModel categoryTestModel;

      setUpAll(() async {
        repository = ProductRepository();
        categoryTestModel = ProductModel.fromMap({
          "url_slug": "new_test_product",
          "sub_categories_id": 10,
          "product_name": "New Test Product",
          "brand": "Nepali Brand",
          "product_max_price": "1000",
          "product_discount_price": "900",
          "product_description": "Yo kada product ho",
          "product_long_description":
              "Yo kada product ko laaaaaaaaaaamooooooooo description ho.",
          "total_stock": 5,
          "is_active": 1
        });
        await AuthRepository.instance()
            .login(LoginModel(username: 'adarsha', password: 'adarsha'));
      });

      test(
        'Add Product Test',
        () async {
          await repository.addProduct(categoryTestModel).then(
                (value) => value.fold(
                  (response) => expect(response.runtimeType, ProductModel),
                  (r) => expect(r, null),
                ),
              );
        },
      );
      test(
        'List Product Test',
        () async {
          await repository.listProduct().then(
                (value) => value.fold(
                  (response) => expect(response[0].runtimeType, ProductModel),
                  (r) => expect(r, null),
                ),
              );
        },
      );
      test(
        'Update Product Test',
        () async {
          categoryTestModel.urlSlug = "new_slug";

          await repository
              .updateProduct(categoryTestModel, 'test_ctegory')
              .then(
                (value) => value.fold(
                  (response) => expect(response.urlSlug, "new_slug"),
                  (r) => expect(r, null),
                ),
              );
        },
      );
      test(
        'Delete Product Test',
        () async {
          await repository.deleteProduct("new_slug").then(
                (value) => value.fold(
                  (response) => expect(response, true),
                  (r) => expect(r, null),
                ),
              );
        },
      );
    },
  );
}
