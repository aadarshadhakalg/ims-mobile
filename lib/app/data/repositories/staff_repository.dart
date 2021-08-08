import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../models/staff.model.dart';
import '../../../core/errors/failure.dart';
import '../../../core/utils/dio/dio_base.dart';
import '../../../core/values/api_constants.dart';

class StaffRepository {
  StaffRepository._internal() {
    dio = DioSingleton().instance;
  }
  static final StaffRepository _instance = StaffRepository._internal();
  factory StaffRepository() => _instance;

  Dio dio;

  Future<Either<Staff, Failure>> addStaff(Staff staff) async {
    print(staff.toMap());
    try {
      var response = await dio.post(
        ApiConstants.ADDSTAFF,
        data: FormData.fromMap(
          staff.toMap(),
        ),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return Left(Staff.fromMap(response.data));
      }
    } on DioError catch (e) {
      return Right(StaffAdditionFailure(e.message));
    }
    return Right(UnknownAppFailure());
  }

  Future<Either<StaffModel, Failure>> listStaff() async {
    try {
      var response = await dio.get(ApiConstants.LISTSTAFF);
      if (response.statusCode == 201 || response.statusCode == 200) {
        return Left(staffModelFromMap(jsonEncode(response.data)));
      }
    } on DioError catch (e) {
      return Right(StaffListingFailure(e.message));
    }
    return Right(UnknownAppFailure());
  }

  Future<bool> deleteStaff(int id) async {
    try {
      await dio.delete(ApiConstants.DELETESTAFF + '$id/');
      return true;
    } on DioError catch (e) {
      return false;
    }
  }

  Future<Either<Staff, Failure>> updateStaff(Staff staff, String id) async {
    print(staff.toMap()
      ..removeWhere((key, value) =>
          ['id', 'created_at', 'password', 'password2'].contains(key)));
    print(id);
    try {
      var response = await dio.patch(
        ApiConstants.UPDATESTAFF + '$id/',
        data: FormData.fromMap(
          staff.toMap()
            ..removeWhere((key, value) =>
                ['id', 'created_at', 'password', 'password2'].contains(key)),
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return Left(
          Staff.fromMap(response.data),
        );
      }
    } on DioError catch (e) {
      return Right(StaffUpdateFailure(e.message));
    }
    return Right(UnknownAppFailure());
  }
}
