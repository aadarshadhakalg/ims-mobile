import 'package:inventory_management_system/app/data/models/category.model.dart';
import 'package:inventory_management_system/app/data/models/loginModel.dart';
import 'package:inventory_management_system/app/data/repositories/auth_repository.dart';
import 'package:inventory_management_system/app/data/repositories/category_repository.dart';
import 'package:test/test.dart';

main() {
  group(
    'Category Repository Test',
    () {
      CategoryRepository repository;
      CategoryModel categoryTestModel;

      setUpAll(() async {
        repository = CategoryRepository();
        categoryTestModel = CategoryModel.fromMap({
          "title": "Test Category",
          "url_slug": "test_ctegory",
          "description": "description of test categoty",
          "is_active": 1
        });
        await AuthRepository.instance()
            .login(LoginModel(username: 'adarsha', password: 'adarsha'));
      });

      test(
        'Add Category Test',
        () async {
          await repository.addCategory(categoryTestModel).then(
                (value) => value.fold(
                  (response) => expect(response.runtimeType, CategoryModel),
                  (r) => expect(r, null),
                ),
              );
        },
      );
      test(
        'List Category Test',
        () async {
          await repository.listCategory().then(
                (value) => value.fold(
                  (response) => expect(response[0].runtimeType, CategoryModel),
                  (r) => expect(r, null),
                ),
              );
        },
      );
      test(
        'Update Category Test',
        () async {
          categoryTestModel.urlSlug = "new_slug";

          await repository.updateCategory(categoryTestModel,'test_ctegory').then(
                (value) => value.fold(
                  (response) => expect(response.urlSlug, "new_slug"),
                  (r) => expect(r, null),
                ),
              );
        },
      );
      test(
        'Delete Category Test',
        () async {
          await repository.deleteCategory("new_slug").then(
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
