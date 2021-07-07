import 'package:inventory_management_system/app/data/models/loginModel.dart';
import 'package:inventory_management_system/app/data/models/subcategory.model.dart';
import 'package:inventory_management_system/app/data/repositories/auth_repository.dart';
import 'package:inventory_management_system/app/data/repositories/subcategory_repository.dart';
import 'package:test/test.dart';

main() {
  group(
    'SubCategory Repository Test',
    () {
      SubCategoryRepository repository;
      SubCategoryModel subCategoryTestModel;

      setUpAll(() async {
        repository = SubCategoryRepository();
        subCategoryTestModel = SubCategoryModel.fromMap({
          "category_id": 1,
          "title": "Test Sub category",
          "url_slug": "test_subcat",
          "description": "This is a test subcategory",
          "is_active": 1
        });
        await AuthRepository.instance()
            .login(LoginModel(username: 'adarsha', password: 'adarsha'));
      });

      test(
        'Add Sub Category Test',
        () async {
          await repository.addSubCategory(subCategoryTestModel).then(
                (value) => value.fold(
                  (response) => expect(response.runtimeType, SubCategoryModel),
                  (r) => expect(r, null),
                ),
              );
        },
      );
      test(
        'List Sub Category Test',
        () async {
          await repository.listSubCategory().then(
                (value) => value.fold(
                  (response) =>
                      expect(response[0].runtimeType, SubCategoryModel),
                  (r) => expect(r, null),
                ),
              );
        },
      );
      test(
        'Update Sub Category Test',
        () async {
          subCategoryTestModel.urlSlug = "new_test_subcat_slug";

          await repository
              .updateSubCategory(subCategoryTestModel, 'test_subcat')
              .then(
                (value) => value.fold(
                  (response) => expect(response.urlSlug, "new_test_subcat_slug"),
                  (r) => expect(r, null),
                ),
              );
        },
      );
      test(
        'Delete Sub Category Test',
        () async {
          await repository.deleteSubCategory("new_test_subcat_slug").then(
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
