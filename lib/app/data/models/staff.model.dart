// To parse this JSON data, do
//
//     final staffModel = staffModelFromMap(jsonString);

import 'dart:convert';

StaffModel staffModelFromMap(String str) =>
    StaffModel.fromMap(json.decode(str));

String staffModelToMap(StaffModel data) => json.encode(data.toMap());

enum UserType {
  AD,
  ST,
  CU,
}

class StaffModel {
  StaffModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Staff> results;

  factory StaffModel.fromMap(Map<String, dynamic> json) => StaffModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<Staff>.from(json["results"].map((x) => Staff.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toMap())),
      };
}

class Staff {
  Staff({
    this.username,
    this.email,
    this.name,
    this.landlineNumber,
    this.mobileNumber,
    this.address,
    this.userType,
    this.createdAt,
  });

  String username;
  String email;
  String name;
  String landlineNumber;
  String mobileNumber;
  String address;
  UserType userType;
  DateTime createdAt;

  factory Staff.fromMap(Map<String, dynamic> json) => Staff(
        username: json["username"],
        email: json["email"],
        name: json["name"],
        landlineNumber: json["Landline_number"],
        mobileNumber: json["mobile_number"],
        address: json["address"],
        userType: json["user_type"] == "AD"
            ? UserType.AD
            : json["user_type"] == "ST"
                ? UserType.ST
                : UserType.CU,
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toMap() => {
        "username": username,
        "email": email,
        "name": name,
        "Landline_number": landlineNumber,
        "mobile_number": mobileNumber,
        "address": address,
        "user_type": userType.toString(),
        "created_at": createdAt.toIso8601String(),
      };
}
