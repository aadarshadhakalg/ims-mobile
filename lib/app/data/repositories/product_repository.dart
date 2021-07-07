import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:inventory_management_system/app/data/models/product.model.dart';
import 'package:inventory_management_system/core/errors/failure.dart';
import 'package:inventory_management_system/core/utils/dio/dio_base.dart';
import 'package:inventory_management_system/core/values/api_constants.dart';

class ProductRepository {
  ProductRepository._internal() {
    dio = DioSingleton().instance;
  }
  static final ProductRepository _instance = ProductRepository._internal();
  factory ProductRepository() => _instance;

  Dio dio;

  Future<Either<ProductModel, Failure>> addProduct(
      ProductModel productmodel) async {
    try {
      var response = await dio.post(
        ApiConstants.ADDPRODUCT,
        data: FormData.fromMap(
          productmodel.toMap(),
        ),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        stdout.write(response.data);
        return Left(ProductModel.fromMap(response.data));
      }
    } on DioError catch (e) {
      stdout.write(e.requestOptions.headers);
      return Right(ProductAdditionFailure(e.message));
    }
    return Right(UnknownAppFailure());
  }

  Future<Either<List<ProductModel>, Failure>> listProduct() async {
    try {
      var response = await dio.get(ApiConstants.LISTPRODUCT);
      if (response.statusCode == 201 || response.statusCode == 200) {
        stdout.write(response.data);
        return Left(productModelFromMap(jsonEncode(response.data)));
      }
    } on DioError catch (e) {
      stdout.write(e);
      return Right(ProductListingFailure(e.message));
    }
    return Right(UnknownAppFailure());
  }

  Future<Either<bool, Failure>> deleteProduct(String urlSlug) async {
    try {
      var response =
          await dio.delete(ApiConstants.DELETEPRODUCT + '$urlSlug/');
      if (response.statusCode == 204 || response.statusCode == 200) {
        stdout.write(response.data);
        return Left(true);
      }
    } on DioError catch (e) {
      stdout.write(e);
      return Right(ProductDeletionFailure(e.message));
    }
    return Right(UnknownAppFailure());
  }

  Future<Either<ProductModel, Failure>> updateProduct(
      ProductModel categoryModel, String slug) async {
    try {
      var response = await dio.patch(
        ApiConstants.UPDATEPRODUCT + '$slug/',
        data: FormData.fromMap(
          categoryModel.toMap(),
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        stdout.write(response.data);
        return Left(ProductModel.fromMap(response.data));
      }
    } on DioError catch (e) {
      stdout.write(e);

      return Right(ProductUpdateFailure(e.message));
    }
    return Right(UnknownAppFailure());
  }
}
