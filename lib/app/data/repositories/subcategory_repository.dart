import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:inventory_management_system/app/data/models/subcategory.model.dart';
import 'package:inventory_management_system/core/errors/failure.dart';
import 'package:inventory_management_system/core/utils/dio/dio_base.dart';
import 'package:inventory_management_system/core/values/api_constants.dart';

class SubCategoryRepository {
  SubCategoryRepository._internal() {
    dio = DioSingleton().instance;
  }
  static final SubCategoryRepository _instance = SubCategoryRepository._internal();
  factory SubCategoryRepository() => _instance;

  Dio dio;

  Future<Either<SubCategoryModel, Failure>> addSubCategory(
      SubCategoryModel subCategorymodel) async {
    try {
      var response = await dio.post(
        ApiConstants.ADDSUBCATEGORY,
        data: FormData.fromMap(subCategorymodel.toMap()),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        stdout.write(response.data);
        return Left(SubCategoryModel.fromMap(response.data));
      }
    } on DioError catch (e) {
      stdout.write(e);
      return Right(SubCategoryAdditionFailure(e.message));
    }
    return Right(UnknownAppFailure());
  }

  Future<Either<List<SubCategoryModel>, Failure>> listSubCategory() async {
    try {
      var response = await dio.get(ApiConstants.LISTSUBCATEGORY);
      if (response.statusCode == 201 || response.statusCode == 200) {
        stdout.write(response.data);
        return Left(subCategoryModelFromMap(jsonEncode(response.data)));
      }
    } on DioError catch (e) {
      stdout.write(e);
      return Right(SubCategoryListingFailure(e.message));
    }
    return Right(UnknownAppFailure());
  }

  Future<Either<bool, Failure>> deleteSubCategory(String urlSlug) async {
    try {
      var response = await dio.delete(ApiConstants.DELETESUBCATEGORY + '$urlSlug/');
      if (response.statusCode == 204 || response.statusCode == 200) {
        stdout.write(response.data);
        return Left(true);
      }
    } on DioError catch (e) {
      stdout.write(e);
      return Right(SubCategoryDeletionFailure(e.message));
    }
    return Right(UnknownAppFailure());
  }

  Future<Either<SubCategoryModel, Failure>> updateSubCategory(
      SubCategoryModel subSubCategoryModel,String slug) async {
    try {
      var response = await dio.patch(
        ApiConstants.UPDATESUBCATEGORY + '$slug/',
        data: FormData.fromMap(
          subSubCategoryModel.toMap(),
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        stdout.write(response.data);
        return Left(SubCategoryModel.fromMap(response.data));
      }
    } on DioError catch (e) {
      stdout.write(e);

      return Right(SubCategoryUpdateFailure(e.message));
    }
    return Right(UnknownAppFailure());
  }
}
