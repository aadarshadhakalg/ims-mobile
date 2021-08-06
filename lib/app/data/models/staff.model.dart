// To parse this JSON data, do
//
//     final staffModel = staffModelFromMap(jsonString);

import 'dart:convert';

enum UserType {
  AD,
  ST,
  CU,
}

StaffModel staffModelFromMap(String str) =>
    StaffModel.fromMap(json.decode(str));

String staffModelToMap(StaffModel data) => json.encode(data.toMap());

class StaffModel {
  StaffModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  String next;
  String previous;
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
    this.id,
    this.username,
    this.email,
    this.name,
    this.landlineNumber,
    this.password,
    this.password2,
    this.mobileNumber,
    this.address,
    this.pay,
    this.userType,
    this.createdAt,
  });

  int id;
  String username;
  String email;
  String name;
  String landlineNumber;
  String password;
  String password2;
  String mobileNumber;
  String address;
  int pay;
  UserType userType;
  DateTime createdAt;

  factory Staff.fromMap(Map<String, dynamic> json) => Staff(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        name: json["name"],
        landlineNumber: json["Landline_number"],
        password: json['password'],
        password2: json['password2'],
        mobileNumber: json["mobile_number"],
        address: json["address"],
        pay: json["pay"],
        userType: json["user_type"].toString() == "UserType.AD"
            ? UserType.AD
            : json["user_type"].toString() == "UserType.ST"
                ? UserType.ST
                : UserType.ST,
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "username": username,
        "email": email,
        "name": name,
        "Landline_number": landlineNumber,
        "mobile_number": mobileNumber,
        "address": address,
        "password": password,
        "password2": password2,
        "pay": pay,
        "user_type": userType.toString().substring(9),
        "created_at": createdAt?.toIso8601String(),
      };
}
