import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:inventory_management_system/app/data/models/category.model.dart';
import 'package:inventory_management_system/core/errors/failure.dart';
import 'package:inventory_management_system/core/utils/dio/dio_base.dart';
import 'package:inventory_management_system/core/values/api_constants.dart';

class CategoryRepository {
  CategoryRepository._internal() {
    dio = DioSingleton().instance;
  }
  static final CategoryRepository _instance = CategoryRepository._internal();
  factory CategoryRepository() => _instance;

  Dio dio;

  Future<Either<CategoryModel, Failure>> addCategory(
      CategoryModel categorymodel) async {
    try {
      var response = await dio.post(
        ApiConstants.ADDCATEGORY,
        data: FormData.fromMap(categorymodel.toMap()),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        stdout.write(response.data);
        return Left(CategoryModel.fromMap(response.data));
      }
    } on DioError catch (e) {
      stdout.write(e);
      return Right(CategoryAdditionFailure(e.message));
    }
    return Right(UnknownAppFailure());
  }

  Future<Either<List<CategoryModel>, Failure>> listCategory() async {
    try {
      var response = await dio.get(ApiConstants.LISTCATEGORY);
      if (response.statusCode == 201 || response.statusCode == 200) {
        stdout.write(response.data);
        return Left(categoryModelFromMap(jsonEncode(response.data)));
      }
    } on DioError catch (e) {
      stdout.write(e);
      return Right(CategoryListingFailure(e.message));
    }
    return Right(UnknownAppFailure());
  }

  Future<Either<bool, Failure>> deleteCategory(String urlSlug) async {
    try {
      var response = await dio.delete(ApiConstants.DELETECATEGORY + '$urlSlug/');
      if (response.statusCode == 204 || response.statusCode == 200) {
        stdout.write(response.data);
        return Left(true);
      }
    } on DioError catch (e) {
      stdout.write(e);
      return Right(CategoryDeletionFailure(e.message));
    }
    return Right(UnknownAppFailure());
  }

  Future<Either<CategoryModel, Failure>> updateCategory(
      CategoryModel categoryModel,String slug) async {
    try {
      var response = await dio.patch(
        ApiConstants.UPDATECATEGORY + '$slug/',
        data: FormData.fromMap(
          categoryModel.toMap(),
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        stdout.write(response.data);
        return Left(CategoryModel.fromMap(response.data));
      }
    } on DioError catch (e) {
      stdout.write(e);

      return Right(CategoryUpdateFailure(e.message));
    }
    return Right(UnknownAppFailure());
  }
}
