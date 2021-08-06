import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../models/payroll_model.dart';
import '../../../core/errors/failure.dart';
import '../../../core/utils/dio/dio_base.dart';
import '../../../core/values/api_constants.dart';

class PayrollRepository {
  PayrollRepository._internal() {
    dio = DioSingleton().instance;
  }
  static final PayrollRepository _instance = PayrollRepository._internal();
  factory PayrollRepository() => _instance;

  Dio dio;

  Future<Either<PayrollModel, Failure>> listPayments() async {
    print('Called');
    try {
      var response = await dio.get(
        ApiConstants.LISTPAYMENTS,
      );
      print('Called');

      return Left(PayrollModel.fromMap(response.data));
    } on DioError catch (e) {
      stdout.write(e);
      return Right(PayrollListingFailure(e.message));
    }
  }

  Future<Either<bool, Failure>> payStaff(String id) async {
    try {
      var response = await dio.post(
        ApiConstants.PAYSTAFF,
        data: FormData.fromMap(
          {
            'staff': int.parse(id),
          },
        ),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        stdout.write(response.data);
        return Left(true);
      }
    } on DioError catch (e) {
      stdout.write(e);
      return Right(StaffPaymentFailure(e.message));
    }
    return Right(UnknownAppFailure());
  }
}
